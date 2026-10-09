
import XCTest

class BaseClass: XCTestCase {

    private(set) var app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        launchApp()
    }

    private func launchApp() {
        app = XCUIApplication()
        app.launchArguments.append("UI-Testing")
        app.launch()
    }

    func relaunchApp() {
        app.terminate()
        launchApp()
    }
}
