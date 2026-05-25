import XCTest
import Combine
@testable import ReduxTaskApp

final class StoreTests: XCTestCase {

    var store: Store!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        store = Store(initialState: .initial, reducer: taskReducer)
    }

    func test_dispatch_updatesState() {
        store.dispatch(.addTask(title: "Test Task"))
        XCTAssertEqual(store.state.tasks.count, 1)
        XCTAssertEqual(store.state.tasks[0].title, "Test Task")
    }

    func test_dispatch_multipleActions_updatesStateSequentially() {
        store.dispatch(.addTask(title: "Task 1"))
        store.dispatch(.addTask(title: "Task 2"))
        store.dispatch(.addTask(title: "Task 3"))
        XCTAssertEqual(store.state.tasks.count, 3)
    }

    func test_statePublished_notifiesOnChange() {
        let expectation = XCTestExpectation(description: "State updated")
        store.$state
            .dropFirst()
            .sink { state in
                if state.tasks.count == 1 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        store.dispatch(.addTask(title: "Published Task"))
        wait(for: [expectation], timeout: 1.0)
    }
}
