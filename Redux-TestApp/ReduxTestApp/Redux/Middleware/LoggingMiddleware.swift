import Foundation

func loggingMiddleware() -> Middleware {
    return { state, dispatch in
        return { action in
            #if DEBUG
            print("→ [Redux] Action: \(action)")
            #endif
            dispatch(action)
            #if DEBUG
            print("→ [Redux] State after: \(state)")
            #endif
        }
    }
}
