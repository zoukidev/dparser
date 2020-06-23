class dofus.graphics.gapi.ui.PopupQuantity extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "PopupQuantity";
   var _nValue = 0;
   var _bUseAllStage = false;
   var _nMax = 1;
   var _nMin = 1;
   function PopupQuantity()
   {
      super();
   }
   function __set__value(nValue)
   {
      this._nValue = nValue;
      return this.__get__value();
   }
   function __set__max(nMax)
   {
      this._nMax = nMax;
      return this.__get__max();
   }
   function __set__min(nMin)
   {
      this._nMin = nMin;
      return this.__get__min();
   }
   function __set__useAllStage(bUseAllStage)
   {
      this._bUseAllStage = bUseAllStage;
      return this.__get__useAllStage();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.PopupQuantity.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._winBackground.addEventListener("complete",this);
      this._bgHidder.addEventListener("click",this);
      this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
   }
   function initWindowContent()
   {
      var _loc2_ = this._winBackground.content;
      _loc2_._btnOk.addEventListener("click",this);
      _loc2_._btnMax.addEventListener("click",this);
      _loc2_._btnMin.addEventListener("click",this);
      _loc2_._btnMax.label = this.api.lang.getText("MAX_WORD");
      _loc2_._btnMin.label = this.api.lang.getText("MIN_WORD");
      _loc2_._tiInput.restrict = "0-9";
      _loc2_._tiInput.text = this._nValue;
      _loc2_._tiInput.setFocus();
   }
   function placeWindow()
   {
      var _loc2_ = this._xmouse - this._winBackground.width;
      var _loc3_ = this._ymouse - this._winBackground._height;
      var _loc4_ = !this._bUseAllStage?this.gapi.screenWidth:Stage.width;
      var _loc5_ = !this._bUseAllStage?this.gapi.screenHeight:Stage.height;
      if(_loc2_ < 0)
      {
         _loc2_ = 0;
      }
      if(_loc3_ < 0)
      {
         _loc3_ = 0;
      }
      if(_loc2_ > _loc4_ - this._winBackground.width)
      {
         _loc2_ = _loc4_ - this._winBackground.width;
      }
      if(_loc3_ > _loc5_ - this._winBackground.height)
      {
         _loc3_ = _loc5_ - this._winBackground.height;
      }
      this._winBackground._x = _loc2_;
      this._winBackground._y = _loc3_;
   }
   function validate()
   {
      this.api.kernel.KeyManager.removeShortcutsListener(this);
      this.dispatchEvent({type:"validate",value:_global.parseInt(this._winBackground.content._tiInput.text,10),params:this._oParams});
   }
   function complete(oEvent)
   {
      this.placeWindow();
      this.addToQueue({object:this,method:this.initWindowContent});
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnOk":
            this.validate();
         case "_btnMax":
            this._winBackground.content._tiInput.text = this._nMax;
            this._winBackground.content._tiInput.setFocus();
            return undefined;
         case "_btnMin":
            this._winBackground.content._tiInput.text = this._nMin;
            this._winBackground.content._tiInput.setFocus();
            return undefined;
         case "_bgHidder":
         default:
            this.unloadThis();
      }
   }
   function onShortcut(sShortcut)
   {
      if(sShortcut == "ACCEPT_CURRENT_DIALOG")
      {
         this.validate();
         this.unloadThis();
         return false;
      }
      return true;
   }
}
