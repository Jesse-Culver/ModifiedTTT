AddCSLuaFile()

if CLIENT then
   SWEP.PrintName = "Dual Elites"
   SWEP.Slot = 1
   SWEP.Icon = "vgui/mttt/icon_dualelites"
   SWEP.IconLetter = "y"
end

SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "duel"

SWEP.Primary.Ammo = "AlyxGun"
SWEP.Primary.Delay = 0.25
SWEP.Primary.Recoil = 4
SWEP.Primary.Cone = 0.03
SWEP.Primary.Damage = 20
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 12
SWEP.Primary.ClipMax = 36
SWEP.Primary.DefaultClip = 12
SWEP.Primary.Sound = Sound( "Weapon_Elite.Single" )

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 55
SWEP.ViewModel = Model( "models/weapons/cstrike/c_pist_elite.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_pist_elite.mdl" )

SWEP.Kind = WEAPON_PISTOL
SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_ammo_revolver_ttt"
SWEP.InLoadoutFor = { nil }
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = true
function SWEP:SecondaryAttack()
  return
end