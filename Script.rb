#===============================================================================
# * Watch in the Pokegear Menu - by FL (Credits will be apreciated)
#===============================================================================
#
# This script is for Pokémon Essentials. It add a watch in the Pokégear menu.
#
#===============================================================================
#
# To this script works, put it above main. At PScreen_Pokegear script section 
# (PokemonPokegear in older versions), before line 'Graphics.transition' add
# line 'initializeWatch'.
#
# I suggest you to change the pokégear pokegearbg.png and pokegearbgf.png (at 
# Graphics\Pictures).
#
#===============================================================================

class Scene_Pokegear
  alias :_old_fl_watch_update :update
  def update
    updateDateIfNecessary
    _old_fl_watch_update
  end
  
  def initializeWatch
    @sprites["overlay"]=BitmapSprite.new(
        Graphics.width,Graphics.height,@viewport)
    pbSetSystemFont(@sprites["overlay"].bitmap)
    @dateString=""
    updateDateIfNecessary
  end
  
  def updateDateIfNecessary
    showSeconds = true # Make it false to won't show the seconds
    newDate = pbGetTimeNow.strftime(showSeconds ? "%I:%M:%S %p" : "%I:%M %p")
    return false if @dateString==newDate
    @dateString=newDate  
    overlay=@sprites["overlay"].bitmap
    overlay.clear 
    baseColor=Color.new(72,72,72)
    shadowColor=Color.new(160,160,160)
    textPositions=[
       [@dateString,Graphics.width/2,-2,2,baseColor,shadowColor]]
    pbDrawTextPositions(overlay,textPositions)
    return true
  end
end