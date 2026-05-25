import Foundation

final class TaskService: TaskServiceProtocol {
    func fetchTasks() async throws -> [Task] {
        // Simulate network delay
        try await _Concurrency.Task.sleep(nanoseconds: 1_000_000_000)
        return [
            Task(title: "Buy groceries"),
            Task(title: "Read Swift docs", isCompleted: true),
            Task(title: "Build Redux app"),
            Task(title: "Write unit tests"),
            Task(title: "Publish Hashnode article"),
        ]
    }
}
