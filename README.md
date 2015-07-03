In development...

<!--<img src="https://raw.githubusercontent.com/RiotGear/rg-autocomplet/master/demo/img/example.png" width="500px" />-->

### Use

Add this to your Riot app markup

```html
<rg-autocomplete items="{ countries }" type="text" value="United Kingdom" placeholder="Enter a country name"></rg-autocomplete>
```

And this to your JavaScript


```javascript
this.countries = [{
  text: 'England'
}, {
  text: 'Scotland'
}, {
  text: 'Wales'
}, {
  text: 'Ireland'
}];
```

Supported events:

- `onselect` fires when an item is selected from the list and passes the item to the callback
- `onopen` is called when the dropdown is opened
- `onclose` is called when the dropdown is closed
- `onfilter` fires everytime something is entered into the text box