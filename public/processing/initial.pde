void setup(){
  background(0);
}

void draw(){
  
}

// Called upon browser resize. Any standard event can be forwarded by adding
// it to the array on the first line of the script located in
// assets/scripts/processing.events.coffee and creating a handler named
// with the same name as the event, prefixed with on_. For instance, the
// following will be called whenever the browser is resized:
void on_resize(){
  size( window.innerWidth, window.innerHeight );
}
