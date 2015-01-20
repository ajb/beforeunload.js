beforeunload.js
=====

## API

```coffeescript
BeforeUnload.enable(
  # Only gets triggered if this returns truthy
  if: -> inputHasChanged

  # The warning message that is displayed
  message: "You have entered data that is not yet saved."

  # If triggered by Turbolinks, call this function instead
  # of displaying the warning message
  cb: (url) ->
    saveInput -> Turbolinks.visit(url)
)

BeforeUnload.disable()
```

## License

MIT
