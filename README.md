# ArduinoVisualizerSquares
Audio Visualizer for digital audio over serial port

Fills screen with black and white checkerboard pattern. Each rectangle
will lerp (shift) colors from its base color to its secondary
color that morphs based on mic input from Arduino over serial from 0.0f to 1.0f

Does not use sound card for audio. Needs digital input over serial connection.
I'm using Max4466 Analog Mic & Amp, into an ADS1115 Analog to Digital Converter,
into an Arduino Nano 33 IoT, over USB cable for the serial connection

Robert Fullum. August, 2020

Video of sketch in action:
https://youtu.be/euIS7LfHdZI
