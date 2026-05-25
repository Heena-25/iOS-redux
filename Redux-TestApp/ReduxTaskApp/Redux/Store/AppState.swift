import Foundation

struct AppState: Equatable {
    var tasks: [Task]
    var isLoading: Bool
    var errorMessage: String?
    var selectedFilter: TaskFilter

    static let initial = AppState(
        tasks: [],
        isLoading: false,
        errorMessage: nil,
        selectedFilter: .all
    )
}
