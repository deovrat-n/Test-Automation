*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN_URL}             http://localhost:5173/
${USERNAME}              testuser1
${PASSWORD}              admin
${BROWSER}               Chrome
${TIMEOUT}               10s

# --- LOCATORS ---
${LOGIN_USERNAME_FIELD}    xpath=//label[normalize-space()='Username']/following-sibling::div[1]//input
${LOGIN_PASSWORD_FIELD}    xpath=//label[normalize-space()='Password']/following-sibling::div[1]//input
${LOGIN_BUTTON}            xpath=//button[normalize-space()='Login']

${STOCK_NAME_ELEMENT}      xpath=//p[contains(text(), 'RELIANCE INDUSTRIES LTD')]
${ADD_TO_PORTFOLIO_BUTTON}     xpath=//p[contains(text(), 'RELIANCE INDUSTRIES LTD')]/ancestor::div[contains(@class, 'MuiListItem-root')]//button[normalize-space()='Add to Portfolio']
${POPUP_OK_BUTTON}         xpath=//button[normalize-space()='OK']
${PORTFOLIO_BUTTON}        xpath=//button[normalize-space()='Portfolio']
# --- END LOCATORS ---

*** Test Cases ***
Login And Add Stock To Portfolio
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window

    # Login
    Wait Until Page Contains Element    ${LOGIN_USERNAME_FIELD}    timeout=${TIMEOUT}
    Input Text    ${LOGIN_USERNAME_FIELD}    ${USERNAME}
    Input Password    ${LOGIN_PASSWORD_FIELD}    ${PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Log    Logged in successfully.

    # Locate Stock Name
    Wait Until Page Contains Element    ${STOCK_NAME_ELEMENT}    timeout=${TIMEOUT}
    Log    Found stock: Reliance Industries Ltd.

    # Click "Add to Portfolio"
    Wait Until Page Contains Element    ${ADD_TO_PORTFOLIO_BUTTON}    timeout=${TIMEOUT}
    Click Button    ${ADD_TO_PORTFOLIO_BUTTON}
    Log    Clicked "Add to Portfolio" for Reliance Industries Ltd.

    # Handle Popup
    Wait Until Page Contains Element    ${POPUP_OK_BUTTON}    timeout=${TIMEOUT}
    Click Button    ${POPUP_OK_BUTTON}
    Log    Clicked OK on confirmation popup.

    # Navigate to Portfolio
    Wait Until Page Contains Element    ${PORTFOLIO_BUTTON}    timeout=${TIMEOUT}
    Click Button    ${PORTFOLIO_BUTTON}
    Log    Navigated to Portfolio page.

    # Stay for 10 seconds
    Sleep    10s

    Close Browser
