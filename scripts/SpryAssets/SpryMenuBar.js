var Spry;
if(!Spry)
{
Spry = {};
}
if(!Spry.Widget)
{
Spry.Widget = {};
}
Spry.Widget.MenuBar = function(element, opts)
{
this.init(element, opts);
};
Spry.Widget.MenuBar.prototype.init = function(element, opts)
{
this.element = this.getElement(element);
this.currMenu = null;
var isie = (typeof document.all != 'undefined' && typeof window.opera == 'undefined' && navigator.vendor != 'KDE');
if(typeof document.getElementById == 'undefined' || (navigator.vendor == 'Apple Computer, Inc.' && typeof window.XMLHttpRequest == 'undefined') || (isie && typeof document.uniqueID == 'undefined'))
{
return;
}
if(opts)
{
for(var k in opts)
{
var rollover = new Image;
rollover.src = opts[k];
}
}
if(this.element)
{
this.currMenu = this.element;
var items = this.element.getElementsByTagName('li');
for(var i=0; i<items.length; i++)
{
this.initialize(items[i], element, isie);
if(isie)
{
this.addClassName(items[i], "MenuBarItemIE");
items[i].style.position = "static";
}
}
if(isie)
{
if(this.hasClassName(this.element, "MenuBarVertical"))
{
this.element.style.position = "relative";
}
var linkitems = this.element.getElementsByTagName('a');
for(var i=0; i<linkitems.length; i++)
{
linkitems[i].style.position = "relative";
}
}
}
};
Spry.Widget.MenuBar.prototype.getElement = function(ele)
{
if (ele && typeof ele == "string")
return document.getElementById(ele);
return ele;
};
Spry.Widget.MenuBar.prototype.hasClassName = function(ele, className)
{
if (!ele || !className || !ele.className || ele.className.search(new RegExp("\\b" + className + "\\b")) == -1)
{
return false;
}
return true;
};
Spry.Widget.MenuBar.prototype.addClassName = function(ele, className)
{
if (!ele || !className || this.hasClassName(ele, className))
return;
ele.className += (ele.className ? " " : "") + className;
};
Spry.Widget.MenuBar.prototype.removeClassName = function(ele, className)
{
if (!ele || !className || !this.hasClassName(ele, className))
return;
ele.className = ele.className.replace(new RegExp("\\s*\\b" + className + "\\b", "g"), "");
};
Spry.Widget.MenuBar.prototype.addEventListener = function(element, eventType, handler, capture)
{
try
{
if (element.addEventListener)
{
element.addEventListener(eventType, handler, capture);
}
else if (element.attachEvent)
{
element.attachEvent('on' + eventType, handler);
}
}
catch (e) {}
};
Spry.Widget.MenuBar.prototype.createIframeLayer = function(menu)
{
var layer = document.createElement('iframe');
layer.tabIndex = '-1';
layer.src = 'javascript:false;';
menu.parentNode.appendChild(layer);
layer.style.left = menu.offsetLeft + 'px';
layer.style.top = menu.offsetTop + 'px';
layer.style.width = menu.offsetWidth + 'px';
layer.style.height = menu.offsetHeight + 'px';
};
Spry.Widget.MenuBar.prototype.removeIframeLayer =  function(menu)
{
var layers = menu.parentNode.getElementsByTagName('iframe');
while(layers.length > 0)
{
layers[0].parentNode.removeChild(layers[0]);
}
};
Spry.Widget.MenuBar.prototype.clearMenus = function(root)
{
var menus = root.getElementsByTagName('ul');
for(var i=0; i<menus.length; i++)
{
this.hideSubmenu(menus[i]);
}
this.removeClassName(this.element, "MenuBarActive");
};
Spry.Widget.MenuBar.prototype.bubbledTextEvent = function()
{
return (navigator.vendor == 'Apple Computer, Inc.' && (event.target == event.relatedTarget.parentNode || (event.eventPhase == 3 && event.target.parentNode == event.relatedTarget)));
};
Spry.Widget.MenuBar.prototype.showSubmenu = function(menu)
{
if(this.currMenu)
{
this.clearMenus(this.currMenu);
this.currMenu = null;
}
if(menu)
{
this.addClassName(menu, "MenuBarSubmenuVisible");
if(typeof document.all != 'undefined' && typeof window.opera == 'undefined' && navigator.vendor != 'KDE')
{
if(!this.hasClassName(this.element, "MenuBarHorizontal") || menu.parentNode.parentNode != this.element)
{
menu.style.top = menu.parentNode.offsetTop + 'px';
}
}
if(typeof document.uniqueID != "undefined")
{
this.createIframeLayer(menu);
}
}
this.addClassName(this.element, "MenuBarActive");
};
Spry.Widget.MenuBar.prototype.hideSubmenu = function(menu)
{
if(menu)
{
this.removeClassName(menu, "MenuBarSubmenuVisible");
if(typeof document.all != 'undefined' && typeof window.opera == 'undefined' && navigator.vendor != 'KDE')
{
menu.style.top = '';
menu.style.left = '';
}
this.removeIframeLayer(menu);
}
};
Spry.Widget.MenuBar.prototype.initialize = function(listitem, element, isie)
{
var opentime, closetime;
var link = listitem.getElementsByTagName('a')[0];
var submenus = listitem.getElementsByTagName('ul');
var menu = (submenus.length > 0 ? submenus[0] : null);
var hasSubMenu = false;
if(menu)
{
this.addClassName(link, "MenuBarItemSubmenu");
hasSubMenu = true;
}
if(!isie)
{
listitem.contains = function(testNode)
{
if(testNode == null)
{
return false;
}
if(testNode == this)
{
return true;
}
else
{
return this.contains(testNode.parentNode);
}
};
}
var self = this;
this.addEventListener(listitem, 'click', function(e)
{
if(self.bubbledTextEvent())
{
return;
}
clearTimeout(closetime);
if(self.currMenu == listitem)
{
self.currMenu = null;
}
self.addClassName(link, hasSubMenu ? "MenuBarItemSubmenuHover" : "MenuBarItemHover");
if(menu && !self.hasClassName(menu, "MenuBarSubmenuVisible"))
{
opentime = window.setTimeout(function(){self.showSubmenu(menu);}, 250);
}
}, false);
this.addEventListener(listitem, 'mouseout', function(e)
{
if(self.bubbledTextEvent())
{
return;
}
var related = (typeof e.relatedTarget != 'undefined' ? e.relatedTarget : e.toElement);
if(!listitem.contains(related))
{
clearTimeout(opentime);
self.currMenu = listitem;
self.removeClassName(link, hasSubMenu ? "MenuBarItemSubmenuHover" : "MenuBarItemHover");
if(menu)
{
closetime = window.setTimeout(function(){self.hideSubmenu(menu);}, 600);
}
}
}, false);
};