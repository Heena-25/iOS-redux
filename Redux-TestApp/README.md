# ReduxTaskApp

A production-ready SwiftUI task manager built with Redux architecture.

## Architecture

```
View → dispatches Action → Reducer → new State → View updates
```

### Core components

| Component | File | Responsibility |
|-----------|------|----------------|
| `AppState` | Redux/Store/AppState.swift | Single source of truth |
| `Store` | Redux/Store/Store.swift | Holds state, dispatches actions |
| `TaskAction` | Features/Tasks/Actions/TaskAction.swift | All possible state changes |
| `taskReducer` | Features/Tasks/Reducers/TaskReducer.swift | Pure state transition function |
| `APIMiddleware` | Redux/Middleware/APIMiddleware.swift | Async network calls |
| `LoggingMiddleware` | Redux/Middleware/LoggingMiddleware.swift | Debug action logging |

## Folder structure

```
ReduxTaskApp/
├── App/
│   └── ReduxTaskApp.swift          # @main entry point
├── Redux/
│   ├── Store/
│   │   ├── Store.swift
│   │   └── AppState.swift
│   └── Middleware/
│       ├── Middleware.swift
│       ├── APIMiddleware.swift
│       └── LoggingMiddleware.swift
├── Features/
│   └── Tasks/
│       ├── Actions/
│       │   └── TaskAction.swift
│       ├── Reducers/
│       │   └── TaskReducer.swift
│       └── Views/
│           ├── TaskListView.swift
│           ├── TaskRow.swift
│           ├── AddTaskView.swift
│           └── FilterPickerView.swift
├── Models/
│   ├── Task.swift
│   └── TaskFilter.swift
└── Services/
    ├── TaskServiceProtocol.swift
    └── TaskService.swift

ReduxTaskAppTests/
├── TaskReducerTests.swift
├── StoreTests.swift
└── MockTaskService.swift

ReduxTaskAppUITests/
└── TaskListUITests.swift
```

## Setup

1. Clone the repo
2. Open `ReduxTaskApp.xcodeproj` in Xcode 15+
3. Run on simulator (iOS 16+)

## Running tests

```
Cmd + U
```

## Key design decisions

- **Flat state struct** — easy to copy, compare, and debug
- **Protocol-based service** — `TaskServiceProtocol` enables `MockTaskService` in tests
- **Middleware chain** — logging + API middleware are composable and order-dependent
- **`DispatchQueue.main.async` in Store** — ensures `@Published` updates always fire on main thread

## Written about in

[Implementing Redux architecture in iOS with Swift](https://heena.hashnode.dev)
