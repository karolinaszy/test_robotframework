*** Settings ***
Library    SeleniumLibrary
Documentation    Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}            https://scouts-test.futbolkolektyw.pl/en
${BROWSER}              Chrome
${EMAILINPUT}           xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${SIGNINBUTTON}         xpath=//*[text()='Sign in']
${PAGELOGO}             xpath=//*[@id='__next']//div[3]/div[1]/div/div[1]
${SIGNOUTBUTTON}        xpath=//*[text()='Sign out']
${SCOUTSPANELLABEL}     xpath=//*[text()='Scouts Panel']
${ADDAPLAYERBUTTON}     xpath=//*/div[2]//div//button/span[1]
${NAMEINPUT}            xpath=//*[@name='name']
${SURNAMEINPUT}         xpath=//*[@name='surname']
${AGEINPUT}             xpath=//*[@name='age']
${MAINPOSITIONINPUT}    xpath=//*[@name='mainPosition']
${SUBMITPLAYERBUTTON}   xpath=//*[@id='__next']//div[3]/button[1]
${PLAYERSBUTTON}        xpath=//*//ul[1]/div[2]/div[2]/span
${POLSKIBUTTON}         xpath=//*[text()='Polski']
${DODAJBRACZABUTTON}    xpath=//*[text()='Dodaj gracza']
${PLAYERSTOOLBAR}       xpath=//*[@role="toolbar"]
${ENGLISHLOGIN BUTTON}  xpath=//*[@id='__next']//div[2]/div/div
${POLISHLOGIN BUTTON}   xpath=//*[@id='menu-']//li[1]

*** Test Cases ***
LOGIN TO THE SYSTEM
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert dashboard
    [Teardown]  Close browser

LOGOUT OF THE SYSTEM
    Open Login Page
    Type in email
    Type in password
    Click on the Sign in button
    Click on the Sign out button
    Assert Login Page
    [Teardown]  Close browser

ADD A NEW PLAYER
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Open dashboard
    Click on the Add a player button
    Type in name
    Type in surname
    Type in age
    Type in main position
    Click on the Submit button
    [Teardown]    Close browser

REDIRECT TO THE PLAYERS PAGE
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Open dashboard
    Click on the Players button
    Assert players page
    [Teardown]    Close browser

CHANGE HOMEPAGE LANGUAGE
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Open dashboard
    Click on the Polski button
    Assert polish page
    [Teardown]    Close browser

CHANGE LOGIN LANGUAGE
    Open Login Page
    Click on the English button
    Click on the Polish button
    Assert polish login page
    [Teardown]    Close browser


*** Keywords ***
Open login page
    Open browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be                     Scouts panel - sign in
Type in email
    Input Text      ${EMAILINPUT}       user04@getnada.com
Type in password
    Input Text      ${PASSWORDINPUT}    Test-1234
Click on the Sign in button
    Click Element       //*[text()='Sign in']
Assert dashboard
    wait until element is visible   ${PAGELOGO}
    title should be                     Scouts panel
    Capture Page Screenshot             alert_login.png
Click on the Sign out button
    Click Element       //*[text()='Sign out']
Assert Login Page
    wait until element is visible       ${SCOUTSPANEL LABEL}
    title should be     Scouts panel - sign in
    Capture Page Screenshot             alert_logout.png
Open dashboard
    wait until element is visible       ${PAGELOGO}
Click on the Add a player button
    Click Element       //*/div[2]//div//button/span[1]
Type in name
    Input Text      ${NAMEINPUT}    Karolina
Type in surname
    Input Text      ${SURNAMEINPUT}      Szybiak
Type in age
    Input Text      ${AGEINPUT}      01.01.1901
Type in main position
    Input Text      ${MAINPOSITIONINPUT}      goalkeeper
Click on the Submit button
    Click Element       //*[@id='__next']//div[3]/button[1]
    Capture Page Screenshot             alert_addaplayer.png
Click on the Players button
    Click Element       //*//ul[1]/div[2]/div[2]/span
Assert players page
    Wait Until Element Is Visible       ${PLAYERSTOOLBAR}
    Capture Page Screenshot             alert_redirect.png
Click on the Polski button
    Click Element       //*[text()='Polski']
Assert polish page
    Wait Until Element Is Visible       ${DODAJBRACZABUTTON}
    title should be     Scouts panel
    Capture Page Screenshot             alert_homepage_language.png
Click on the English button
    Click Element       //*[@id='__next']//div[2]/div/div
Click on the Polish button
    Click Element       //*[@id='menu-']//li[1]
Assert polish login page
    Wait Until Element Is Visible       ${SCOUTSPANELLABEL}
    title should be     Scouts panel - zaloguj
    Capture Page Screenshot             alert_login_language.png