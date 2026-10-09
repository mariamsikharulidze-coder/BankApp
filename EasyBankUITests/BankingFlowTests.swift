
import XCTest

final class BankingFlowTests: BaseClass {

    private var steps: EasyBankSteps!

    override func setUpWithError() throws {
        try super.setUpWithError()
        steps = EasyBankSteps(app: app)
    }

    // MARK: - Test 1: Invalid Email Format

    func testInvalidEmailFormat() {
        let invalidEmail = "invalid-email"
        let password = "TestPassword123!"

        steps.openLogin()
        steps.login(
            email: invalidEmail,
            password: password
        )

        steps.assertLoginErrorContains("badly formatted")
    }

    // MARK: - Test 2: Invalid Login Credentials

    func testInvalidLoginCredentials() {
        let email = "notregistered-\(UUID().uuidString)@example.com"
        let password = "TestPassword123!"

        steps.openLogin()
        steps.login(
            email: email,
            password: password
        )

        steps.assertLoginErrorContains("malformed or has expired")
    }

    // MARK: - Test 3: Register, Logout and Login

    func testRegisterLogoutAndLogin() {
        let email = "easybank-\(UUID().uuidString)@example.com"
        let password = "TestPassword123!"

        steps.openRegistration()

        steps.register(
            email: email,
            password: password
        )

        steps.assertHomeDisplayed()

        steps.logout()
        steps.assertLoginDisplayed()

        steps.login(
            email: email,
            password: password
        )

        steps.assertHomeDisplayed()
    }
}
