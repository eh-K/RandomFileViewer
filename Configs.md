Following v1.4, there is now a config section at the top of the batch file if you decide to edit it.

### Directory ###
v1.3 introduced the need for no directory but you can still set one if you decide to run the file elsewhere.

Simply swap which you want:

Directory where RandomFilePicker is located:

      ::Set directory="C:\Users\echox\OneDrive\Pictures\All_Wallpapers"
      mkdir "%~dp0" > NUL 2>&1
or

Specific directory from a different location.

      Set directory="C:\Users\echox\OneDrive\Pictures\All_Wallpapers"
      ::mkdir "%~dp0" > NUL 2>&1



### Keybinds ###
Following v1.4, you can set custom keys and phrases to your actions.
Each key and phrase must have a space between them.

      set bind_delete=d del delete
      set bind_review=v review
      set bind_reload=r reload
      set bind_randomizer=



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
