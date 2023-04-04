//
//  AppConfigration.swift
//  Test
//
//  Created by muslim mirzajonov on 15/06/22.
//
import Foundation
import UIKit
import CoreLocation
import SystemConfiguration
import CoreTelephony

class AppConfigration {
    
    let apiBaseURLForMe: String = ""
    
    let imagePicker = UIImagePickerController()
    
   static private let allowedDiskSize = 10 * 1048 * 1048
    static var cache: URLCache = {
        return URLCache(memoryCapacity: 0, diskCapacity: allowedDiskSize, diskPath: "requestCache")
        
    }()
    
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
    
    
    lazy var apiDataTransferServiceForMe: DataTransferService = {
        if let token = Consts.defaults.string(forKey: Consts.tokenKey){
            
            let config = ApiDataNetworkConfig(baseURL: URL(string: apiBaseURLForMe)!,
                                           headers:[
                                             "Content-Type":"application/json; charset=utf-8",
                                             "Authorization":token
                                           ]
                                           
                                        )
            
            
            let apiDataNetwork = DefaultNetworkService(config: config)
            return DefaultDataTransferService(with: apiDataNetwork)
           }
        
        
        let config = ApiDataNetworkConfig(baseURL: URL(string: apiBaseURLForMe)!,
                                       headers:["Content-Type":"application/json; charset=utf-8"]
        )
        
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)

    }()


    
    lazy var apiDataTransferService: DataTransferService = {
        if let token = Consts.defaults.string(forKey: Consts.tokenKey){
            
            print("Firebase_TESTING \(token)")
            let config = ApiDataNetworkConfig(baseURL: URL(string: apiBaseURL)!,
                                              headers:[
                                                "Content-Type":"application/json; charset=utf-8",
                                                "Authorization":token
                                              ]
                                              
            )
            
            
            let apiDataNetwork = DefaultNetworkService(config: config)
            return DefaultDataTransferService(with: apiDataNetwork)
        }
        
        
        print("Firebase_TESTING ")
        let config = ApiDataNetworkConfig(baseURL: URL(string: apiBaseURL)!,
                                          headers:["Content-Type":"application/json; charset=utf-8"])
        
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)

    }()
    
    
    
    
    let deviceName=UIDevice.modelName
    let bateryLevel=UIDevice.current.batteryLevel
    let cellarLevel = 1
    let networkType=getConnectionType()
    
    
    func isLocationServiceEnabled() -> Bool {
               if CLLocationManager.locationServicesEnabled() {
                   switch(CLLocationManager.authorizationStatus()) {
                       case .notDetermined, .restricted, .denied:
                       return false
                       case .authorizedAlways, .authorizedWhenInUse:
                       return true
                       default:
                       print("Something wrong with Location services")
                       return false
                   }
               } else {
                       print("Location services are not enabled")
                       return false
               }
        }
    
    
    class func getConnectionType() -> String {
            guard let reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, "www.google.com") else {
                return "NO INTERNET"
            }

            var flags = SCNetworkReachabilityFlags()
            SCNetworkReachabilityGetFlags(reachability, &flags)

            let isReachable = flags.contains(.reachable)
            let isWWAN = flags.contains(.isWWAN)

            if isReachable {
                if isWWAN {
                    let networkInfo = CTTelephonyNetworkInfo()
                    let carrierType = networkInfo.serviceCurrentRadioAccessTechnology

                    guard let carrierTypeName = carrierType?.first?.value else {
                        return "UNKNOWN"
                    }

                    switch carrierTypeName {
                    case CTRadioAccessTechnologyGPRS, CTRadioAccessTechnologyEdge, CTRadioAccessTechnologyCDMA1x:
                        return "2G"
                    case CTRadioAccessTechnologyLTE:
                        return "4G"
                    default:
                        return "3G"
                    }
                } else {
                    return "WIFI"
                }
            } else {
                return "NO INTERNET"
            }
        }
        
    
}


