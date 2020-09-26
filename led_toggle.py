import RPi.GPIO as GPIO # Import pi GPIO library
from time import sleep

def main():
	GPIO.setmode(GPIO.BOARD) # Pin numbering mode set to board
	GPIO.setwarnings(False) # Ignore warnings

	GPIO.setup(8, GPIO.OUT, initial=GPIO.LOW) # Set pin 8 as out, initially LOW

	while True:
		GPIO.output(8, GPIO.HIGH) # LED ON
		sleep(0.5) # Sleep for 0.5 seconds
		GPIO.output(8, GPIO.LOW) # LED OFF
		sleep(0.5) # Sleep for 0.5 seconds

if __name__ == '__main__':
	main()
