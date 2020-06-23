class dofus.managers.InteractionsManager extends dofus.utils.ApiElement
{
   static var STATE_MOVE_SINGLE = 0;
   static var STATE_SELECT = 1;
   function InteractionsManager(playerManager, oAPI)
   {
      super();
      this.initialize(playerManager,oAPI);
   }
   function initialize(playerManager, oAPI)
   {
      super.initialize(oAPI);
      this._playerManager = playerManager;
   }
   function setState(bFight)
   {
      if(bFight)
      {
         this._state = dofus.managers.InteractionsManager.STATE_SELECT;
         this._playerManager.lastClickedCell = null;
      }
      else
      {
         this._state = dofus.managers.InteractionsManager.STATE_MOVE_SINGLE;
      }
   }
   function calculatePath(mapHandler, cell, bRelease, bIsFight, bIgnoreSprites, bAllDir)
   {
      if(cell == this._playerManager.data.cellNum)
      {
         return false;
      }
      var _loc8_ = mapHandler.getCellData(cell);
      var _loc9_ = !bIgnoreSprites?_loc8_.spriteOnID != undefined?true:false:false;
      if(_loc9_)
      {
         return false;
      }
      if(_loc8_.movement == 0)
      {
         return false;
      }
      if(_loc8_.movement == 1 && bIsFight)
      {
         return false;
      }
      switch(this._state)
      {
         case dofus.managers.InteractionsManager.STATE_MOVE_SINGLE:
            this.api.datacenter.Basics.interactionsManager_path = ank.battlefield.utils.Pathfinding.pathFind(mapHandler,this._playerManager.data.cellNum,cell,{bAllDirections:bAllDir,bIgnoreSprites:bIgnoreSprites});
            if(this.api.datacenter.Basics.interactionsManager_path != null)
            {
               return true;
            }
            return false;
         case dofus.managers.InteractionsManager.STATE_SELECT:
            if(bRelease)
            {
               this.api.gfx.select(this.convertToSimplePath(this.api.datacenter.Basics.interactionsManager_path),dofus.Constants.CELL_PATH_SELECT_COLOR);
               return this.api.datacenter.Basics.interactionsManager_path != null;
            }
            this.api.datacenter.Basics.interactionsManager_path = ank.battlefield.utils.Pathfinding.pathFind(mapHandler,this._playerManager.data.cellNum,cell,{bAllDirections:false,nMaxLength:(!bIsFight?500:this._playerManager.data.MP)});
            this.api.gfx.unSelect(true);
            this.api.gfx.select(this.convertToSimplePath(this.api.datacenter.Basics.interactionsManager_path),dofus.Constants.CELL_PATH_OVER_COLOR);
         default:
            return false;
      }
   }
   function convertToSimplePath(aFullPath)
   {
      var _loc3_ = new Array();
      for(var k in aFullPath)
      {
         _loc3_.push(aFullPath[k].num);
      }
      return _loc3_;
   }
}
