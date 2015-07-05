<rg-autocomplete>

	<div class="container { open: opened }" style="width: { width }">
		<input type="{ opts.type || 'text' }" name="textbox"
					 placeholder="{ opts.placeholder }"
					 onkeydown="{ handleKeys }"
					 oninput="{ filterItems }"
					 onfocus="{ filterItems }">

		<div class="dropdown { open: opened }" show="{ opened }">
			<div class="list">
				<ul>
					<li each="{ filteredItems }"
							onclick="{ parent.select }"
							class="item { active: active }">
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

		_this.filterItems = function () {
			_this.filteredItems = opts.items.filter(function (item) {
				item.active = false;
				if (_this.textbox.value.length == 0 ||
					item.text.toString().toLowerCase().indexOf(_this.textbox.value.toString().toLowerCase()) > -1) {
					return true;
				}
			});
			if (_this.filteredItems.length > 0) {
				_this.opened = true;
			}
			if (opts.onfilter) {
				opts.onfilter();
			}
			_this.update();
		};

		_this.handleKeys = function (e) {
			var length = _this.filteredItems.length;
			if (length > 0 && [13, 38, 40].indexOf(e.keyCode) > -1) {
				e.preventDefault();
				// Get the currently selected item
				var activeIndex = null;
				for (var i = 0; i < length; i++) {
					var item = _this.filteredItems[i];
					if (item.active) {
						activeIndex = i;
						break;
					}
				}

				// We're leaving this item
				if (activeIndex != null) {
					_this.filteredItems[activeIndex].active = false;
				}

				if (e.keyCode == 38) {
					// Move the active state to the next item lower down the index
					if (activeIndex == null || activeIndex == 0) {
						_this.filteredItems[length - 1].active = true;
					} else {
						_this.filteredItems[activeIndex - 1].active = true;
					}
				} else if (e.keyCode == 40) {
					// Move the active state to the next item higher up the index
					if (activeIndex == null || activeIndex == length - 1) {
						_this.filteredItems[0].active = true;
					} else {
						_this.filteredItems[activeIndex + 1].active = true;
					}
				} else if (e.keyCode == 13 && activeIndex != null) {
					_this.select({ item: _this.filteredItems[activeIndex] });
				}
			}
			return true;
		};

		_this.select = function (item) {
			item = item.item;
			if (opts.onselect) {
				opts.onselect(item);
			}
			_this.textbox.value = item.text;
			_this.opened = false;
		};

		_this.closeDropdown = function (e) {
			if (!_this.root.contains(e.target)) {
				if (opts.onclose && _this.opened) {
					opts.onclose();
				}
				_this.opened = false;
				_this.update();
			}
		};

		_this.on('mount', function () {
			document.addEventListener('click', _this.closeDropdown);
			document.addEventListener('focus', _this.closeDropdown, true);
			_this.width = _this.textbox.getBoundingClientRect().width + 'px';
			var dd = _this.root.querySelector('.dropdown');
			dd.style.width = _this.width;
			dd.style.position = 'absolute';
			_this.opened = opts.opened;
			_this.update();
		});

		_this.on('unmount', function () {
			document.removeEventListener('click', _this.closeDropdown);
			document.removeEventListener('focus', _this.closeDropdown, true);
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

		li.active,
		li:hover.active {
			background-color: #ededed;
		}


	</style>
</rg-autocomplete>
