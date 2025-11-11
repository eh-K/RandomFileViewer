@Echo Off
set version=RandomFilePicker - Vue
Title %version%


::####  CONFIG SECTION  ####
	
	::CAN MANUALLY SET DIRECTORY HERE- Comment the other and vice versa
	
	::Option 1 - Viewing away from directory.
	::Set directory="C:\Users\Echox\OneDrive\Pictures\All_Wallpapers"
	
	::Option 2 - Viewing within same folder/subfolders.
	mkdir "%~dp0" > NUL 2>&1
	
	::KEY BINDS - The script can recognize if you type part of a word so caution with mistyping.
	set bind_randomizer=1
	set bind_reload=2
	
	::Toggles question on what Search Mode you want set. Default = 0-disabled, 1-enabled.
	set manual_mode=0
	
	::SET YOUR PREFERRED COLOR - List is on the documentation file on home page.
	set color_code=3
	
	::Determines how many times you want the Randomizer to shuffle. Default = 250
	Set timeout_max=250
	
	::SET YOUR SEARCH CRITERIA
	set search_mode=4
	::1 = Images
	::2 = Videos
	::3 = Music
	::4 = Images, Videos, Music
	::5 = Your preferred file type (CAUTION: Will literally open anything)
	
	::FILE TYPES - Add any file extensions you may find useful.
	::Image file types
	set file_image=.png .jpg .jpeg .webp .gif .bmp .tiff
	::Video file types
	set file_video=.mp4 .mkv .mov .webm .avi .wmv .mpeg
	::Music file types
	set file_music=.mp3 .m4a .wav .wma .flac .aac .ogg
	::Allowed file types or keywords. CASE SENSITIVE
	set allowed_filter=
	::Blocked file types or keywords.
	set blocked_filter=.exe
	
::####  END OF CONFIG  ####



::####  START OF SCRIPT  ####
set file_all=.
set file_media=%file_image% %file_video% %file_music%
Color %color_code%
Echo %manual_mode% | findstr "1" >nul && (timeout 2 >nul)
Echo %manual_mode% | findstr "1" >nul && (goto ManualQuestion) || (goto Start)


::Step 1
:Start
if %search_mode% LSS 1 (goto Error-IncorrectNum)
if %search_mode% GTR 5 (goto Error-IncorrectNum)

Echo %manual_mode% | findstr "1" >nul && (CLS)
Color %color_code%
Set count=0
Set timeout=0
For /f %%f in ('dir "%directory%" /b /s') do set /a count+=1

::Step 2
:Randomizer
CLS
Color %color_code%
Echo %timeout% | findstr %timeout_max% >nul && (goto Error-TimedOut) || (Echo Attempt %timeout%/%timeout_max% till Timeout...)
Echo %search_mode% | findstr "1" >nul && (set opp_filter=%file_video% %file_music%)
Echo %search_mode% | findstr "2" >nul && (set opp_filter=%file_image% %file_music%)
Echo %search_mode% | findstr "3" >nul && (set opp_filter=%file_image% %file_video%)

::timeout 1 >nul
Set /a timeout+=1
Set /a randN=%random% %% %count% +1
Set listN=0
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
Echo %filename% | findstr /v "%allowed_filter%" >nul && (goto Randomizer)
::For /f %%A in ("%filename%") do set filesize=%%~zA

:Present
Echo %filename% | findstr /i "%file_all%" >nul || (goto Randomizer)
CLS
Start "" "%filename%"

::Info Pane
CLS
::Echo %filesize%
Echo %version%
Echo -github/bandito52

::Choices
Echo.
Echo How do you want to continue?
Echo.
Echo OPTIONS:
Echo.
Echo %bind_randomizer% = Reroll for new file.
Echo %bind_reload% = Update directory if you added new files.
Echo.
Set timeout=0
Set choice=
Set /p choice= Choice:
Echo %bind_randomizer% | find /i "%choice%" >nul && goto Randomizer
Echo %bind_reload% | find /i "%choice%" >nul && goto Start
goto Randomizer

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
