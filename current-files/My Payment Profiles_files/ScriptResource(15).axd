﻿(function(a){a.RadContextMenuEventArgs=function(b){a.RadContextMenuEventArgs.initializeBase(this);
this._domEvent=b||null;
};
a.RadContextMenuEventArgs.prototype={get_domEvent:function(){return this._domEvent;
}};
a.RadContextMenuEventArgs.registerClass("Telerik.Web.UI.RadContextMenuEventArgs",Sys.EventArgs);
a.RadContextMenuShownEventArgs=function(c,b){a.RadContextMenuShownEventArgs.initializeBase(this);
this._targetElement=c;
this._domEvent=b||null;
};
a.RadContextMenuShownEventArgs.prototype={get_targetElement:function(){return this._targetElement;
},get_domEvent:function(){return this._domEvent;
}};
a.RadContextMenuShownEventArgs.registerClass("Telerik.Web.UI.RadContextMenuShownEventArgs",Sys.EventArgs);
a.RadContextMenuCancelEventArgs=function(c,b){a.RadContextMenuCancelEventArgs.initializeBase(this);
this._targetElement=c;
this._domEvent=b;
};
a.RadContextMenuCancelEventArgs.prototype={get_targetElement:function(){return this._targetElement;
},get_domEvent:function(){return this._domEvent;
}};
a.RadContextMenuCancelEventArgs.registerClass("Telerik.Web.UI.RadContextMenuCancelEventArgs",Sys.CancelEventArgs);
a.RadContextMenuShowingEventArgs=function(c,b){a.RadContextMenuShowingEventArgs.initializeBase(this,[c,b]);
};
a.RadContextMenuShowingEventArgs.registerClass("Telerik.Web.UI.RadContextMenuShowingEventArgs",a.RadContextMenuCancelEventArgs);
a.RadContextMenuItemEventArgs=function(c,d,b){a.RadContextMenuItemEventArgs.initializeBase(this,[c,b]);
this._targetElement=d;
};
a.RadContextMenuItemEventArgs.prototype={get_targetElement:function(){return this._targetElement;
}};
a.RadContextMenuItemEventArgs.registerClass("Telerik.Web.UI.RadContextMenuItemEventArgs",a.RadMenuItemEventArgs);
a.RadContextMenuItemCancelEventArgs=function(c,d,b){a.RadContextMenuItemCancelEventArgs.initializeBase(this,[c,b]);
this._targetElement=d;
};
a.RadContextMenuItemCancelEventArgs.prototype={get_targetElement:function(){return this._targetElement;
}};
a.RadContextMenuItemCancelEventArgs.registerClass("Telerik.Web.UI.RadContextMenuItemCancelEventArgs",a.RadMenuItemCancelEventArgs);
})(Telerik.Web.UI);
(function(a,c){Type.registerNamespace("Telerik.Web.UI");
var b=Telerik.Web.UI;
b.ContextMenuTargetType=function(){throw Error.notImplemented();
};
b.ContextMenuTargetType.prototype={Control:0,Element:1,TagName:2,Document:3};
b.ContextMenuTargetType.registerEnum("Telerik.Web.UI.ContextMenuTargetType");
b.RadContextMenu=function(d){b.RadContextMenu.initializeBase(this,[d]);
this._enableSelection=false;
this._targets=[];
this._targetElements=null;
this._shown=false;
this._scrollWrapElement=null;
this._scroller=null;
this._animatedElement=null;
this._slide=null;
this._collapseAnimationEndedDelegate=null;
this._detached=false;
this._currentTarget=null;
this._flow=b.ItemFlow.Vertical;
};
b.RadContextMenu.contextMenus={};
b.RadContextMenu.hideAll=function(){for(var d in b.RadContextMenu.contextMenus){b.RadContextMenu.contextMenus[d].hide();
}};
b.RadContextMenu._getAllHidden=function(){for(var d in b.RadContextMenu.contextMenus){if(b.RadContextMenu.contextMenus[d]._shown){return false;
}}return true;
};
b.RadContextMenu.prototype={initialize:function(){var e=this.get_element(),d=this._getContextMenuElement();
e.style.display="block";
e.style.visibility="hidden";
d.style.display="block";
d.style.visibility="hidden";
b.RadContextMenu.callBaseMethod(this,"initialize");
b.RadMenu.ExtendWithView(this,this,"ExtendContextMenuWithView");
d.style.display="none";
d.style.visibility="visible";
d.id=this.get_id()+"_detached";
e.style.display="none";
e.style.visibility="visible";
d.style.zIndex=this._originalZIndex;
if(!this.get_childListElement()){this._createChildListElement();
}this.get_childListElement().style.cssFloat="left";
b.RadContextMenu.contextMenus[this.get_id()]=this;
this._elementContextMenu=Function.createDelegate(this,this._elementContextMenu);
this._attachShowHandlers();
this._documentClickHandler=Function.createDelegate(this,this._documentClickHandler);
$telerik.addHandler(document,"click",this._documentClickHandler);
if(this._isUsedOnTouchDevices){this._itemClickingHandler=Function.createDelegate(this,this._mobileItemClickingHandler);
this.add_itemClicking(this._itemClickingHandler);
this._itemClickedHandler=Function.createDelegate(this,this._mobileItemClickedHandler);
this.add_itemClicked(this._itemClickedHandler);
}else{this._itemClickedHandler=Function.createDelegate(this,this._itemClickedHandler);
this.add_itemClicked(this._itemClickedHandler);
}this._initializeAnimation();
this._initializeScroller();
},dispose:function(){if(this._detached){this.attachContextMenu();
}$telerik.removeHandler(document,"click",this._documentClickHandler);
if(Sys&&Sys.WebForms){var d=Sys.WebForms.PageRequestManager.getInstance();
if(d&&d.get_isInAsyncPostBack()){$telerik.disposeElement(this._getContextMenuElement());
}}this._detachShowHandlers();
this._targetElements=null;
this._contextMenuElement=null;
if(this._collapseAnimationEndedDelegate){if(this._slide){this._slide.remove_collapseAnimationEnded(this._collapseAnimationEndedDelegate);
}this._collapseAnimationEndedDelegate=null;
}if(this._slide){this._slide.dispose();
this._slide=null;
}if(this._scroller){this._scroller.dispose();
this._scroller=null;
}delete Telerik.Web.UI.RadContextMenu.contextMenus[this.get_id()];
b.RadContextMenu.callBaseMethod(this,"dispose");
},_createChildListElement:function(){var e=this._getContextMenuElement(),f=a("div.rmScrollWrap",e);
if(this._childListElementCssClass==null){if(f.length==1){this._childListElementCssClass="rmActive rmVertical";
}else{this._childListElementCssClass="rmActive rmVertical rmGroup rmLevel1";
}}if(!this._childListElementCssClass){return;
}var d=a("<ul class='"+this._childListElementCssClass+"'></ul>");
if(f.length==1){d.appendTo(f);
}else{d.appendTo(e);
}},_initializeEventMap:function(){this._eventMap.initialize(this,this._getContextMenuElement());
},_childInserted:function(d,e,f){b.RadContextMenu.callBaseMethod(this,"_childInserted",[d,e,f]);
if(f._shown){if(e._getWidth()>0||e.get_isSeparator()){b.RadMenu._adjustChildrenWidth(f);
}}},_attachShowHandlers:function(){var d=$telerik.isOpera&&!("oncontextmenu" in document.documentElement)?"mousedown":"contextmenu";
var f=this._getTargetElements();
for(var e=0;
e<f.length;
e++){$telerik.addHandler(f[e],d,this._elementContextMenu);
}$telerik.addHandler(this._getContextMenuElement(),d,this._elementContextMenu);
},_detachShowHandlers:function(){var d=$telerik.isOpera&&!("oncontextmenu" in document.documentElement)?"mousedown":"contextmenu";
var h=this._getTargetElements();
for(var f=0;
f<h.length;
f++){var g=h[f];
try{$telerik.removeHandler(g,d,this._elementContextMenu);
}catch(e){}}try{$telerik.removeHandler(this._getContextMenuElement(),d,this._elementContextMenu);
}catch(e){}},_documentClickHandler:function(d){var f=this._getContextMenuElement();
if(!$telerik.isDescendant(f,d.target)){this.close();
this._clicked=false;
this._hide(d);
}},_itemClickedHandler:function(e,d){if(!this.get_clickToOpen()){this._hide(d.get_domEvent());
}},_mobileItemClickingHandler:function(f,d){var e=d.get_item();
e._shouldHide=((e.get_expandMode()==b.MenuItemExpandMode.ClientSide&&(e.get_isOpen()||e.get_items().get_count()==0))||(e._itemsLoaded&&e.get_selected()))&&!e._shouldNavigate();
},_mobileItemClickedHandler:function(f,d){var e=d.get_item();
if(e._shouldHide){e._shouldHide=false;
this._hide(d.get_domEvent());
}},_initializeAnimation:function(){var d=this._getAnimatedElement();
if(d){this._slide=new b.jSlide(d,this.get_expandAnimation(),this.get_collapseAnimation(),this.get_enableOverlay());
this._slide.initialize();
this._slide.set_direction(this._getSlideDirection());
this._collapseAnimationEndedDelegate=Function.createDelegate(this,this._onCollapseAnimationEnded);
this._slide.add_collapseAnimationEnded(this._collapseAnimationEndedDelegate);
this._expandAnimationStartedDelegate=Function.createDelegate(this,this._onExpandAnimationStarted);
this._slide.add_expandAnimationStarted(this._expandAnimationStartedDelegate);
this._expandAnimationEndedDelegate=Function.createDelegate(this,this._onExpandAnimationEnded);
this._slide.add_expandAnimationEnded(this._expandAnimationEndedDelegate);
}},_getMainElement:function(){return this._getContextMenuElement();
},_getSlideDirection:function(){var d=this.get_defaultGroupSettings().get_expandDirection();
if(d==b.ExpandDirection.Auto){return b.ExpandDirection.Down;
}return d;
},_getScrollWrapElement:function(){var d=this._getContextMenuElement();
if(!this._scrollWrapElement){if(this.get_defaultGroupSettings().get_height()||this.get_defaultGroupSettings().get_width()){this._scrollWrapElement=$telerik.getFirstChildByTagName(d,"div",0);
}}return this._scrollWrapElement;
},_getAnimatedElement:function(){if(!this._animatedElement){this._animatedElement=this._getScrollWrapElement()||this.get_childListElement();
}return this._animatedElement;
},_onExpandAnimationEnded:function(){},_onExpandAnimationStarted:function(){},_onCollapseAnimationEnded:function(){this._restoreZIndex();
},_getTargetElements:function(){if(this._targetElements==null){this._targetElements=[];
for(var d=0;
d<this._targets.length;
d++){this._addTargetElements(this._targets[d]);
}}return this._targetElements;
},_addTargetElements:function(f){switch(f.type){case b.ContextMenuTargetType.Document:this._addTargetElement(document);
break;
case b.ContextMenuTargetType.Control:case b.ContextMenuTargetType.Element:this._addTargetElement($get(f.id));
break;
case b.ContextMenuTargetType.TagName:var e=document.getElementsByTagName(f.tagName);
for(var d=0;
d<e.length;
d++){this._addTargetElement(e[d]);
}break;
}},_addTargetElement:function(d){if(d){this._targetElements[this._targetElements.length]=d;
}},_adjustPositionForScreenBoundaries:function(e,f){var g=b.RadMenu._getViewPortSize();
var d=this._getContextMenuElement();
f=Math.min(f,g.height-d.offsetHeight);
if(this.get_rightToLeft()){e=Math.max(0,e);
}else{e=Math.min(e,g.width-d.offsetWidth);
}if(isNaN(e)){e=0;
}if(isNaN(f)){f=0;
}this._getContextMenuElement().style.left=e+"px";
this._getContextMenuElement().style.top=f+"px";
},_detach:function(){if(!$telerik.isIE||document.readyState=="complete"||document.readyState=="interactive"){var f=false;
if(arguments[0]){var d=$telerik.$(arguments[0].target||arguments[0].srcElement).parents("form");
f=d[d.length-1];
}if(!f){f=document.forms[0];
}this._getContextMenuElement().parentNode.removeChild(this._getContextMenuElement());
var e=f||document.body;
e.insertBefore(this._getContextMenuElement(),e.firstChild);
this._detached=true;
}},_getContextMenuElement:function(){if(!this._contextMenuElement){this._contextMenuElement=$telerik.getFirstChildByTagName(this.get_element(),"div",0);
}return this._contextMenuElement;
},_isMainElementDescendant:function(d){return $telerik.isDescendant(this._getContextMenuElement(),d);
},_getExtendedItemClickingEventArgs:function(d){return new b.RadContextMenuItemCancelEventArgs(d.get_item(),this._targetElement,d.get_domEvent());
},_getExtendedItemClickedEventArgs:function(d){return new b.RadContextMenuItemEventArgs(d.get_item(),this._targetElement,d.get_domEvent());
},_updateScrollWrapSize:function(){var e=this._getScrollWrapElement();
var d=this.get_childListElement();
if(!e){return;
}if(!e.style.height){e.style.height=d.offsetHeight+"px";
}e.style.width=d.offsetWidth+"px";
},_getAnimationContainer:function(){return this._getContextMenuElement();
},_initializeScroller:function(){var d=this._getScrollWrapElement();
if(d){if(this._scroller){this._scroller.dispose();
}this._scroller=new b.MenuItemScroller(this,this.get_childListElement(),b.ItemFlow.Vertical);
this._scroller.initialize();
}},_adjustRootItemsWidthOnShow:function(){var f=this.get_items();
var g=f.get_count();
for(var d=0;
d<g;
d++){var e=f.getItem(d);
if(e._adjustSiblingsWidthOnShow){e._adjustSiblingsWidth();
e._adjustSiblingsWidthOnShow=false;
return;
}}},_elementContextMenu:function(d){if($telerik.isDescendantOrSelf(this._getContextMenuElement(),d.target)){$telerik.cancelRawEvent(d);
return false;
}if($telerik.isOpera&&!("oncontextmenu" in document.documentElement)){if(d.button!=2){return;
}}this.show(d);
},_showAt:function(f,i,d){var g=this._getMainElement();
b.RadContextMenu.hideAll();
if(!b.RadContextMenu._getAllHidden()){return;
}this._shown=true;
this._ensureDecorationElements();
if(!this._detached){this._detach(d);
this._getContextMenuElement().style.visibility="hidden";
this._getContextMenuElement().style.display="block";
this.repaint();
}var h=this.get_openedItem();
if(h){h.close();
}this._slide.show();
this._adjustRootItemsWidthOnShow();
this._updateScrollWrapSize();
this._slide.updateSize();
if(this._rightToLeft){f-=this._getContextMenuElement().offsetWidth;
}this._getContextMenuElement().style.left=f+"px";
this._getContextMenuElement().style.top=i+"px";
if(this.get_enableScreenBoundaryDetection()){this._adjustPositionForScreenBoundaries(f,i);
}if(this._scroller){this._scroller.updateState();
}this._getContextMenuElement().style.visibility="visible";
this._slide.expand();
if(a(g).attr("tabindex")){g.focus();
}this.raise_shown(new b.RadContextMenuShownEventArgs(this._targetElement,d||null));
},_focus:function(d){var f=this.get_focusedItem();
if(a(d.target).closest(".rmTemplate").length>0){return false;
}if(f){f.focus(d);
}},_onKeyDown:function(d){var g=this.get_focusedItem();
var i=d.keyCode?d.keyCode:d.rawEvent.keyCode;
var h=this.get_items();
if(a(d.target).closest(".rmTemplate").length>0){return false;
}if(i===Sys.UI.Key.esc){this._hide();
return false;
}if(!g){switch(i){case Sys.UI.Key.up:var j=h.getItem(h.get_count()-1);
if(j.get_visible()){j.focus(d);
}else{j.focusPreviousItem(d);
}break;
case Sys.UI.Key.down:var f=h.getItem(0);
if(f.get_visible()){f.focus(d);
}else{f.focusNextItem(d);
}break;
case Sys.UI.Key.enter:this._hide();
break;
}return false;
}return this._keyboardNavigator._onKeyDown(d,g);
},_hide:function(d){if(!this._shown){return;
}var f=new b.RadContextMenuCancelEventArgs(this._targetElement,d||null);
this.raise_hiding(f);
if(f.get_cancel()){return;
}this._shown=false;
this._slide.collapse();
this.raise_hidden(new b.RadContextMenuEventArgs(d||null));
this._targetElement=null;
this._clicked=false;
if(this._focusedItem){this._focusedItem._setFocused(false,d);
}this._clearSelectedItem();
var g=this.get_openedItem();
if(g){g.close();
}},_adjustRootItemWidth:function(){},_applyRtlStyles:function(){b.RadContextMenu.callBaseMethod(this,"_applyRtlStyles");
var d="RadMenu_Context_rtl";
if(this._skin){d+=" RadMenu_"+this._skin+"_Context_rtl";
}a(this._getMainElement()).addClass(d);
},get_childListElement:function(){if(this._getScrollWrapElement()){this._childListElement=$telerik.getFirstChildByTagName(this._getScrollWrapElement(),"ul",0);
}if(!this._childListElement){this._childListElement=$telerik.getFirstChildByTagName(this._getContextMenuElement(),"ul",0);
}return this._childListElement;
},set_targets:function(d){this._targets=d;
},get_targets:function(){return this._targets;
},get_contextMenuElement:function(){return this._getContextMenuElement();
},show:function(h){var k,i,j,f,g=document.documentElement,d=document.body;
if(this._shown){this._hide();
}if(h.target){this._targetElement=h.target;
}else{if(h.srcElement){this._targetElement=h.srcElement;
}}k=new b.RadContextMenuShowingEventArgs(this._targetElement||null,h||null);
this.raise_showing(k);
if(k.get_cancel()){return;
}i=$telerik.getTouchEventLocation(h,"client");
j={scrollLeft:($telerik.isIE7&&this._rightToLeft)?(g.scrollWidth-g.offsetWidth-Math.abs(g.scrollLeft)+Telerik.Web.Browser.scrollBarWidth):(g.scrollLeft+d.scrollLeft),scrollTop:Math.max(g.scrollTop,d.scrollTop)};
f={left:i.x+((($telerik.isIE7||$telerik.isIE8)&&this._rightToLeft)?-j.scrollLeft:j.scrollLeft),top:i.y+j.scrollTop};
this._showAt(f.left,f.top,h);
$telerik.cancelRawEvent(h);
},showAt:function(d,f){var e=new b.RadContextMenuShowingEventArgs();
this.raise_showing(e);
if(e.get_cancel()){return;
}this._showAt(d,f,null);
},hide:function(){this._hide(null);
},repaint:function(){b.RadMenu._adjustRootItemWidth(this.get_id(),this.get_childListElement());
},addTargetElement:function(d){if(d){this._addTargetElement(d);
var e=$telerik.isOpera&&!("oncontextmenu" in document.documentElement)?"mousedown":"contextmenu";
$telerik.addHandler(d,e,this._elementContextMenu);
}},removeTargetElement:function(d){if(!d){return;
}var e=$telerik.isOpera&&!("oncontextmenu" in document.documentElement)?"mousedown":"contextmenu";
if(Array.remove(this._targetElements,d)){$telerik.removeHandler(d,e,this._elementContextMenu);
}},attachContextMenu:function(){if(!this._detached){return;
}this._getContextMenuElement().parentNode.removeChild(this._getContextMenuElement());
this.get_element().insertBefore(this._getContextMenuElement(),$get(this.get_clientStateFieldID()));
this._detached=false;
},add_showing:function(d){this.get_events().addHandler("showing",d);
},remove_showing:function(d){this.get_events().removeHandler("showing",d);
},raise_showing:function(d){if(this._fireEvents){this.raiseEvent("showing",d);
}},add_shown:function(d){this.get_events().addHandler("shown",d);
},remove_shown:function(d){this.get_events().removeHandler("shown",d);
},raise_shown:function(d){if(this._fireEvents){this.raiseEvent("shown",d);
}},add_hiding:function(d){this.get_events().addHandler("hiding",d);
},remove_hiding:function(d){this.get_events().removeHandler("hiding",d);
},raise_hiding:function(d){if(this._fireEvents){this.raiseEvent("hiding",d);
}},add_hidden:function(d){this.get_events().addHandler("hidden",d);
},remove_hidden:function(d){this.get_events().removeHandler("hidden",d);
},raise_hidden:function(d){if(this._fireEvents){this.raiseEvent("hidden",d);
}}};
b.RadContextMenu.registerClass("Telerik.Web.UI.RadContextMenu",b.RadMenu);
})($telerik.$);
