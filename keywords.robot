*** Settings ***
Resource    variables.robot
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary

*** Keywords ***

Login to OP
    [Arguments]    ${language}   ${browser}=${BROWSER}  ${username}=${USERNAME}    ${password}=1234     ${PIN}=1234
    [Documentation]    Login to S-pankki with username and password
    Open OP homepage    ${language}    ${browser}
    Input username / password and login    ${username}    ${password}
    Run Keyword If    '${ENV}' != 'Production'     Insert PIN code   ${PIN}
    Wait Until Page Contains Element     xpath=//*[@id="checkingAccountsTable"]/tbody/tr[1]/td[1]/a    15s     #Tilit (ensimmäinen)
    Page Should Contain Element  xpath=//*[@id="checkingAccountsTable"]/tbody/tr[1]/td[1]     #Tilinomistaja (ensimmäinen)
    Page Should Contain Element  xpath=//*[@id="checkingAccountsTable"]/tbody/tr[1]/td[2]     #Käytettävissä (ensimmäinen)
    Page Should Contain Element  xpath=//*[@id="checkingAccountsTable"]/tbody/tr[1]/td[3]     #Yhteensä
    ${selected_language}=      Run Keyword And Return Status      Page Should Contain     Kirjauduit verkkopalveluun edellisen kerran
    Log    Valittu kieli ${selected_language} ja language on ${language}
    Run Keyword If    '${selected_language}' == 'False' and '${language}' == 'fi'    Change the language to  ${language}
    ...     ELSE IF   '${selected_language}' == 'True' and '${language}' == 'sv'    Change the language to  ${language}
    Set Test Variable    ${language}
    Go to Etusivu
    Page Should Contain Element    id=mybank                #Etusivu
	
	
Open OP homepage
    [Arguments]  ${language}     ${browser}
    Run Keyword If    '${log_test}' == 'Yes'    Log    \nOpen S-pankki homepage using ${browser} and change language to ${language}    console=True
    Run Keyword If    '${ENV}' == 'Test1'    Open browser and go to     ${URL_TEST1}    ${browser}
    ...         ELSE IF     '${ENV}' == 'Production'    Open browser and go to     ${URL_PROD}    ${browser}
    ...         ELSE     Fail     Environment was not Test1, Test2, Test3, Test4, Staging or Production - it was ${ENV}. Please, insert the correct environment variable.
    Wait Until Page Contains Element    id=username    #Käyttäjätunnus
    ${selected_language}=      Run Keyword And Return Status      Page Should Contain     Käyttäjätunnus
    Run Keyword If    '${selected_language}' == 'False' and '${language}' == 'fi'    Click Element   xpath=//a[contains(text(), 'Suomeksi')]
    ...     ELSE IF   '${selected_language}' == 'True' and '${language}' == 'sv'    Click Element    xpath=//a[contains(text(), 'På svenska')]
    Set Test Variable    ${language}
    Run Keyword If   '${language}' == 'fi'     Wait Until Page Contains    Kirjaudu verkkopankkiin
    ...     ELSE IF  '${language}' == 'sv'     Wait Until Page Contains    Logga in på webbanken
    ...     ELSE      Fail    Language was '${language}', but should be 'fi' or 'sv'

Open browser and go to
    [Arguments]    ${url}    ${selain}
    Run Keyword If    '${log_test}' == 'Yes'    Log    Open ${url}    console=True
    Open Browser    ${url}   ${selain}
    Maximize Browser Window

Input username / password and login
    [Arguments]    ${username}    ${password}
    Run Keyword If    '${log_test}' == 'Yes'    Log    Login with username ${username}   console=True
    Wait Until Page Contains Element    id=username     15s
    Input Text    id=username    ${username}
    Input Password    id=password    ${password}
    Click Element    xpath=//*[@name="btn_log_in"]/span/span    #Login button

Close The Test
    [Documentation]  Done atter the test closes
    Run Keyword If    '${log_test}' == 'Yes'    Log    Ending the test and takes a screenshot, if the test fails    console=True
    Run Keyword If Test Failed     Capture Page Screenshot
    Close All Browsers


