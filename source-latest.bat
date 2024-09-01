@Echo Off
set version=RandomFilePicker - v1.4.4
Title %version%


::####  CONFIG SECTION  ####
	
	::CAN MANUALLY SET DIRECTORY HERE- Comment the other and vice versa
	
	::Option 1 - Viewing away from directory.
		::Set directory="C:\Users\Echox\OneDrive\Pictures\All_Wallpapers"
	
	::Option 2 - Viewing within same folder/subfolders.
		mkdir "%~dp0" > NUL 2>&1
	
	::KEY BINDS - The script can recognize if you type part of a word so caution with mistyping.
		set bind_delete=d del delete
		set bind_open=v review
		set bind_reload=r reload
	
	::Toggles question on what Search Mode you want set. Default = 0-disabled, 1-enabled.
		set manual_mode=0
	
	::SET YOUR PREFERRED COLOR - List is on the documentation file on home page.
		set color_code=3
	
	::Determines how many times you want the Randomizer to shuffle. Default = 250
		Set timeout_max=250
	
	::SET YOUR SEARCH CRITERIA
		set search_mode=2
	::1 = Images
	::2 = Videos
	::3 = Music
	::4 = Images, Videos, Music
	::5 = Your preferred file type (CAUTION: Will literally open anything)
	
	::FILTER - Add any file extensions you may find useful.
	::Image file types
		set file_image=.png .jpg .jpeg .webp .gif .bmp .tiff
	::Video file types
		set file_video=.mp4 .mkv .mov .webm .avi .wmv .mpeg
	::Music file types
		set file_music=.mp3 .m4a .wav .wma .flac .aac .ogg
	::Allowed file types or keywords.
		set allowed_filter=untitled pose
	::Blocked file types or keywords.
		set blocked_filter=.exe
	
::####  END OF CONFIG  ####



::####  START OF SCRIPT  ####

::file_all prevents folders from being opened as a result. Directory is forced to contain a '.'
set "file_all=."
set file_media=%file_image% %file_video% %file_music%
Color %color_code%
Echo.
Echo %version%
Echo.
Echo -github/bandito52
Echo.
Echo.
Echo %manual_mode% | findstr "1" >nul && (timeout 2 >nul)
Echo %manual_mode% | findstr "1" >nul && (goto ManualQuestion) || (goto Start)


::Step 1
:Start
if %search_mode% LSS 1 (goto Error-IncorrectNum)
if %search_mode% GTR 5 (goto Error-IncorrectNum)

Echo %manual_mode% | findstr "1" >nul && (CLS)
Color %color_code%
Echo.
Echo (Step 1/3) - Directory set, creating index... Please wait a moment.
Set count=0
Set timeout=0
For /f %%f in ('dir "%directory%" /b /s') do set /a count+=1

::Step 2
:Randomizer
Color %color_code%
CLS
Echo.
Echo Pool Total: %count%
Echo.
Echo (Step 2/3) - Randomizer searching... Please wait a moment.
Echo %timeout% | findstr %timeout_max% >nul && (goto Error-TimedOut) || (Echo Attempt %timeout%/%timeout_max% till Timeout...)
Echo.
Echo %search_mode% | findstr "1" >nul && (Echo     File Type: Images & set opp_filter=%file_video% %file_music%)
Echo %search_mode% | findstr "2" >nul && (Echo     File Type: Videos & set opp_filter=%file_image% %file_music%)
Echo %search_mode% | findstr "3" >nul && (Echo     File Type: Music & set opp_filter=%file_image% %file_video%)
Echo %search_mode% | findstr "4" >nul && (Echo     File Type: Images, Videos, Music)
Echo %search_mode% | findstr "5" >nul && (Echo     File Type: Any, literally anything.)
Echo Allowed Words: %allowed_filter%
Echo Blocked Words: %blocked_filter%
::timeout 1 >nul
Set /a timeout+=1
Set /a randN=%random% %% %count% +1
For /f "tokens=1* delims=:" %%I in ('dir "%directory%" /b /s^| findstr /n /r . ^| findstr /b "%randN%"') do set filename=%%J

Echo %search_mode% | findstr "%search_mode%" >nul && (goto Search_Mode%search_mode%) || (goto Error-IncorrectNum)

:Search_Mode1
Echo %filename% | findstr /i "%file_image%" >nul && (goto Review) || (goto Randomizer)
:Search_Mode2
Echo %filename% | findstr /i "%file_video%" >nul && (goto Review) || (goto Randomizer)
:Search_Mode3
Echo %filename% | findstr /i "%file_music%" >nul && (goto Review) || (goto Randomizer)
:Search_Mode4
Echo %filename% | findstr /i "%file_media%" >nul && (goto Review) || (goto Randomizer)
:Search_Mode5
Echo %filename% | find /i "%file_all%" >nul && (goto Review) || (goto Randomizer)
goto Review

::Step 3
:Review
Echo %filename% | findstr /i "%blocked_filter%" >nul && (goto Randomizer)
Echo %filename% | findstr /i "%opp_filter%" >nul && (goto Randomizer)
Echo %filename% | findstr /v "%allowed_filter%" >nul && (goto Present)
::For /f %%A in ("%filename%") do set filesize=%%~zA

:Present
Echo %filename% | findstr /i "%file_all%" >nul || (goto Randomizer)
CLS
Start "" "%filename%"
Echo (Step 3/3) - File selected and presented.

::Info Pane
Echo.
Echo Location: %filename%
::Echo %filesize%
Echo.

::Choices
Echo.
Echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Echo.
Echo How do you want to continue? Deletion is FINAL and PERMANENT.
Echo.
Echo OPTIONS:
Echo.
Echo ENTER KEY = Reroll for new file.
Echo %bind_delete% = Permanently delete.
Echo %bind_reload% = Update directory if you added new files.
Echo %bind_open% = Open file again.
Echo.
Set timeout=0
Set choice=
Set /p choice= Choice:
Echo %bind_randomizer% | find /i "%choice%" >nul && goto Randomizer
Echo %bind_delete% | find /i "%choice%" >nul && goto Deletion
Echo %bind_reload% | find /i "%choice%" >nul && goto Start
Echo %bind_open% | find /i "%choice%" >nul && goto Open
goto Randomizer

:Deletion
del "%filename%" | CLS
Color c
Echo.
Echo File permanently deleted.
Echo.
Pause
Goto Randomizer

:ManualQuestion
CLS
Color e
Echo Heads up! You are in manual mode.
Echo.
Echo Enter the Search Mode you would like:
Echo.
timeout 1 >nul
Echo 1 = Images
Echo 2 = Videos
Echo 3 = Music
Echo 4 = Images, Videos, Music
Echo 5 = Anything not filtered. (Check config)
Echo.
Echo.
Echo If you want to disable this warning, check Config, set manual_mode to 0.
Echo %search_mode% | findstr "5" >nul && (Echo.)
Echo %search_mode% | findstr "5" >nul && (Echo You have "5" selected. Be warned that this will open anything such as other scripts and executables...)
Set timeout=0
Set /p choice= Choice:
Set search_mode=%choice%
Goto Start




::####  Error Codes  ####

:Error-IncorrectNum
CLS
Color C
Echo ###  ERROR  ###
Echo    Code: 400
Echo.
Echo Search Mode is not Mode 1-5. CHECK CONFIG.
Echo Current: %search_mode%
Echo.
Echo Program will close upon continuing
Pause
exit

:Error-TimedOut
CLS
Color C
Echo ###  ERROR  ###
Echo    Code: 404
Echo.
Echo Randomizer has timed out after %timeout_max% shuffles. 
Echo Either file type does not exist or directory is too large to find it, try again.
Echo.
Echo Program will close upon continuing
Pause
exit
