import RPi.GPIO as GPIO # Import pi GPIO library
from time import sleep

def main():
	GPIO.setmode(GPIO.BOARD) # Pin numbering mode set to board
	GPIO.setwarnings(False) # Ignore warnings

	GPIO.setup(8, GPIO.OUT, initial=GPIO.LOW) # Set pin 8 as out, initially LOW
	GPIO.setup(10, GPIO.IN, pull_up_down=GPIO.PUD_UP) # Set pin 10 as in, with pulldown resistor

	GPIO.add_event_detect(10, GPIO.FALLING, callback=pushbutton_callback) # Interrupt at button push

	GPIO.cleanup()

def pushbutton_callback(channel):
	GPIO.output(8, not GPIO.input(8))

if __name__ == '__main__':
	main()
