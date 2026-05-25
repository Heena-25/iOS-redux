import Foundation
import Combine

final class Store: ObservableObject {
    @Published private(set) var state: AppState
    private let reducer: (AppState, TaskAction) -> AppState
    private var middlewares: [Middleware]

    init(
        initialState: AppState = .initial,
        reducer: @escaping (AppState, TaskAction) -> AppState = taskReducer,
        middlewares: [Middleware] = []
    ) {
        self.state = initialState
        self.reducer = reducer
        self.middlewares = middlewares
    }

    func dispatch(_ action: TaskAction) {
        let baseDispatch: (TaskAction) -> Void = { [weak self] action in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.state = self.reducer(self.state, action)
            }
        }

        let chain = middlewares.reversed().reduce(baseDispatch) { nextDispatch, middleware in
            middleware(self.state, nextDispatch)
        }

        chain(action)
    }
}
