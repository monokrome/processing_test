events = ['resize']
handler_prefix = 'on_'
registered_instances = []

rebind_events = ->
  instances = Processing.instances

  for instance in instances
    if (registered_instances.indexOf instance) > -1
      break

    for event in events
      register_events = (instance, event) ->
        event_handler = instance[handler_prefix + event]

        if document.attachEvent
          document.attachEvent 'on' + event, (event_instance) ->
            event_handler event_instance
        else
          window.addEventListener event, (event_instance) ->
            event_handler event_instance
          , false

      register_events instance, event

    registered_instances.push instance

# TODO: Stop the evil polling.
setInterval rebind_events, 100
