//
//  State.swift
//  Redux-TestApp
//
//  Created by Heena Mujawar on 25/05/26.
//

struct AppState {
    var tasks: [Task]
    var isLoading: Bool
    var errorMessage: String?
    var selectedFilter: TaskFilter
}
