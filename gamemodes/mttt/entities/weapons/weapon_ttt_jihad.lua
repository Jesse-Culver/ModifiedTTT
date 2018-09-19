AddCSLuaFile()

if CLIENT then
   SWEP.PrintName = "Jihad Bomb"
   SWEP.Slot = 6
   SWEP.Icon = "vgui/ttt/icon_c4"
   SWEP.IconLetter = "I"
end

SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "slam"

SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 5
SWEP.Primary.ClipSize = -1
SWEP.Primary.ClipMax = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = Model( "models/weapons/cstrike/c_c4.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_c4.mdl" )

SWEP.Kind = WEAPON_EQUIP1
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "none"
SWEP.CanBuy = { ROLE_TRAITOR }
SWEP.InLoadoutFor = { nil }
SWEP.LimitedStock = true
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = true

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
   self:SetNextPrimaryFire( CurTime() + 2 )

   local effectdata = EffectData()
   effectdata:SetOrigin( self.Owner:GetPos() )
   effectdata:SetNormal( self.Owner:GetPos() )
   effectdata:SetMagnitude( 8 )
   effectdata:SetScale( 1 )
   effectdata:SetRadius( 78 )
   util.Effect( "Sparks", effectdata )
   self.BaseClass.ShootEffects( self )

   if ( SERVER ) then
      timer.Simple( 2, function() self:Explode() end )
      self.Owner:EmitSound( "NPC_FastZombie.Scream" )
   end
end

function SWEP:Explode()
   local k, v

   local ent = ents.Create( "env_explosion" )
   ent:SetPos( self.Owner:GetPos() )
   ent:SetOwner( self.Owner )
   ent:SetKeyValue( "iMagnitude", "200" )
   ent:Spawn()
   ent:Fire( "Explode", 0, 0 )
   ent:EmitSound( "d3_citadel.timestop_explosion_3", 140 )
   self:Remove()
end

if CLIENT then
   SWEP.EquipMenuData = {
      type = "Weapon",
      desc = "Sacrifice yourself to Allah.\n\nYour 72 virgins await."
   }
end
