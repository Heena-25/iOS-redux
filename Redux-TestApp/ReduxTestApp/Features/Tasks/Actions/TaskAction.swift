import Foundation

enum TaskAction {
    case fetchTasksStarted
    case fetchTasksSucceeded(tasks: [Task])
    case fetchTasksFailed(error: String)
    case addTask(title: String)
    case toggleTask(id: UUID)
    case deleteTask(id: UUID)
    case setFilter(TaskFilter)
    case clearError
}
