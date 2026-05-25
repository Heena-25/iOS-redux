import SwiftUI

@main
struct ReduxTaskApp: App {
    let store = Store(
        initialState: .initial,
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
