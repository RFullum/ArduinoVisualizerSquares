/**
*  Fills screen with black and white checkerboard pattern. Each rectangle
*  will lerp (shift) colors from its base color to its secondary
*  color that morphs based on mic input from Arduino over serial from 0.0f to 1.0f
*
*  Does not use sound card for audio. Needs digital input over serial connection.
*  I'm using Max4466 Analog Mic & Amp, into an ADS1115 Analog to Digital Converter,
*  into an Arduino Nano 33 IoT, over USB cable for the serial connection
*
*  Robert Fullum. August, 2020
*/

import processing.serial.*;

// Serial variables
Serial myPort;
String inString = "";

// Mic amplitude from arduino (0.0f to 1.0f), initialized
float arduinoVal = 0.0f;

// Square variables
SquareFun[] squares;
int numSquares = 5;  // Number of squares high and number across. Odd numbers = checker pattern. Even = rows.
int totalSquares = numSquares * numSquares;


void setup()
{
  fullScreen();
  
  // Show serial ports
  printArray(Serial.list());
  
  // Set up Serial ports
  String portName = Serial.list()[4];  // Change the index to the Arduino's port
  myPort = new Serial(this, portName, 9600);
  
  // Show the selected port info
  println("");
  println(portName);
  println(myPort);
  
  // Squares Setup
  squares = new SquareFun[totalSquares];

  int sqrCount = 0;    // Next time use a 2D Array instead of nested for loops
  
  for (int i=0; i<numSquares; i++)
  {
    for (int j=0; j<numSquares; j++)
    {
      squares[sqrCount] = new SquareFun();
      squares[sqrCount].setColor( (sqrCount % 2) * 255);
      squares[sqrCount].setSize(numSquares);
      squares[sqrCount].setLocation(i, j);
      
      sqrCount++;
    }
  }
  
}


void draw()
{
  // Calls to Arduino
  myPort.write('1');
  myPort.write('0');
  
  // Get from Arduino
  int lf = 10;    // ASCII end of line from Arduino Serial.println is 10
  
  // While the port is available, read incoming until end-of-line
  while (myPort.available() > 0)
  {
    inString = myPort.readStringUntil(lf);
  }
  
  arduinoVal = float(inString);    // Mic amplitude 0.0f to 1.0f
  
  // Visuals
  background(0);
  
  // Draw each square, passing amplitude value from arduino
  for (int i=0; i<totalSquares; i++)
  {
    squares[i].drawRect(arduinoVal);
  }
}
