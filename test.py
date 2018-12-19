from lcd import lcd
import time

display = lcd()

display.lcd_display_string("Hello", 1)

display.lcd_display_string("World!", 2)

time.sleep(3)

display.lcd_clear()