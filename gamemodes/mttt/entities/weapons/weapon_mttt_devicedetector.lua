--TODO:
-- Range cvar
-- Device list for dynamic device adding
AddCSLuaFile()

SWEP.HoldType = "magic"


if CLIENT then
   SWEP.PrintName = "Device Detector"
   SWEP.Slot = 7

   SWEP.ViewModelFOV = 54

   SWEP.EquipMenuData = {
      type = "Item",
      desc = "Find those nasty traitor devices easier"
   };

   SWEP.Icon = "vgui/mttt/icon_detector"
end

SWEP.Base = "weapon_tttbase"

SWEP.ViewModel          = Model("models/weapons/c_bugbait.mdl")
SWEP.WorldModel         = Model("models/weapons/w_bugbait.mdl")

SWEP.DrawCrosshair      = false
SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = false
SWEP.Primary.Ammo       = "none"
SWEP.Primary.Delay = 1.0

SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo     = "none"
SWEP.Secondary.Delay = 1.0

-- This is special equipment

SWEP.Kind = WEAPON_EQUIP
SWEP.CanBuy = {ROLE_DETECTIVE} -- only detectives can buy
SWEP.LimitedStock = false -- only buyable once
SWEP.UseHands  = true
SWEP.AllowDrop = true

SWEP.NoSights = true

local squeeze = Sound( "weapons/bugbait/bugbait_squeeze1.wav" )
local alert = Sound("ambient/creatures/teddy.wav")

function SWEP:PrimaryAttack()
   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
   self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
   self:EmitSound(squeeze)
   self:CheckForDevice()
   
end
function SWEP:SecondaryAttack()
end

function SWEP:CheckForDevice()
   local foundEnts = ents.FindInSphere(self:GetOwner():GetPos(), 300)
   for k, v in ipairs(foundEnts) do
      if(v:GetClass()=="mttt_annoyatron") then
         self:EmitSound(alert)
      end
   end
end

function SWEP:Reload()
   return false
end

function SWEP:Deploy()
   self:SendWeaponAnim( ACT_VM_IDLE )
   return true
end
