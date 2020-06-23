class ank.battlefield.mc.ExternalContainer extends MovieClip
{
   function ExternalContainer()
   {
      super();
   }
   function initialize(sGroundFile)
   {
      this._sGroundFile = sGroundFile;
      this.clear();
   }
   function useCustomGroundGfxFile(bState)
   {
      if(bState)
      {
         this.InteractionCell = this.Ground.createEmptyMovieClip("InteractionCell",-400);
      }
   }
   function clear()
   {
      this.InteractionCell.removeMovieClip();
      this.createEmptyMovieClip("InteractionCell",100);
      if(this.Ground == undefined)
      {
         this.createEmptyMovieClip("Ground",200);
         this.Ground.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Ground"];
         if(ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
         {
            this._parent.onLoadInit(ank.battlefield.mc.ExternalContainer);
         }
         else
         {
            var _loc2_ = new MovieClipLoader();
            _loc2_.addListener(this._parent._parent);
            _loc2_.loadClip(this._sGroundFile,this.Ground);
         }
      }
      else
      {
         if(ank.battlefield.Constants.USE_STREAMING_FILES || ank.battlefield.Constants.STREAMING_METHOD == "compact")
         {
            for(var s in this.Ground)
            {
               if(typeof this.Ground[s] == "movieclip")
               {
                  if(ank.battlefield.Constants.STREAMING_METHOD == "compact" && (this.Ground[s]._name == "InteractionCell" || this.Ground[s]._name == "Select"))
                  {
                     continue;
                  }
                  this.Ground[s].unloadMovie();
                  this.Ground[s].removeMovieClip();
               }
            }
         }
         this.Ground.clear();
      }
      if(ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
      {
         for(var s in this.Object1)
         {
            if(typeof this.Object1[s] == "movieclip")
            {
               this.Object1[s].unloadMovie();
               this.Object1[s].removeMovieClip();
            }
         }
         this.Object1.clear();
      }
      this.Object1.removeMovieClip();
      this.createEmptyMovieClip("Object1",300);
      this.Object1.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Object1"];
      this.Grid.removeMovieClip();
      this.createEmptyMovieClip("Grid",400);
      this.Grid.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Grid"];
      this.Zone.removeMovieClip();
      this.createEmptyMovieClip("Zone",500);
      this.Zone.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Zone"];
      this.Select.removeMovieClip();
      this.createEmptyMovieClip("Select",600);
      this.Select.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Select"];
      this.Pointer.removeMovieClip();
      this.createEmptyMovieClip("Pointer",700);
      this.Pointer.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Pointer"];
      if(ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
      {
         for(var s in this.Object2)
         {
            if(typeof this.Object1[s] == "movieclip")
            {
               this.Object2[s].unloadMovie();
               this.Object2[s].removeMovieClip();
            }
         }
         this.Object2.clear();
      }
      this.Object2.removeMovieClip();
      this.createEmptyMovieClip("Object2",800);
      this.Object2.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["ExternalContainer/Object2"];
      this.Object2.__proto__ = MovieClip.prototype;
   }
}
