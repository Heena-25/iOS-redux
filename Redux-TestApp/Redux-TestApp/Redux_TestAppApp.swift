//
//  Redux_TestAppApp.swift
//  Redux-TestApp
//
//  Created by Heena Mujawar on 25/05/26.
//

import SwiftUI

@main
struct Redux_TestAppApp: App {
    let store = Store(
        initialState: AppState(
            tasks: [],
            isLoading: false,
            errorMessage: nil,
            selectedFilter: .all
        ),
        reducer: taskReducer,
        middlewares: [
            loggingMiddleware(),
            apiMiddleware(taskService: TaskService())
        ]
    )

    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environmentObject(store)
        }
    }
}
