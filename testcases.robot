*** Settings ***
Resource    keywords.robot
Test Teardown   Close The Test

*** Test Cases ***
Login and logout
    [Documentation]     Login to netbank and then logout
	Login to OP     fi
    #Logout from OP

#Ajokomennot

#Ajaa kaikki:
#robot --outputdir C:\Users\esaha\Desktop\lokit testcases.robot
#robot --outputdir C:\Users\esaha\Desktop\lokit -v ENV:Production -v BROWSER:chrome -v USERNAME:78541833 testcases.robot

#Ajaa yhden testin:
#robot --outputdir C:\Users\esaha\Desktop\lokit -v ENV:Production -v BROWSER:chrome -v USERNAME:78541833 -t "Login and logout" testcases.robot
