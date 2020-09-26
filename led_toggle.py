import RPi.GPIO as GPIO # Import pi GPIO library

def main():
	GPIO.setmode(GPIO.BOARD) # Pin numbering mode set to board
	GPIO.setwarnings(False) # Ignore warnings

	GPIO.setup(8, GPIO.OUT, initial=GPIO.LOW) # Set pin 8 as out, initially LOW

if __name__ == '__main__':
	main()
