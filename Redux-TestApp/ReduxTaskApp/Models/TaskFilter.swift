import Foundation

enum TaskFilter: String, CaseIterable, Equatable {
    case all       = "All"
    case active    = "Active"
    case completed = "Completed"
}
