riot.tag('rg-autocomplete', '<div class="container { open: opened }" riot-style="width: { width }"> <input type="{ opts.type || \'text\' }" name="textbox" placeholder="{ opts.placeholder }" onkeydown="{ handleKeys }" oninput="{ filterItems }" onfocus="{ filterItems }"> <div class="dropdown { open: opened }" show="{ opened }"> <div class="list"> <ul> <li each="{ filteredItems }" onclick="{ parent.select }" class="item { active: active }"> { text } </li> </ul> </div> </div> </div>', 'rg-autocomplete .container, [riot-tag="rg-autocomplete"] .container{ position: relative; display: inline-block; cursor: pointer; } rg-autocomplete .container.open, [riot-tag="rg-autocomplete"] .container.open{ -webkit-box-shadow: 0 2px 10px -4px #444; -moz-box-shadow: 0 2px 10px -4px #444; box-shadow: 0 2px 10px -4px #444; } rg-autocomplete input, [riot-tag="rg-autocomplete"] input{ font-size: 1em; padding: 10px; border: 1px solid #D3D3D3; -webkit-box-sizing: border-box; -moz-box-sizing: border-box; box-sizing: border-box; outline: none; } rg-autocomplete .container.open input, [riot-tag="rg-autocomplete"] .container.open input{ } rg-autocomplete .dropdown, [riot-tag="rg-autocomplete"] .dropdown{ position: relative; background-color: white; border: 1px solid #D3D3D3; border-top: 0; -webkit-box-sizing: border-box; -moz-box-sizing: border-box; box-sizing: border-box; overflow-y: auto; overflow-x: hidden; } rg-autocomplete .dropdown.open, [riot-tag="rg-autocomplete"] .dropdown.open{ -webkit-box-shadow: 0 2px 10px -4px #444; -moz-box-shadow: 0 2px 10px -4px #444; box-shadow: 0 2px 10px -4px #444; } rg-autocomplete ul, [riot-tag="rg-autocomplete"] ul,rg-autocomplete li, [riot-tag="rg-autocomplete"] li{ list-style: none; padding: 0; margin: 0; } rg-autocomplete li, [riot-tag="rg-autocomplete"] li{ padding: 10px; border-top: 1px solid #E8E8E8; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; } rg-autocomplete li:first-child, [riot-tag="rg-autocomplete"] li:first-child{ border-top: 0; } rg-autocomplete li:hover, [riot-tag="rg-autocomplete"] li:hover{ background-color: #f3f3f3; } rg-autocomplete li.active, [riot-tag="rg-autocomplete"] li.active,rg-autocomplete li:hover.active, [riot-tag="rg-autocomplete"] li:hover.active{ background-color: #ededed; }', function(opts) {var _this = this;

this.opened = true;
this.textbox.value = opts.value || '';

this.filterItems = function () {
	_this.filteredItems = opts.items.filter(function (item) {
		item.active = false;
		if (_this.textbox.value.length == 0 || item.text.toString().toLowerCase().indexOf(_this.textbox.value.toString().toLowerCase()) > -1) {
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

this.handleKeys = function (e) {
	var length = _this.filteredItems.length;
	if (length > 0 && [13, 38, 40].indexOf(e.keyCode) > -1) {
		_this.opened = true;
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
		if (activeIndex != null) _this.filteredItems[activeIndex].active = false;

		if (e.keyCode == 38) {
			// Move the active state to the next item lower down the index
			if (activeIndex == null || activeIndex == 0) _this.filteredItems[length - 1].active = true;else _this.filteredItems[activeIndex - 1].active = true;
		} else if (e.keyCode == 40) {
			// Move the active state to the next item higher up the index
			if (activeIndex == null || activeIndex == length - 1) _this.filteredItems[0].active = true;else _this.filteredItems[activeIndex + 1].active = true;
		} else if (e.keyCode == 13 && activeIndex != null) _this.select({ item: _this.filteredItems[activeIndex] });
	}
	return true;
};

this.select = function (item) {
	item = item.item;
	if (opts.onselect) opts.onselect(item);
	_this.textbox.value = item.text;
	_this.opened = false;
};

this.closeDropdown = function (e) {
	if (!_this.root.contains(e.target)) {
		if (opts.onclose && _this.opened) opts.onclose();
		_this.opened = false;
		_this.update();
	}
};

this.on('mount', function () {
	document.addEventListener('click', _this.closeDropdown);
	document.addEventListener('focus', _this.closeDropdown, true);
	_this.width = _this.textbox.getBoundingClientRect().width + 'px';
	var dd = _this.root.querySelector('.dropdown');
	dd.style.width = _this.width;
	dd.style.position = 'absolute';
	_this.opened = opts.opened;
	_this.update();
});

this.on('unmount', function () {
	document.removeEventListener('click', _this.closeDropdown);
	document.removeEventListener('focus', _this.closeDropdown, true);
});
});
