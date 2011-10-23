var events = ['resize'],
  handler_prefix = 'on_',
  registered_instances = [],

  rebind_events = (function () {
    var i, instances, current_instance, event_index;

    instances = Processing.instances;

    for (var i=0; i < instances.length; ++i) {
      current_instance = instances[i];
      
      if (registered_instances.indexOf(current_instance) > -1)
        break;

      for (event_index in events) {
        // Closure to not break handlers as the for loop continues changing
        // the data referenced by current_event.
        (function (current_instance) {

          var this_event = events[event_index],
            current_event = current_instance[handler_prefix + this_event];

          if (document.attachEvent) {
            document.attachEvent('on' + this_event, function (event_instance) {
              current_event(event_instance);
            });
          }
          else {
            window.addEventListener(this_event, function (event_instance) {
              current_event(event_instance);
            }, false);
          }
        })(current_instance);
      }

      registered_instances.push(current_instance);
    }
  });

/**** TODO: Stop the evil polling. ****/
setInterval(rebind_events, 100);
