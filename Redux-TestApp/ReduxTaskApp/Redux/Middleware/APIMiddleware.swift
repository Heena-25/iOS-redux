import Foundation

func apiMiddleware(taskService: TaskServiceProtocol) -> Middleware {
    return { state, dispatch in
        return { action in
            switch action {
            case .fetchTasksStarted:
                dispatch(action)
                Task {
                    do {
                        let tasks = try await taskService.fetchTasks()
                        dispatch(.fetchTasksSucceeded(tasks: tasks))
                    } catch {
                        dispatch(.fetchTasksFailed(error: error.localizedDescription))
                    }
                }
            default:
                dispatch(action)
            }
        }
    }
}
