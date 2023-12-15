*** Settings ***
Documentation	Robot Selenium Example
Library			SeleniumLibrary

*** Variables ***
${login_url}			http://localhost:8000/accounts/login/
${add_notes_url}        http://localhost:8000/notes/add
${notes_url}            http://localhost:8000/notes
${admin_url}            http://localhost:8000/admin          
${browser}	    chrome
${username}=     tester1
${password}=     testpass1
${testusername}=    tester3
${testerpassword}=    testpass3
${tester_email}=        test3.user@localhost.localhost
${testerFirstname}=    test3
${testerLastname}=     user
${admin_username}=     admin
${admin_password}=     admin


*** Test Cases ***

Login and Logout User with Password
    Open Browser    ${login_url}    Chrome
	Login User
	Sleep			3 seconds
	Logout User
	Sleep           2 seconds
	[Teardown]      Close Browser
   
Login User with Password Add Note and Check Note exists
    Open Browser    ${add_notes_url}    Chrome
	Sleep              3 seconds
	Login User
	Add Note
	Go To    ${notes_url}
	Check Note exists
	Sleep    2 seconds
	Close All Browsers

Login Admin User and Add New User
    Open Browser    ${admin_url}    Chrome
	Sleep              3 seconds
    Login admin_username
	Go To    http://localhost:8000/admin/auth/user/add/
	Add User
	Sleep    2 seconds
	Add Userinfo
	Go To    http://localhost:8000/admin/auth/user/
	Page Should Contain Link    xpath=//*[@id="result_list"]/tbody/tr[3]/th/a    ${testusername}
	[Teardown]      Close Browser
	

*** Keywords ***

Login User
    Input Text       id=id_username  ${username}
	Input Password   id=id_password    ${password}
	Click Button    xpath=/html/body/main/form/button
Logout User
    Click Link      xpath=/html/body/main/p/a
Login admin_username
    Input Text       id=id_username  ${admin_username}
	Input Password   id=id_password    ${admin_password}
	Click Element    xpath=//*[@id="login-form"]/div[3]/input
    
Add Note
    Input Text    id=id_subject    Test Sample Note
	Input Text    id=id_text       Testing.....
	Input Text  xpath=//*[@id="id_date"]   2023-11-18
	Input Text    id=id_userid    2
	Click Button     xpath=/html/body/form/input[2]

Check Note exists
    Page Should Contain Element   xpath=/html/body/ul/li[6]

Add User
    Input Text       id=id_username  ${testusername}
	Input Password   id=id_password1    ${testerpassword}
	Input Password   id=id_password2     ${testerpassword}    
	Click Element    name=_save
	Sleep    10 seconds
Add Userinfo
    Input Text       id=id_first_name  ${testerFirstname}
	Input Text       id=id_last_name    ${testerLastname}
	Input Text       id=id_email     ${testerEmail}    
	Click Element    name=_save
	Sleep    10 seconds
    


   
	 

	


