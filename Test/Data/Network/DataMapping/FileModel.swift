//
//  FileModel.swift
//  DashBoardManagment
//
//  Created by muslim mirzajonov on 05/05/22.
//

import Foundation
public struct FileModel {
    var fileName:String
    var fileData:Data
    
    init(){
        fileName=""
        fileData=Data()
    }
    
    init(fileName:String, fileData:Data) {
        self.fileName=fileName
        self.fileData=fileData
    }
    
    
}
