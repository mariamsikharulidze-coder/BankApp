
import XCTest

final class EasyBankSteps {

    private let app: XCUIApplication
    private let page: EasyBankPage

    init(app: XCUIApplication) {
        self.app = app
        self.page = EasyBankPage(app: app)
    }

   

    private func tap(_ element: XCUIElement) {
        guard element.waitForExistence(timeout: 15) else {
            XCTFail("Element was not found: \(element)")
            return
        }

        guard element.isHittable else {
            XCTFail("Element is not hittable: \(element)")
            return
        }

        element.tap()
    }

    private func enterText(
        _ text: String,
        into element: XCUIElement
    ) {
        guard element.waitForExistence(timeout: 15) else {
            XCTFail("Text field was not found")
            return
        }

        element.tap()

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

        if closeButton.waitForExistence(timeout: 2),
           closeButton.isHittable {
            closeButton.tap()
        }
    }

    private func enterRegistrationSecureText(
        _ password: String,
        into field: XCUIElement
    ) {
        guard field.waitForExistence(timeout: 15) else {
            XCTFail("Registration password field was not found")
            return
        }

        field.tap()
        dismissStrongPasswordPromptIfNeeded()

        guard field.isHittable else {
            XCTFail("Registration password field is not hittable")
            return
        }

        
        if let currentValue = field.value as? String,
           !currentValue.isEmpty,
           currentValue != field.placeholderValue {

            let deleteKeys = String(
                repeating: XCUIKeyboardKey.delete.rawValue,
                count: currentValue.count
            )

            field.typeText(deleteKeys)
        }

        
        for character in password {
            field.typeText(String(character))
        }

        XCTAssertTrue(
            field.exists,
            "Password field disappeared after typing"
        )
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

        guard error.waitForExistence(timeout: 15) else {
            XCTFail("Login error was not displayed")
            return
        }

        XCTAssertTrue(
            error.label.localizedCaseInsensitiveContains(expected),
            "Expected '\(expected)' in error: \(error.label)"
        )
    }

    //   Registration

    func enterRegistrationEmail(_ email: String) {
        enterText(email, into: page.registrationEmailField)
    }

    func enterRegistrationPassword(_ password: String) {
        enterRegistrationSecureText(
            password,
            into: page.registrationPasswordField
        )
    }

    func enterRepeatPassword(_ password: String) {
        enterRegistrationSecureText(
            password,
            into: page.registrationRepeatPasswordField
        )
    }

    func submitRegistration() {
        tap(page.registrationSubmitButton)
    }

    func register(email: String, password: String) {
        enterRegistrationEmail(email)
        enterRegistrationPassword(password)
        enterRepeatPassword(password)

        submitRegistration()

        if !page.sendMoneyButton.waitForExistence(timeout: 20) {
            let registrationError = page.registrationErrorMessage

            if registrationError.exists {
                XCTFail(
                    "Registration failed: \(registrationError.label)"
                )
            } else {
                XCTFail(
                    "Registration did not navigate to Home. UI: \(app.debugDescription)"
                )
            }
        }
    }

    //  Home

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

    // Logout

    func logout() {
        tap(page.logoutButton)

        guard page.logoutAlert.waitForExistence(timeout: 10) else {
            XCTFail("Logout confirmation was not displayed")
            return
        }

        tap(page.confirmLogoutButton)
    }

    func assertLoginDisplayed() {
        XCTAssertTrue(
            page.loginEmailField.waitForExistence(timeout: 10),
            "Login screen was not displayed"
        )
    }
}
