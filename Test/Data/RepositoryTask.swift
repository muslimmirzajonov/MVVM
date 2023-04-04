//
//  RepositoryTask.swift
//  DashBoardManagment
//
//  Created by muslim mirzajonov on 05/05/22.
//

import Foundation
class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}

