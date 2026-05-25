import Foundation

protocol TaskServiceProtocol {
    func fetchTasks() async throws -> [Task]
}
