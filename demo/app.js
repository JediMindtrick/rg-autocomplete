riot.tag('demo-app', '<rg-autocomplete items="{ countries }" type="text" value="United States" placeholder="Enter a country name" onselect="{ interaction }" onopen="{ interaction }" onclose="{ interaction }" onfilter="{ interaction }"></rg-autocomplete>', function(opts) {
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

		_this.interaction = function () {
			console.log(arguments);
		}
	
});