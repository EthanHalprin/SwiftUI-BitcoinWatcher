//
//  SwiftUI_BitcoinWatcherApp.swift
//  SwiftUI-BitcoinWatcher
//
//  Created by Ethan on 13/10/2021.
//

import SwiftUI
import BackgroundTasks


@main
struct SwiftUI_BitcoinWatcherApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    let key = "com.bitcoin.watcher"

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
           if phase == .active {
               print("App: Enter Active.")
           }
           if phase == .background {
               print("App: Enter Background.")
               scheduleAppRefresh()
           }
        }
    }
    
    init() {
        registerAppRefreshTask()
    }
    
    func registerAppRefreshTask() {
        let registerResult = BGTaskScheduler.shared.register(forTaskWithIdentifier: key,
                                        using: nil) { task in
             self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        if registerResult {
            print("BGTaskScheduler register AppRefresh OK")
        } else {
            print("Could not register an AppRefresh")
        }
    }
    
    func scheduleAppRefresh() {
       let request = BGAppRefreshTaskRequest(identifier: key)
       // Fetch no earlier than 5 seconds from now.
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
