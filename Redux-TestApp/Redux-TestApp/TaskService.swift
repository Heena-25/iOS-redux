//
//  TaskService.swift
//  Redux-TestApp
//
//  Created by Heena Mujawar on 25/05/26.
//


// MARK: - Task Service (Mock)

class TaskService {
    func fetchTasks() async throws -> [Task] {
        // Simulate network delay
        try await _Concurrency.Task.sleep(nanoseconds: 1_000_000_000)
        return [
            Task(id: UUID(), title: "Buy groceries", isCompleted: false),
            Task(id: UUID(), title: "Read Swift docs", isCompleted: true),
            Task(id: UUID(), title: "Build Redux app", isCompleted: false),
            Task(id: UUID(), title: "Write unit tests", isCompleted: false),
        ]
    }
}
