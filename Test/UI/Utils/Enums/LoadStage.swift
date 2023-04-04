//
//  LoadStage.swift
//  DashBoardManagment
//
//  Created by muslim mirzajonov on 08/05/22.
//

import Foundation

enum LoadStage:String{
    case LOAD_PLANNING="Load planning"
    case TRANSIT="Transit"
    case HISTORY="History"
}
enum LiveStage:String{
    case TRUCKS="Trucks"
    case TRAILERS="Trailers"
    case DRIVERS="Drivers"
}

enum HomeStage:String{
    case TODAY="Today"
    case YESTERDAY="Yesterday"
    case LAST_WEEK="Last week"
    case LAST_MONTH="Last month"
}

enum MapStage:String{
    case CURRENT="CURRENT"
    case STOP="STOP"
    case MOTION="MOTION"
}


