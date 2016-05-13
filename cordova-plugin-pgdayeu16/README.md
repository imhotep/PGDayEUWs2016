These are the plugin bits we manually add to our native projects.

Just look at `plugin.xml` to not forget anything.

## Usage
Once installed and `deviceready` fires a global `PGDayEU16Plugin` object will be available which has 2 functions:

### retrieveList
```js
PGDayEU16Plugin.retrieveList(
  {
    item: "A nice description"
  },
  onSuccess,
  onError
);
```

### addToList
```js
PGDayEU16Plugin.addToList(
  {},
  onSuccess,
  onError
);
```
