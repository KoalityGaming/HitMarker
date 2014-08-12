--======== Copyleft © 2010, Andrew McWatters, Some rights reserved. =========--
--
-- Purpose: Displays MW2-esque hit markers on damage.
--
--===========================================================================--
AddCSLuaFile()
local bHitActive = false
local bHitSound = false
local flFrameTime = 0
local x
local y

local Underwater = {}
Underwater.BulletImpact =
{
	"physics/surfaces/underwater_impact_bullet1.wav",
	"physics/surfaces/underwater_impact_bullet2.wav",
	"physics/surfaces/underwater_impact_bullet3.wav"
}

hook.Add( "PlayerTraceAttack", "PlayerHitMarker", function( ply, dmginfo, dir, trace )
  if ( dmginfo:GetAttacker() == LocalPlayer() ) then
    bHitActive = true
	bHitSound = true
	flFrameTime = CurTime() + FrameTime() * 10
  end
end )

hook.Add( "HUDPaint", "CHitMarker", function()

  local player	= LocalPlayer()
  if ( !player:Alive() ) then return end

  // Ask the gamemode if it's ok to do this
  if ( !gamemode.Call( "HUDShouldDraw", "CHitMarker" ) ) then return end

  if ( bHitSound ) then
    bHitSound = false
	surface.PlaySound( table.Random( Underwater.BulletImpact ) )
  end

  if ( bHitActive and flFrameTime > CurTime() ) then
	x = ScrW() / 2
	y = ScrH() / 2
	surface.SetDrawColor( 255, 220, 0, 200 )
	surface.DrawLine( x - 6, y - 5, x - 11, y - 10 )
	surface.DrawLine( x + 5, y - 5, x + 10, y - 10 )
	surface.DrawLine( x - 6, y + 5, x - 11, y + 10 )
	surface.DrawLine( x + 5, y + 5, x + 10, y + 10 )
  else
    bHitActive = false
  end

end )
