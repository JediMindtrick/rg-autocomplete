<img src="https://raw.githubusercontent.com/RiotGear/rg-autocomplete/master/demo/img/example.png" width="250px" />
<img src="https://raw.githubusercontent.com/RiotGear/rg-autocomplete/master/demo/img/example2.png" width="250px" />

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

Now when you click into the text box you will get a dropdown you can use to complete the rest of the text for you.

Supported events:

- `onselect` fires when an item is selected from the list and passes the item to the callback
- `onclose` is called when the dropdown is closed
- `onfilter` fires everytime something is entered into the text box or when the box gains focus