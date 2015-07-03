riot.tag('demo-app', '<rg-autocomplete items="{ countries }" type="text" value="what"></rg-autocomplete>', function(opts) {
		var _this = this;
		_this.countries = [{
			text: 'England'
		}, {
			text: 'Scotland'
		}, {
			text: 'Wales'
		}, {
			text: 'Ireland'
		}];
	
});