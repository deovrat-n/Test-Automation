*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}              http://localhost:5173/
${USERNAME}         testuser1
${PASSWORD}         admin
${BROWSER}          Chrome
${TIMEOUT}          10s

# --- LOCATORS ---
${USERNAME_FIELD}    xpath=//label[normalize-space()='Username']/following-sibling::div[1]//input
${PASSWORD_FIELD}    xpath=//label[normalize-space()='Password']/following-sibling::div[1]//input
${LOGIN_BUTTON}      xpath=//button[normalize-space()='Login']
# --- END LOCATORS ---

*** Test Cases ***
Login User Using SeleniumLibrary Keywords
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    # Wait for the username field
    Wait Until Page Contains Element    ${USERNAME_FIELD}    timeout=${TIMEOUT}
    Log    Username field found. Proceeding with input.
    Input Text    ${USERNAME_FIELD}    ${USERNAME}

    # Wait for the password field
    Log    Entering password.
    Wait Until Page Contains Element    ${PASSWORD_FIELD}    timeout=${TIMEOUT}
    Input Password    ${PASSWORD_FIELD}    ${PASSWORD}

    # Wait for the login button to be clickable
    Wait Until Element Is Visible    ${LOGIN_BUTTON}    timeout=${TIMEOUT}
    Wait Until Element Is Enabled    ${LOGIN_BUTTON}    timeout=${TIMEOUT}
    Click Button    ${LOGIN_BUTTON}

    # Verify successful login
    # Example: Wait for "Dashboard" or "Welcome" text (Adjust according to your app)
    Wait Until Page Contains    Dashboard    timeout=${TIMEOUT}
    Log    Login successful, Dashboard page loaded.

    Close Browser

*** Keywords ***
# No custom keywords needed for this example
