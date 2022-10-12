#===============================================================================
# * Watch in the Pokegear Menu - by FL (Credits will be apreciated)
#===============================================================================
#
# This script is for Pokémon Essentials. It add a watch in the Pokégear menu.
#
#===============================================================================
#
# To this script works, put it above main. At PScreen_Pokegear script section, 
# before line 'pbFadeInAndShow(@sprites) { pbUpdate }' add line
# 'initializeWatch'.
#
# I suggest you to change the pokégear bg.png and bg_f.png (at 
# Graphics\Pictures\Pokegear).
#
#===============================================================================

if defined?(PluginManager) && !PluginManager.installed?("Pokegear Watch")
  PluginManager.register({                                                 
    :name    => "Pokegear Watch",                                        
    :version => "1.1.1",                                                     
    :link    => "https://www.pokecommunity.com/showthread.php?t=323464",             
    :credits => "FL"
  })
end

class PokemonPokegear_Scene
  alias :_old_fl_watch_update :pbUpdate
  def pbUpdate
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