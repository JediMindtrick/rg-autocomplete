<rg-autocomplete>

	<div class="container { open: opened }" style="width: { width }">
		<input type="{ opts.type || 'text' }" name="textbox"
					 placeholder="{ opts.placeholder }"
					 onkeydown="{ handleKeys }"
					 oninput="{ filterItems }"
					 onfocus="{ handleOnFocus }">

		<div class="dropdown { open: opened }" show="{ opened }">
			<div class="list">
				<ul>
					<li each="{ opts.items }"
							show="{ available }"
							onclick="{ parent.select }"
							class="item">
						{ text }
					</li>
				</ul>
			</div>
		</div>
	</div>

	<script>
		var _this = this;
		_this.opened = true;
		_this.textbox.value = opts.value;

		function handleClickOutside(e) {
			if (!_this.root.contains(e.target)) {
				if (opts.onclose && _this.opened) {
					opts.onclose();
				}
				_this.opened = false;
				_this.update();
			}
		}

		_this.handleOnFocus = function () {
			if (opts.onopen && _this.closed) {
				opts.onopen();
			}
			_this.opened = true;
			_this.filterItems();
			_this.update();
		};

		_this.filterItems = function () {
			opts.items.forEach(function (item) {
				item.selected = false;
				item.available = (_this.textbox.value.length == 0 ||
				item.text.toString().toLowerCase().indexOf(_this.textbox.value.toString().toLowerCase()) > -1);
			});
			if (opts.onfilter) {
				opts.onfilter();
			}
			_this.update();
			return true;
		};

		_this.handleKeys = function (e) {
			if (e.keyCode == 38) {
				console.log('up');
			} else if (e.keyCode == 40) {
				console.log('down');
			}
			return true;
		};

		_this.select = function (item) {
			item = item.item;
			if (opts.onselect) {
				opts.onselect(item);
			}
			opts.items.forEach(function (item) {
				item.selected = false;
			});
			item.selected = true;
			_this.textbox.value = item.text;
			_this.opened = false;
		};

		_this.on('mount', function () {
			document.addEventListener('click', handleClickOutside);
			_this.width = _this.textbox.getBoundingClientRect().width + 'px';
			var dd = _this.root.querySelector('.dropdown');
			dd.style.width = _this.width;
			dd.style.position = 'absolute';
			_this.opened = opts.opened;
			_this.update();
		});
	</script>

	<style scoped>

		.container {
			position: relative;
			display: inline-block;
			cursor: pointer;
		}

		.container.open {
			-webkit-box-shadow: 0 2px 10px -4px #444;
			-moz-box-shadow: 0 2px 10px -4px #444;
			box-shadow: 0 2px 10px -4px #444;
		}

		input {
			font-size: 1em;
			padding: 10px;
			border: 1px solid #D3D3D3;
			-webkit-box-sizing: border-box;
			-moz-box-sizing: border-box;
			box-sizing: border-box;
			outline: none;
		}

		.container.open input {
			border-bottom: 0;
		}

		.dropdown {
			position: relative;
			background-color: white;
			border: 1px solid #D3D3D3;
			border-top: 0;
			-webkit-box-sizing: border-box;
			-moz-box-sizing: border-box;
			box-sizing: border-box;
			overflow-y: auto;
			overflow-x: hidden;
		}

		.dropdown.open {
			-webkit-box-shadow: 0 2px 10px -4px #444;
			-moz-box-shadow: 0 2px 10px -4px #444;
			box-shadow: 0 2px 10px -4px #444;
		}

		ul, li {
			list-style: none;
			padding: 0;
			margin: 0;
		}

		li {
			padding: 10px;
			border-top: 1px solid #E8E8E8;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
		}

		li:hover {
			background-color: #f3f3f3;
		}

	</style>
</rg-autocomplete>
