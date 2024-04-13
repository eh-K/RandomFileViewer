Following v1.4, there is a config section at the top of the file if you decide to edit it.

To edit, you must open the bat file with Notepad or any text editor.

### Directory ###
v1.3 introduced the need for no directory but you can still set one if you decide to run the file elsewhere.

Simply swap which you want:

Directory where RandomFilePicker is located:

      ::Set directory="C:\Users\echox\OneDrive\Pictures\All_Wallpapers"
      mkdir "%~dp0" > NUL 2>&1
or

Specific directory from a different location:

      Set directory="C:\Users\echox\OneDrive\Pictures\All_Wallpapers"
      ::mkdir "%~dp0" > NUL 2>&1



### Keybinds ###
Following v1.4, you can set custom keys and phrases to your actions.
Each key and phrase must have a space between them.

      set bind_delete=d del delete
      set bind_review=v review
      set bind_reload=r reload
      set bind_randomizer=

### Search Criteria  ###
Following v1.4.1, you can choose what file types you want to open.

      set search_mode=4
      ::1 = Images
      ::2 = Videos
      ::3 = Music
      ::4 = Images, Videos, Music
      ::5 = Every possible file type (CAUTION: Will literally open anything)

Here is list of search criteria types:

      ::Image file types
            set file_type1.1=.png
            set file_type1.2=.jpg
            set file_type1.3=.jpeg
            set file_type1.4=.webp
      ::Video file types
            set file_type2.1=.mp4
            set file_type2.2=.mkv
            set file_type2.3=.mov
            set file_type2.4=.webm
      ::Music file types
            set file_type3.1=.mp3
            set file_type3.2=.m4a
            set file_type3.3=.wav
            set file_type3.4=.wma

### Timeout Search Limit  ###
Following v1.4.1, you can set how many times you want the Randomizer to shuffle.
Default shuffle count: 250

      set timeout_max=250

### Color Coding ###
Following v1.4, you can set what color you want your console to have.

Default is color_code=3

Here is the list of color codes:
   
    0 - Black
    1 - Blue
    2 - Green
    3 - Aqua
    4 - Red
    5 - Purple
    6 - Yellow
    7 - White
    8 - Gray
    9 - Light Blue
    A - Light Green
    B - Light Aqua
    C - Light Red
    D - Light Purple
    E - Light Yellow
    F - Bright White
    

There are more but these about serve everyone.
