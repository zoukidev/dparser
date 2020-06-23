class ank.gapi.controls.ChatArea extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "ChatArea";
   static var STOP_SCROLL_LENGTH = 6;
   var _bSelectable = false;
   var _bWordWrap = true;
   var _sScrollBarSide = "right";
   var _nScrollBarMargin = 0;
   var _bHideScrollBar = false;
   var _bUseMouseWheel = true;
   var _bInvalidateMaxScrollStop = false;
   var _nPreviousMaxscroll = 1;
   function ChatArea()
   {
      super();
   }
   function __set__selectable(bSelectable)
   {
      this._bSelectable = bSelectable;
      if(this._bInitialized)
      {
         this.addToQueue({object:this,method:this.setTextFieldProperties});
      }
      return this.__get__selectable();
   }
   function __get__selectable()
   {
      return this._bSelectable;
   }
   function __set__wordWrap(bWordWrap)
   {
      this._bWordWrap = bWordWrap;
      if(this._bInitialized)
      {
         this.addToQueue({object:this,method:this.setTextFieldProperties});
      }
      return this.__get__wordWrap();
   }
   function __get__wordWrap()
   {
      return this._bWordWrap;
   }
   function __set__text(sText)
   {
      this._sText = sText;
      if(this.initialized)
      {
         this.setTextFieldProperties();
      }
      return this.__get__text();
   }
   function __get__text()
   {
      return this._tText.text;
   }
   function __get__htmlText()
   {
      return this._tText.htmlText;
   }
   function __set__scrollBarSide(sScrollBarSide)
   {
      this._sScrollBarSide = sScrollBarSide;
      return this.__get__scrollBarSide();
   }
   function __get__scrollBarSide()
   {
      return this._sScrollBarSide;
   }
   function __set__scrollBarMargin(nScrollBarMargin)
   {
      this._nScrollBarMargin = nScrollBarMargin;
      return this.__get__scrollBarMargin();
   }
   function __get__scrollBarMargin()
   {
      return this._nScrollBarMargin;
   }
   function __set__hideScrollBar(bHideScrollBar)
   {
      this._bHideScrollBar = bHideScrollBar;
      return this.__get__hideScrollBar();
   }
   function __get__hideScrollBar()
   {
      return this._bHideScrollBar;
   }
   function __set__useMouseWheel(bUseMouseWheel)
   {
      this._bUseMouseWheel = bUseMouseWheel;
      return this.__get__useMouseWheel();
   }
   function __get__useMouseWheel()
   {
      return this._bUseMouseWheel;
   }
   function init()
   {
      super.init(false,ank.gapi.controls.ChatArea.CLASS_NAME);
      this._tfFormatter = new TextFormat();
   }
   function createChildren()
   {
      this.createTextField("_tText",10,0,0,this.__width - 2,this.__height - 2);
      this._tText._x = 1;
      this._tText._y = 1;
      this._tText.addListener(this);
      this._tText.onSetFocus = function()
      {
         this._parent.onSetFocus();
      };
      this._tText.onKillFocus = function()
      {
         this._parent.onKillFocus();
      };
      this._tText.mouseWheelEnabled = true;
      this.addToQueue({object:this,method:this.setTextFieldProperties});
      ank.utils.MouseEvents.addListener(this);
   }
   function size()
   {
      super.size();
      this.arrange();
   }
   function arrange()
   {
      this._tText._height = this.__height;
      this._tText._width = this.__width;
      this._bInvalidateMaxScrollStop = true;
      this.setTextFieldProperties();
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      this._tfFormatter = new TextFormat();
      this._tfFormatter.font = _loc2_.font;
      this._tfFormatter.align = _loc2_.align;
      this._tfFormatter.size = _loc2_.size;
      this._tfFormatter.color = _loc2_.color;
      this._tfFormatter.bold = _loc2_.bold;
      this._tfFormatter.italic = _loc2_.italic;
      this._tText.embedFonts = _loc2_.embedfonts;
      this._tText.antiAliasType = _loc2_.antialiastype;
      this._sbVertical.styleName = _loc2_.scrollbarstyle;
      if(_loc2_.filters != undefined)
      {
         this._tText.filters = _loc2_.filters;
      }
   }
   function setTextFieldProperties()
   {
      if(this._tText != undefined)
      {
         this._tText.wordWrap = !this._bWordWrap?false:true;
         this._tText.multiline = true;
         this._tText.selectable = this._bSelectable;
         this._tText.embedFonts = this.getStyle().embedfonts;
         this._tText.type = "dynamic";
         this._tText.html = true;
         if(this._tfFormatter.font != undefined)
         {
            if(this._sText != undefined)
            {
               this._nPreviousMaxscroll = this._tText.maxscroll;
               this.setTextWithBottomStart();
            }
            this._tText.setNewTextFormat(this._tfFormatter);
            this._tText.setTextFormat(this._tfFormatter);
         }
         this.onChanged();
      }
   }
   function addScrollBar()
   {
      if(this._sbVertical == undefined)
      {
         this.attachMovie("ScrollBar","_sbVertical",20,{styleName:this.getStyle().scrollbarstyle,_visible:!this._bHideScrollBar});
         this._sbVertical.addEventListener("scroll",this);
      }
      this._sbVertical.setSize(this.__height - 2);
      this._sbVertical._y = 1;
      this._sbVertical._x = this._sScrollBarSide != "right"?0:this.__width - this._sbVertical._width - 3;
      if(this._bHideScrollBar)
      {
         this._tText._width = this.__width;
         this._tText._x = 0;
      }
      else
      {
         this._tText._width = this.__width - this._sbVertical._width - 3 - this._nScrollBarMargin;
         this._tText._x = this._sScrollBarSide != "right"?this._sbVertical._width + this._nScrollBarMargin:0;
      }
      this.setScrollBarPosition();
      if(Math.abs(this._nPreviousMaxscroll - this._tText.scroll) < ank.gapi.controls.ChatArea.STOP_SCROLL_LENGTH || this._bInvalidateMaxScrollStop)
      {
         this._tText.scroll = this._tText.maxscroll;
      }
      this._bInvalidateMaxScrollStop = false;
   }
   function setScrollBarPosition()
   {
      var _loc2_ = this._tText.textHeight;
      var _loc3_ = 0.9 * this._tText._height / _loc2_ * this._tText.maxscroll;
      this._sbVertical.setScrollProperties(_loc3_,0,this._tText.maxscroll);
      this._sbVertical.scrollPosition = this._tText.scroll;
   }
   function setTextWithBottomStart()
   {
      this._tText.text = "";
      var _loc2_ = 0;
      while(this._tText.maxscroll == 1 && _loc2_ < 50)
      {
         this._tText.text = this._tText.text + "\n";
         _loc2_ = _loc2_ + 1;
      }
      this._tText.htmlText = this._tText.htmlText + this._sText;
   }
   function onMouseWheel(nDelta, mc)
   {
      if(!this._bUseMouseWheel)
      {
         return undefined;
      }
      if(String(mc._target).indexOf(this._target) != -1)
      {
         this._sbVertical.scrollPosition = this._sbVertical.scrollPosition - nDelta;
      }
   }
   function onChanged()
   {
      this.addScrollBar();
   }
   function onScroller()
   {
      this.setScrollBarPosition();
   }
   function scroll(oEvent)
   {
      if(oEvent.target == this._sbVertical)
      {
         this._tText.scroll = oEvent.target.scrollPosition;
      }
   }
   function onHref(sParams)
   {
      this.dispatchEvent({type:"href",params:sParams});
   }
   function onSetFocus()
   {
      getURL("FSCommand:" add "trapallkeys","false");
   }
   function onKillFocus()
   {
      getURL("FSCommand:" add "trapallkeys","true");
   }
}
