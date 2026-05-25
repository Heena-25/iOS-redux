import Foundation

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
        let trimmed = title.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { break }
        let task = Task(title: trimmed)
        newState.tasks.append(task)

    case .toggleTask(let id):
        if let index = newState.tasks.firstIndex(where: { $0.id == id }) {
            newState.tasks[index].isCompleted.toggle()
        }

    case .deleteTask(let id):
        newState.tasks.removeAll { $0.id == id }

    case .setFilter(let filter):
        newState.selectedFilter = filter

    case .clearError:
        newState.errorMessage = nil
    }

    return newState
}
