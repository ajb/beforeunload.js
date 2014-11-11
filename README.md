beforeunload.js
=====

## API

```javascript
var inputHasChanges = true;

BeforeUnload.enable(function(){
  return inputHasChanges;
}, "You have entered data that is not yet saved.")

BeforeUnload.disable()
```

## License

MIT
