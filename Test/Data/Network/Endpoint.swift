//
//  Endpoint.swift
//  DashBoardManagment
//
//  Created by muslim mirzajonov on 05/05/22.
//

import Foundation

public enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public enum BodyEncoding {
    case jsonSerializationData
    case stringEncodingAscii
}

public class Endpoint<R>: ResponseRequestable {
    
    
    public typealias Response = R
    
    public let path: String
    public let isFullPath: Bool
    public let isFromInspection: Bool
    public let method: HTTPMethodType
    public let headerParamaters: [String: String]
    public let queryParametersEncodable: Encodable?
    public let queryParameters: [String: Any]
    public let bodyParamatersEncodable: Encodable?
    public let bodyParamatersEncodableList: [Encodable]?
    public let bodyParamaters: [String: Any]
    public let bodyEncoding: BodyEncoding
    public let responseDecoder: ResponseDecoder
    public let fileData:[FileModel]

    public let boundary: String
    
    init(path: String,
         isFullPath: Bool = false,
         isFromInspection:Bool=false,
         method: HTTPMethodType,
         headerParamaters: [String: String] = [:],
         queryParametersEncodable: Encodable? = nil,
         queryParameters: [String: Any] = [:],
         bodyParamatersEncodable: Encodable? = nil,
         bodyParamatersEncodableList: [Encodable]? = nil,
         bodyParamaters: [String: Any] = [:],
         bodyEncoding: BodyEncoding = .jsonSerializationData,
         responseDecoder: ResponseDecoder = JSONResponseDecoder(),
         fileData:[FileModel]=[],
         boundry:String=UUID().uuidString) {
        self.path = path
        self.isFullPath = isFullPath
        self.isFromInspection=isFromInspection
        self.method = method
        self.headerParamaters = headerParamaters
        self.queryParametersEncodable = queryParametersEncodable
        self.queryParameters = queryParameters
        self.bodyParamatersEncodable = bodyParamatersEncodable
        self.bodyParamatersEncodableList = bodyParamatersEncodableList
        self.bodyParamaters = bodyParamaters
        self.bodyEncoding = bodyEncoding
        self.responseDecoder = responseDecoder
        self.fileData = fileData
        self.boundary = boundry
    }
}

public protocol Requestable {
    var path: String { get }
    var isFullPath: Bool { get }
    var isFromInspection: Bool { get }
    var method: HTTPMethodType { get }
    var headerParamaters: [String: String] { get }
    var queryParametersEncodable: Encodable? { get }
    var queryParameters: [String: Any] { get }
    var bodyParamatersEncodable: Encodable? { get }
    var bodyParamatersEncodableList: [Encodable]? { get }
    var bodyParamaters: [String: Any] { get }
    var bodyEncoding: BodyEncoding { get }
    var fileData: [FileModel] { get }
    var boundary: String { get }
    
    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
    
    func uploadFile(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

public protocol ResponseRequestable: Requestable {
    associatedtype Response
    
    var responseDecoder: ResponseDecoder { get }
}

enum RequestGenerationError: Error {
    case components
}

extension Requestable {
    
    public func uploadFile(with config: NetworkConfigurable)throws -> URLRequest{
        let url = try self.urlComponents(with: config)
        let httpBody = NSMutableData()
        var request = URLRequest(url: url.url!)
        
        httpBody.append(dataFormFieldForArray( mimeType: "image/jpeg"))
        request.httpMethod = method.rawValue
        var allHeaders: [String: String]=[:]
        
        if let token = Consts.defaults.string(forKey: Consts.tokenKey){
             allHeaders = [
                            "Authorization":token,
                            "Content-Type":"multipart/form-data; boundary=\(boundary)",
                            "Content-Length":"\(httpBody.length)"
                        ]
            headerParamaters.forEach { allHeaders.updateValue($1, forKey: $0) }
        }
//        httpBody.append("--\(boundary)--")
        request.allHTTPHeaderFields=allHeaders
        request.httpBody = httpBody as Data
        
        return request
    }
    
    
    private func dataFormFieldForArray(mimeType: String) -> Data {
        let fieldData = NSMutableData()

        for uploadingData in fileData {
            let fileName=uploadingData.fileName.isEmpty ? "document" : uploadingData.fileName
            
            fieldData.append("--\(boundary)\r\n")

            if isFromInspection {
                fieldData.append("Content-Disposition: form-data; name=\"files\"; filename=\(fileName)\r\n")
            }else{
                fieldData.append("Content-Disposition: form-data; name=\"file\"; filename=\(fileName)\r\n")
            }

            fieldData.append("Content-Type: \(mimeType)\r\n")
            fieldData.append("\r\n")
            fieldData.append(uploadingData.fileData)
            fieldData.append("\r\n")
        }

        return fieldData as Data
    }

    
    func urlComponents(with config: NetworkConfigurable) throws -> URLComponents {

        let baseURL = config.baseURL.absoluteString.last != "/" ? config.baseURL.absoluteString + "/" : config.baseURL.absoluteString
        let endpoint = isFullPath ? path : baseURL.appending(path)
        
        guard var urlComponents = URLComponents(string: endpoint) else { throw RequestGenerationError.components }
        var urlQueryItems = [URLQueryItem]()

        let queryParameters = try queryParametersEncodable?.toDictionary() ?? self.queryParameters
        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        config.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
//        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return urlComponents
    }
    
    
    func url(with config: NetworkConfigurable) throws -> URL {

        let baseURL = config.baseURL.absoluteString.last != "/" ? config.baseURL.absoluteString + "/" : config.baseURL.absoluteString
        let endpoint = isFullPath ? path : baseURL.appending(path)
        
        guard var urlComponents = URLComponents(string: endpoint) else { throw RequestGenerationError.components }
        var urlQueryItems = [URLQueryItem]()

        let queryParameters = try queryParametersEncodable?.toDictionary() ?? self.queryParameters
        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        config.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }
    
    public func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        var allHeaders: [String: String] = config.headers
        headerParamaters.forEach { allHeaders.updateValue($1, forKey: $0) }
        if ((bodyParamatersEncodableList?.isEmpty) != nil) {
            var bodyParamList:[[String:Any]]=[]
            for body in bodyParamatersEncodableList! {
                bodyParamList.append(try body.toDictionary() ?? [:])
            }
            let body=encodeBodyList(bodyParamaters: bodyParamList, bodyEncoding: bodyEncoding)
            
            guard let body=body else {
                urlRequest.httpMethod = method.rawValue
                urlRequest.allHTTPHeaderFields = allHeaders
                return urlRequest
            }
            urlRequest.httpBody = body

        }else{
            let bodyParamaters = try bodyParamatersEncodable?.toDictionary() ?? self.bodyParamaters
            if !bodyParamaters.isEmpty {
                let body = encodeBody(bodyParamaters: bodyParamaters, bodyEncoding: bodyEncoding)
                guard let body=body else {
                    urlRequest.httpMethod = method.rawValue
                    urlRequest.allHTTPHeaderFields = allHeaders
                    return urlRequest
                }
                urlRequest.httpBody = body
            }
        }

        
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
    
    private func encodeBody(bodyParamaters: [String: Any], bodyEncoding: BodyEncoding) -> Data? {
        switch bodyEncoding {
        case .jsonSerializationData:
            return try? JSONSerialization.data(withJSONObject: bodyParamaters)
        case .stringEncodingAscii:
            return bodyParamaters.queryString.data(using: String.Encoding.ascii, allowLossyConversion: true)
        }
    }
    
    private func encodeBodyList(bodyParamaters: [[String: Any]], bodyEncoding: BodyEncoding) -> Data? {
        switch bodyEncoding {
        case .jsonSerializationData:
           let newValue = try? JSONSerialization.data(withJSONObject: bodyParamaters)
            return newValue
        case .stringEncodingAscii:
            return Data()
        }
    }
    

}

private extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let josnData = try JSONSerialization.jsonObject(with: data)
        let jsonNew = josnData as? [String : Any]
        
        return jsonNew
    }
}




