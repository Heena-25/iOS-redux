//
//  Middleware.swift
//  Redux-TestApp
//
//  Created by Heena Mujawar on 25/05/26.
//

class Reducer {
    func taskReducer(state: AppState, action: TaskAction) -> AppState {
        var newState = state

        switch action {
        case .fetchTasksStarted:
            newState.isLoading = true
            newState.errorMessage = nil

        case .fetchTasksSucceeded(let tasks):
            newState.tasks = tasks
            newState.isLoading = false

        case .fetchTasksFailed(let error):
            newState.errorMessage = error
            newState.isLoading = false

        case .addTask(let title):
            let task = Task(id: UUID(), title: title, isCompleted: false)
            newState.tasks.append(task)

        case .toggleTask(let id):
            if let index = newState.tasks.firstIndex(where: { $0.id == id }) {
                newState.tasks[index].isCompleted.toggle()
            }

        case .deleteTask(let id):
            newState.tasks.removeAll { $0.id == id }

        case .setFilter(let filter):
            newState.selectedFilter = filter
        }

        return newState
    }

    // MARK: - Middleware

    typealias Middleware = (AppState, @escaping (TaskAction) -> Void) -> (TaskAction) -> Void

    func apiMiddleware(taskService: TaskService) -> Middleware {
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

    func loggingMiddleware() -> Middleware {
        return { state, dispatch in
            return { action in
                #if DEBUG
                print("→ Action: \(action)")
                #endif
                dispatch(action)
            }
        }
    }

}
