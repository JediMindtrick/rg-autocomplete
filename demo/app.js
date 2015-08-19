riot.tag('demo-app', '<rg-autocomplete items="{ countries }" type="text" placeholder="Enter a country name"></rg-autocomplete>', function(opts) {
this.countries = [{
	text: 'England'
}, {
	text: 'Scotland'
}, {
	text: 'Wales'
}, {
	text: 'Ireland'
}];
});
