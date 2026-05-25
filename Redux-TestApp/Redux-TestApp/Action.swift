//
//  Action.swift
//  Redux-TestApp
//
//  Created by Heena Mujawar on 25/05/26.
//

enum TaskAction {
    case fetchTasksStarted
    case fetchTasksSucceeded(tasks: [Task])
    case fetchTasksFailed(error: String)
    case addTask(title: String)
    case toggleTask(id: UUID)
    case deleteTask(id: UUID)
    case setFilter(TaskFilter)
}
