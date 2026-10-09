
import XCTest

final class EasyBankPage {

    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }



    var onboardingLoginButton: XCUIElement {
        app.buttons["onboarding.login"]
    }

    var onboardingRegisterButton: XCUIElement {
        app.buttons["onboarding.register"]
    }


    var loginEmailField: XCUIElement {
        app.textFields["login.email"]
    }

    var loginPasswordField: XCUIElement {
        app.secureTextFields["login.password"]
    }

    var loginSubmitButton: XCUIElement {
        app.buttons["login.submit"]
    }

    var loginRegisterButton: XCUIElement {
        app.buttons["login.register"]
    }

    var loginErrorMessage: XCUIElement {
        app.staticTexts["login.error"]
    }



    var registrationEmailField: XCUIElement {
        app.textFields["registration.email"]
    }

    var registrationPasswordField: XCUIElement {
        app.secureTextFields["registration.password"]
    }

    var registrationRepeatPasswordField: XCUIElement {
        app.secureTextFields["registration.repeatPassword"]
    }

    var registrationSubmitButton: XCUIElement {
        app.buttons["registration.submit"]
    }

    var registrationLoginButton: XCUIElement {
        app.buttons["registration.login"]
    }

    var registrationErrorMessage: XCUIElement {
        app.staticTexts["registration.error"]
    }



    var homeTab: XCUIElement {
        app.tabBars.buttons["Home"]
    }

    var sendMoneyButton: XCUIElement {
        app.buttons["home.sendMoney"]
    }

    var logoutButton: XCUIElement {
        app.buttons["home.logout"]
    }


    var logoutAlert: XCUIElement {
        app.alerts["Logging Out"]
    }

    var confirmLogoutButton: XCUIElement {
        logoutAlert.buttons["Yes"]
    }

    var cancelLogoutButton: XCUIElement {
        logoutAlert.buttons["No"]
    }

    var closePasswordPromptButton: XCUIElement {
        app.buttons["Close"]
    }
}
