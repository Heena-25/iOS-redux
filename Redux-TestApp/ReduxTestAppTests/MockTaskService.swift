import Foundation
@testable import ReduxTaskApp

final class MockTaskService: TaskServiceProtocol {
    var mockTasks: [Task] = [
        Task(title: "Mock Task 1"),
        Task(title: "Mock Task 2", isCompleted: true)
    ]
    var shouldThrow = false
    var fetchCallCount = 0

    func fetchTasks() async throws -> [Task] {
        fetchCallCount += 1
        if shouldThrow {
            throw URLError(.notConnectedToInternet)
        }
        return mockTasks
    }
}
