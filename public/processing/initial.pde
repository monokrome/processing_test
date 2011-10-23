 
// Global variables
float alpha = 0.0f, gamma = 0.0f, beta = 0.0f;
bool has_motion = false;

float radius = 50.0;

int X, Y;
int nX, nY;
int delay = 16;

// Setup the Processing Canvas
void setup(){
  on_resize();

  strokeWeight( 10 );
  frameRate( 15 );
  X = width / 2;
  Y = height / 2;
  nX = X;
  nY = Y;  
}

// Main draw loop
void draw(){
  
  radius = radius + sin( frameCount / 4 );
  
  // Track circle to new destination
  X+=(nX-X)/delay;
  Y+=(nY-Y)/delay;
  
  // Fill canvas grey
  background( 100 );
  
  // Set fill-color to blue
  fill( 0, 121, 184 );
  
  // Set stroke-color white
  stroke(255); 
  
  // Draw circle
  ellipse( X, Y, radius, radius );                  
}


// Set circle's next destination
void mouseMoved(){
  if (has_motion)
    return;

  nX = mouseX;
  nY = mouseY;  
}

// Called upon browser resize. Any standard event can be forwarded by adding
// it to the array on the first line of the script located in
// assets/scripts/processing.events.coffee and creating a handler named
// with the same name as the event, prefixed with on_. For instance, the
// following will be called whenever the browser is resized:
void on_resize(){
  size( window.innerWidth, window.innerHeight );
}

void on_deviceorientation(orientation){
  if (!has_motion && !(orientation.gamma || orientation.x) || !orientation.alpha)
    return;

  has_motion = true;

  // Takes gamma/beta orientation-types and normalizes them to x/y (-1 to 1) types.
  // Follows this by converting this to a value between 0 and 2, and then converting
  // that result to a result between 0 and 1 by dividing it by two. After this,
  // multiplies this value as a scalar to the screen size. This effectively results in
  // translating the tilt of the device into screen pixels.
  nX = ((((orientation.beta / 90) || orientation.x) + 1) / 2) * width;
  nY = (((((orientation.gamma / 90) || orientation.y) * -1) + 1) / 2) * height;
}
