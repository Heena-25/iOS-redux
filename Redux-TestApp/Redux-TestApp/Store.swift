//
//  Store.swift
//  Redux-TestApp
//
//  Created by Heena Mujawar on 25/05/26.
//

final class Store: ObservableObject {
    @Published private(set) var state: AppState
    private let reducer: (AppState, TaskAction) -> AppState
    private var middlewares: [Middleware]

    init(
        initialState: AppState,
        reducer: @escaping (AppState, TaskAction) -> AppState,
        middlewares: [Middleware] = []
    ) {
        self.state = initialState
        self.reducer = reducer
        self.middlewares = middlewares
    }

    func dispatch(_ action: TaskAction) {
        let baseDispatch: (TaskAction) -> Void = { [weak self] action in
            guard let self = self else { return }
            self.state = self.reducer(self.state, action)
        }

        let chain = middlewares.reversed().reduce(baseDispatch) { nextDispatch, middleware in
            middleware(self.state, nextDispatch)
        }

        chain(action)
    }
}
