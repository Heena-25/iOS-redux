import XCTest
@testable import ReduxTaskApp

final class TaskReducerTests: XCTestCase {

    var initialState: AppState!

    override func setUp() {
        super.setUp()
        initialState = .initial
    }

    // MARK: - Add Task

    func test_addTask_appendsNewTask() {
        let newState = taskReducer(state: initialState, action: .addTask(title: "Learn Redux"))
        XCTAssertEqual(newState.tasks.count, 1)
        XCTAssertEqual(newState.tasks[0].title, "Learn Redux")
        XCTAssertFalse(newState.tasks[0].isCompleted)
    }

    func test_addTask_ignoresBlankTitle() {
        let newState = taskReducer(state: initialState, action: .addTask(title: "   "))
        XCTAssertTrue(newState.tasks.isEmpty)
    }

    // MARK: - Toggle Task

    func test_toggleTask_setsCompleted() {
        let task = Task(title: "Buy groceries")
        var state = initialState!
        state.tasks = [task]
        let newState = taskReducer(state: state, action: .toggleTask(id: task.id))
        XCTAssertTrue(newState.tasks[0].isCompleted)
    }

    func test_toggleTask_unsetsCompleted() {
        let task = Task(title: "Buy groceries", isCompleted: true)
        var state = initialState!
        state.tasks = [task]
        let newState = taskReducer(state: state, action: .toggleTask(id: task.id))
        XCTAssertFalse(newState.tasks[0].isCompleted)
    }

    func test_toggleTask_unknownId_doesNothing() {
        let task = Task(title: "Buy groceries")
        var state = initialState!
        state.tasks = [task]
        let newState = taskReducer(state: state, action: .toggleTask(id: UUID()))
        XCTAssertFalse(newState.tasks[0].isCompleted)
    }

    // MARK: - Delete Task

    func test_deleteTask_removesTask() {
        let task = Task(title: "Delete me")
        var state = initialState!
        state.tasks = [task]
        let newState = taskReducer(state: state, action: .deleteTask(id: task.id))
        XCTAssertTrue(newState.tasks.isEmpty)
    }

    // MARK: - Fetch Tasks

    func test_fetchTasksStarted_setsLoading() {
        let newState = taskReducer(state: initialState, action: .fetchTasksStarted)
        XCTAssertTrue(newState.isLoading)
        XCTAssertNil(newState.errorMessage)
    }

    func test_fetchTasksSucceeded_populatesTasksAndClearsLoading() {
        var state = initialState!
        state.isLoading = true
        let tasks = [Task(title: "Fetched task")]
        let newState = taskReducer(state: state, action: .fetchTasksSucceeded(tasks: tasks))
        XCTAssertFalse(newState.isLoading)
        XCTAssertEqual(newState.tasks.count, 1)
        XCTAssertEqual(newState.tasks[0].title, "Fetched task")
    }

    func test_fetchTasksFailed_setsErrorAndClearsLoading() {
        var state = initialState!
        state.isLoading = true
        let newState = taskReducer(state: state, action: .fetchTasksFailed(error: "Network error"))
        XCTAssertFalse(newState.isLoading)
        XCTAssertEqual(newState.errorMessage, "Network error")
    }

    // MARK: - Filter

    func test_setFilter_updatesFilter() {
        let newState = taskReducer(state: initialState, action: .setFilter(.completed))
        XCTAssertEqual(newState.selectedFilter, .completed)
    }

    // MARK: - Clear Error

    func test_clearError_removesErrorMessage() {
        var state = initialState!
        state.errorMessage = "Some error"
        let newState = taskReducer(state: state, action: .clearError)
        XCTAssertNil(newState.errorMessage)
    }
}
