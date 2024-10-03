*** Settings ***
Library         AppiumLibrary
Library         BuiltIn
Library         Dialogs
Variables       data.py

**Variables**
${localhost}=                   http://localhost:4723/wd/hub            

*** Test Cases ***
Open Test Application
    Open Application       ${localhost}      platformName=android        deviceName=emulator-5554         newCommandTimeout=600       appPackage=com.example.smart_view        appActivity=com.example.smart_view.MainActivity    automationName=UiAutomator2

Wait for Main Page to Appear
    Wait Until Page Contains Element        //android.view.View[@content-desc="SmartView"]              100

Enter Forget Password Page
    Wait Until Page Contains Element         //android.view.View[@content-desc="Forgot Password?"]       100
    Click Element                           //android.view.View[@content-desc="Forgot Password?"]
    Wait Until Page Contains                ${forgetpasswordtitle}                100
    Page Should Contain Element             //*[@class="android.widget.Button"][@index="0"]
    Page Should Contain Element             //android.view.View[@content-desc="SmartView"]
    Page Should Contain Element             //*[@class="android.widget.ImageView"][@index="1"]
    Page Should Contain Element             //*[@class="android.widget.EditText"][@index="3"]
    Click Element                           //*[@class="android.widget.EditText"][@index="3"]
    Input Text                              //*[@class="android.widget.EditText"][@index="3"]           test@gmail.com
    Sleep                                   1
    
Submit Email To Next Page
    Click Element                           //android.widget.Button[@content-desc="Reset my password"]
    Wait Until Page Contains                ${forgetpasswordconfirmationtitle}                          100
    Page Should Contain Element             //android.view.View[@content-desc="SmartView"]
    Page Should Contain Element             //*[@class="android.widget.ImageView"][@index="1"]
    
Return Back to Login Page
    Click Element                           //android.widget.Button[@content-desc="Back to login"]
    Wait Until Page Contains Element        //android.view.View[@content-desc="SmartView"]              100
    Page Should Contain Element             //*[@class="android.widget.ImageView"][@index="1"]
    Page Should Contain Element             //*[@class="android.widget.EditText"][@index="2"]
    Page Should Contain Element             //*[@class="android.widget.EditText"][@index="3"]
    Click Element                           //*[@class="android.widget.EditText"][@index="2"]
    Input Text                              //*[@class="android.widget.EditText"][@index="2"]           test
    Sleep                                   1
    Click Element                           //*[@class="android.widget.EditText"][@index="3"]
    Input Text                              //*[@class="android.widget.EditText"][@index="3"]           test123
    Sleep                                   1

Navigate to Main Page
    Click Element                           //android.widget.Button[@content-desc="Sign In"]
    Wait Until Page Contains Element        xpath=(//*[@class="android.view.View"][@index="0"])[6]            100
    Page Should Contain Element             xpath=(//*[@class="android.view.View"][@index="3"])[1]           
    Page Should Contain Element             xpath=(//*[@class="android.view.View"][@index="4"])
    Page Should Contain Element             xpath=(//*[@class="android.view.View"][@index="5"]) 
    Page Should Contain Element             xpath=(//*[@class="android.widget.Button"][@index="1"])[1]
    Page Should Contain Element             xpath=(//*[@class="android.widget.Button"][@index="2"])[1]
    Page Should Contain Element             xpath=(//*[@class="android.widget.Button"][@index="1"])[2]
    Page Should Contain Element             xpath=(//*[@class="android.widget.Button"][@index="2"])[2]
    Page Should Contain Element             xpath=(//*[@class="android.view.View"][@index="0"])[8]

Enter Settings Page
    Click Element                           xpath=(//*[@class="android.widget.Button"][@index="1"])[1]
    Wait Until Page Contains Element        xpath=(//*[@class="android.view.View"][@index="0"])[7]            100
    Page Should Contain Element             xpath=(//*[@class="android.widget.Button"][@index="0"])
    Page Should Contain Element             xpath=(//*[@class="android.view.View"][@index="2"])
    Page Should Contain Element             xpath=(//*[@class="android.view.View"][@index="5"])
    Page Should Contain Element             xpath=(//*[@class="android.view.View"][@index="8"])
    Page Should Contain Element             xpath=(//*[@class="android.view.View"][@index="3"])
    Page Should Contain Element             xpath=(//*[@class="android.view.View"][@index="6"])
    Page Should Contain Element             xpath=(//*[@class="android.view.View"][@index="9"])

Enter Settings Account
    Click Element                           xpath=(//*[@class="android.view.View"][@index="2"])
    Wait Until Page Contains Element        xpath=(//*[@class="android.view.View"][@index="0"])[7]            100
    Page Should Contain Element             xpath=(//*[@class="android.view.View"][@index="2"])
    Page Should Contain Element             xpath=(//*[@class="android.view.View"][@index="3"])

Return to Main Page  
    Click Element                           xpath=(//*[@class="android.widget.Button"][@index="0"])
    Wait Until Page Contains Element        xpath=(//*[@class="android.view.View"][@index="0"])[6]            100

Click into Ongoing Tab
    Click Element                           xpath=(//*[@class="android.view.View"][@index="4"])
    Wait Until Page Contains Element        xpath=(//*[@class="android.view.View"][@index="0"])[8]            100
    
Click into Completed Tab
    Click Element                           xpath=(//*[@class="android.view.View"][@index="5"])
    Wait Until Page Contains Element        xpath=(//*[@class="android.view.View"][@index="0"])[8]            100

Click Sort Tab
    Click Element                           xpath=(//*[@class="android.widget.Button"][@index="1"])[2]
    Wait Until Page Contains Element        xpath=(//*[@class="android.view.View"][@index="1"])[1]            100
    Page Should Contain Element             xpath=(//*[@class="android.widget.RadioButton"][@index="2"])
    Page Should Contain Element             xpath=(//*[@class="android.widget.RadioButton"][@index="3"])
    Page Should Contain Element             xpath=(//*[@class="android.widget.RadioButton"][@index="4"])
    Page Should Contain Element             xpath=(//*[@class="android.widget.RadioButton"][@index="5"])

Click Filter Tab    
    Click Element                           xpath=(//*[@class="android.widget.Button"][@index="0"])
    Click Element                           xpath=(//*[@class="android.widget.Button"][@index="2"])[2]
    Wait Until Page Contains Element        xpath=(//*[@class="android.view.View"][@index="1"])[1]            100
    Page Should Contain Element             xpath=(//*[@class="android.widget.Button"][@index="2"])
    Page Should Contain Element             xpath=(//*[@class="android.widget.Button"][@index="3"])
    Page Should Contain Element             xpath=(//*[@class="android.widget.Button"][@index="4"])
    Page Should Contain Element             xpath=(//*[@class="android.widget.Button"][@index="5"])
    Page Should Contain Element             xpath=(//*[@class="android.widget.Button"][@index="6"])
    Click Element                           xpath=(//*[@class="android.widget.Button"][@index="0"])