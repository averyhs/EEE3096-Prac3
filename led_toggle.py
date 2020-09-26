import RPi.GPIO as GPIO # Import pi GPIO library
from time import sleep

def main():
	GPIO.setmode(GPIO.BOARD) # Pin numbering mode set to board
	GPIO.setwarnings(False) # Ignore warnings

	GPIO.setup(8, GPIO.OUT, initial=GPIO.LOW) # Set pin 8 as out, initially LOW
	GPIO.setup(10, GPIO.IN, pull_up_down=GPIO.PUD_UP) # Set pin 10 as in, with pullup resistor


if __name__ == '__main__':
	main()
