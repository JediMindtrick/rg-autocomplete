<demo-app>

	<rg-autocomplete items="{ countries }" type="text" value="United States" placeholder="Enter a country name"></rg-autocomplete>

	<script>
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
	</script>

</demo-app>