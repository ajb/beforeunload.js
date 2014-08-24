beforeunload.js
=====

## API

```javascript
var inputHasChanges = true;

BeforeUnload.enable(function(){
  return inputHasChanges;
}, "Are you sure you want to leave this page?")

BeforeUnload.disable()
```

## License

MIT