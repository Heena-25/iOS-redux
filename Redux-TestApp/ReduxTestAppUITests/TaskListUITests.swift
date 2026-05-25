import XCTest

final class TaskListUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UI_TESTING"]
        app.launch()
    }

    func test_taskListScreen_isVisible() {
        XCTAssertTrue(app.navigationBars["My Tasks"].exists)
    }

    func test_addTask_appearsInList() {
        app.navigationBars["My Tasks"].buttons["Add"].tap()
        let textField = app.textFields["e.g. Review pull request"]
        XCTAssertTrue(textField.waitForExistence(timeout: 2))
        textField.tap()
        textField.typeText("UI Test Task")
        app.navigationBars.buttons["Add"].tap()
        XCTAssertTrue(app.staticTexts["UI Test Task"].waitForExistence(timeout: 2))
    }
}
