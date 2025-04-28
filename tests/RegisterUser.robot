*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}              http://localhost:5173/register
${USERNAME}         testuser
${PASSWORD}         testpassword
${CONFIRM_PASSWORD}    testpassword
${BROWSER}          Chrome
${TIMEOUT}          10s

# --- NEW LOCATORS ---
# Use XPath to find the input based on its preceding label's text
${USERNAME_FIELD}       xpath=//label[normalize-space()='Username']/following-sibling::div[1]//input
${PASSWORD_FIELD}       xpath=//label[normalize-space()='Password']/following-sibling::div[1]//input
${CONFIRM_PASS_FIELD}  xpath=//label[normalize-space()='Confirm Password']/following-sibling::div[1]//input

# Button Locator (assuming the text is 'Register') - Keep this robust option
${REGISTER_BUTTON}      xpath=//button[normalize-space()='Register']
# --- END NEW LOCATORS ---

*** Test Cases ***
Register New User Using SeleniumLibrary Keywords
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    # Wait for the username field
    Wait Until Page Contains Element    ${USERNAME_FIELD}    timeout=${TIMEOUT}
    Log    Username field found. Proceeding with input.
    Input Text        ${USERNAME_FIELD}       ${USERNAME}

    # --- CORRECTED PASSWORD INPUT ---
    Log    Entering password.
    Wait Until Page Contains Element    ${PASSWORD_FIELD}    timeout=${TIMEOUT}
    Input Password    ${PASSWORD_FIELD}       ${PASSWORD} # Use Input Password
    # --- END CORRECTION ---

    # --- CORRECTED CONFIRM PASSWORD INPUT ---
    Log    Entering confirm password.
    Wait Until Page Contains Element    ${CONFIRM_PASS_FIELD}    timeout=${TIMEOUT}
    Input Password    ${CONFIRM_PASS_FIELD}   ${CONFIRM_PASSWORD} # Use Input Password
    # --- END CORRECTION ---

    # Wait for the button to be clickable
    Wait Until Element Is Visible    ${REGISTER_BUTTON}    timeout=${TIMEOUT}
    Wait Until Element Is Enabled    ${REGISTER_BUTTON}    timeout=${TIMEOUT}
    Click Button      ${REGISTER_BUTTON}

    # Optional: Increase sleep ONLY for debugging if needed, remove for final version
    # Sleep    5s

    # Verify redirection by waiting for an element/text on the Login page
    # Ensure 'Login' is actually present on the success/redirect page.
    # If the registration fails, this wait will time out, failing the test as expected.
    Wait Until Page Contains    Login    timeout=${TIMEOUT}  # Adjust 'Login' if the success indicator is different
    Log    Registration successful, redirected to Login page.

    Close Browser

*** Keywords ***
# No custom keywords needed for this example