class ank.battlefield.mc.Points extends MovieClip
{
   var _bFinished = false;
   function Points(pointsHandler, nID, nRefY, sValue, nColor)
   {
      super();
      this.initialize(pointsHandler,nID,nRefY,sValue,nColor);
   }
   function initialize(pointsHandler, nID, nRefY, sValue, nColor)
   {
      this._pointsHandler = pointsHandler;
      this._nRefY = nRefY;
      this._nID = nID;
      this.createTextField("_tf",10,0,0,150,100);
      this._tf.autoSize = "left";
      this._tf.embedFonts = true;
      this._tf.selectable = false;
      this._tf.textColor = nColor;
      this._tf.text = sValue;
      this._tf.setTextFormat(ank.battlefield.Constants.SPRITE_POINTS_TEXTFORMAT);
      this._tf._x = - this._tf.textWidth / 2;
      this._tf._y = - this._tf.textHeight / 2;
      this._visible = false;
      this._nI = 0;
      this._nSz = 100;
      this._nVy = -20;
      this._nY = nRefY;
   }
   function animate()
   {
      this._visible = true;
      this.onEnterFrame = function()
      {
         this._xscale = this._nT;
         this._yscale = this._nT;
         this._nT = 100 + this._nSz * Math.sin(this._nI = this._nI + 1.2);
         this._nSz = this._nSz * 0.85;
         this._nY = this._nY + (this._nVy = this._nVy * 0.7);
         this._y = this._nY;
         var _loc2_ = this._nRefY - this._nY;
         if(_loc2_ > ank.battlefield.Constants.SPRITE_POINTS_OFFSET)
         {
            this.remove();
         }
         if(!this._bFinished)
         {
            if(_loc2_ > ank.battlefield.Constants.SPRITE_POINTS_OFFSET - 2)
            {
               this._bFinished = true;
               this._pointsHandler.onAnimateFinished(this._nID);
            }
         }
      };
   }
   function remove()
   {
      delete this.onEnterFrame;
      this.removeMovieClip();
   }
}
