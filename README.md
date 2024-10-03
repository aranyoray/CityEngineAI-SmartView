
  

# SmartView Mobile Application (TP-Group24)


[![Android Release](https://github.com/UofG-CS/project-TP-group24/actions/workflows/android-release.yml/badge.svg?branch=master)](https://github.com/UofG-CS/project-TP-group24/actions/workflows/android-release.yml)

## Overview

The SmartView Mobile Application enhances emergency response and city security by utilizing CCTV surveillance cameras with deep learning algorithms to detect security issues like violence and vandalism. It assigns the detected cases to the nearest officer through GPS, and officers can view details such as time, date, location, and case type to respond promptly. The application is designed for use by security force and national law enforcement agency members.

Features of the application include:
1. Login functionality to authenticate users
2. Viewing of cases assigned to user
3. Filtering and sorting of cases based on case priority (Low/Medium/High)
4. Viewing of case details (time, date, location, etc)
5. Closing of cases that were responded by officer
6. Search for cases via keywords
7. Account and CCTV management via admin account

## Software Tools Required

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)
- [Android Studio](https://developer.android.com/studio)
- [Visual Studio Code](https://code.visualstudio.com/download)
- Android Toolchain
- Google Maps API


## Getting Started

1. Before installing the Flutter SDK, ensure that these minimum requirements are fulfilled:

		- Operating System: Windows 10 or later (64-bit), x86-64 based

		- Disk Space: 1.64 GB

		- Windows PowerShell 5.0 or newer

		- Git for Windows 2.x, with the 'Use Git from the Windows Command Prompt' option.

2. Run the following command in the terminal after installing Flutter SDK to check the environment and status of your Flutter installation:

	```
	flutter doctor
	```

3. Fix any errors highlighted by `flutter doctor` to ensure that Flutter is installed properly

4. Set up a mobile emulator in Android Studio. The emulator should fulfill these requirements:

		- OS Version: R and above

		- API Level: 30

		- Play Store enabled

5. Clone this project by running this command in the terminal:
	```
	git clone https://github.com/UofG-CS/project-TP-group24.git
	```
	
6. Download and update Flutter dependencies by running this command:
	```
	flutter pub get
	```

7. Import the database schema in MySQL Workbench:

	```
	/SmartView_DB
	```

8. Enter the Google Maps API key in this file:
	```
	/lib/incident_view.dart
	```
	
9. Start up the emulator created and run the application from this file:
	```
	/lib/main.dart
	```

## Contact Details
If you require any assistance, contact us here:

Team Project - Team 24
- Poh Kai Boon:

	- SIT Student ID: 2101387 

	- Email: 2101387@sit.singaporetech.edu.sg
- Tong Kah Jun:
	
	- SIT Student ID: 2101694
	
	- Email: 2101694@sit.singaporetech.edu.sg
- Vincent Tan:

	- SIT Student ID: 2101787
	
	- Email: 2101787@sit.singaporetech.edu.sg
- Low Li Pin:

	- SIT Student ID: 2101542

	- Email: 2101542@sit.singaporetech.edu.sg
- Zamora Zchyrlene Mae Prades 
	
	- SIT Student ID: 2101402
	
	- Email: 2101402@sit.singaporetech.edu.sg
