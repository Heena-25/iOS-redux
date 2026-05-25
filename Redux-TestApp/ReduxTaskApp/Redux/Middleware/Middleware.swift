import Foundation

typealias Middleware = (AppState, @escaping (TaskAction) -> Void) -> (TaskAction) -> Void
