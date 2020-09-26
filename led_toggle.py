import RPi.GPIO as GPIO # Import pi GPIO library
import sys
from time import sleep

def main():
	GPIO.setmode(GPIO.BOARD) # Pin numbering mode set to board
	GPIO.setwarnings(False) # Ignore warnings

	GPIO.setup(8, GPIO.OUT, initial=GPIO.LOW) # Set pin 8 as out, initially LOW
	GPIO.setup(10, GPIO.IN, pull_up_down=GPIO.PUD_UP) # Set pin 10 as in, with pulldown resistor

	GPIO.add_event_detect(10, GPIO.FALLING, callback=pushbutton_callback, bouncetime=200) # Interrupt at button push, debounce 200ms

	while True: # Run function indefinitely
		continue

def pushbutton_callback(channel):
	GPIO.output(8, not GPIO.input(8))

if __name__ == '__main__':
	try:
		main()
	except KeyboardInterrupt: # Exception handling for keyboard interrupt (exit from terminal)
		print("starting cleanup")
		GPIO.cleanup() # Cleanup GPIO resources
		print("cleanup complete")
		sys.exit(0) # Exit program
