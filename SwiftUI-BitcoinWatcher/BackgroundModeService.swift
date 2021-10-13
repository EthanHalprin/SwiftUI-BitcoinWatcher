//
//  BackgroundModeService.swift
//  SwiftUI-BitcoinWatcher
//
//  Created by Ethan on 13/10/2021.
//

import Foundation
import BackgroundTasks

class BackgroundModeService {
    
    private var key = String()

    required init(key: String) {
        self.key = key
        register()
    }
    
    func register() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: key,
                                        using: nil) { task in
             self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }
    
    func scheduleAppRefresh() {
       let request = BGAppRefreshTaskRequest(identifier: key)
       // Fetch no earlier than 15 minutes from now.
       request.earliestBeginDate = Date(timeIntervalSinceNow: 5)
            
       do {
          try BGTaskScheduler.shared.submit(request)
       } catch {
          print("Could not schedule app refresh: \(error)")
       }
    }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        // Schedule a new refresh task.
        scheduleAppRefresh()

        // Create an operation that performs the main part of the background task.
        let operation = BlockOperation {
            var result = 0
            for i in 1...1000 {
                result += i
                if result % 100 == 0 {
                    print("================BGAppRefreshTask (\(result))========================")
                }
            }
        }
 
        // Provide the background task with an expiration handler that cancels the operation.
        task.expirationHandler = {
            operation.cancel()
        }

        // Inform the system that the background task is complete
        // when the operation completes.
        operation.completionBlock = {
            task.setTaskCompleted(success: !operation.isCancelled)
        }

        // Start the operation.
        let operationQueue = OperationQueue()
        operationQueue.addOperation(operation)
     }
    
}
