
import XCTest

final class EasyBankSteps {

    private let app: XCUIApplication
    private let page: EasyBankPage

    init(app: XCUIApplication) {
        self.app = app
        self.page = EasyBankPage(app: app)
    }


    private func tap(_ element: XCUIElement) {
        XCTAssertTrue(
            element.waitForExistence(timeout: 10),
            "Element was not found"
        )
        XCTAssertTrue(
            element.isHittable,
            "Element is not hittable"
        )
        element.tap()
    }

    private func enterText(
        _ text: String,
        into element: XCUIElement
    ) {
        tap(element)

        if let currentValue = element.value as? String,
           !currentValue.isEmpty,
           currentValue != element.placeholderValue {

            let deleteKeys = String(
                repeating: XCUIKeyboardKey.delete.rawValue,
                count: currentValue.count
            )
            element.typeText(deleteKeys)
        }

        element.typeText(text)
    }

    private func dismissStrongPasswordPromptIfNeeded() {
        let closeButton = page.closePasswordPromptButton

        if closeButton.exists && closeButton.isHittable {
            closeButton.tap()
        }
    }

    

    func openLogin() {
        tap(page.onboardingLoginButton)
    }

    func openRegistration() {
        tap(page.onboardingRegisterButton)
    }

    

    func enterLoginEmail(_ email: String) {
        enterText(email, into: page.loginEmailField)
    }

    func enterLoginPassword(_ password: String) {
        enterText(password, into: page.loginPasswordField)
    }

    func submitLogin() {
        tap(page.loginSubmitButton)
    }

    func login(email: String, password: String) {
        enterLoginEmail(email)
        enterLoginPassword(password)
        submitLogin()
    }

    func assertLoginErrorContains(_ expected: String) {
        let error = page.loginErrorMessage

        XCTAssertTrue(
            error.waitForExistence(timeout: 15),
            "Login error was not displayed"
        )

        XCTAssertTrue(
            error.label.localizedCaseInsensitiveContains(expected),
            "Expected '\(expected)' in error: \(error.label)"
        )
    }



    func enterRegistrationEmail(_ email: String) {
        enterText(email, into: page.registrationEmailField)
    }

    func enterRegistrationPassword(_ password: String) {
        tap(page.registrationPasswordField)
        dismissStrongPasswordPromptIfNeeded()

        if page.registrationPasswordField.isHittable {
            page.registrationPasswordField.typeText(password)
        }
    }

    func enterRepeatPassword(_ password: String) {
        tap(page.registrationRepeatPasswordField)
        dismissStrongPasswordPromptIfNeeded()

        if page.registrationRepeatPasswordField.isHittable {
            page.registrationRepeatPasswordField.typeText(password)
        }
    }

    func submitRegistration() {
        tap(page.registrationSubmitButton)
    }

    func register(email: String, password: String) {
        enterRegistrationEmail(email)
        enterRegistrationPassword(password)
        enterRepeatPassword(password)
        submitRegistration()
    }



  func assertHomeDisplayed() {
    let sendMoney = page.sendMoneyButton
    let homeTab = page.homeTab

    if !sendMoney.waitForExistence(timeout: 20) {
        _ = homeTab.waitForExistence(timeout: 5)
    }

    XCTAssertTrue(
        sendMoney.exists || homeTab.exists,
        "Home screen was not displayed. UI: \(app.debugDescription)"
    )
}


    func logout() {
        tap(page.logoutButton)

        XCTAssertTrue(
            page.logoutAlert.waitForExistence(timeout: 10),
            "Logout confirmation was not displayed"
        )

        tap(page.confirmLogoutButton)
    }

    func assertLoginDisplayed() {
        XCTAssertTrue(
            page.loginEmailField.waitForExistence(timeout: 10),
            "Login screen was not displayed"
        )
    }
}
