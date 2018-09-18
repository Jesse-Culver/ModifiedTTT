
AddCSLuaFile()



SWEP.PrintName          = "Russian Roulette"
SWEP.Slot               = 6

SWEP.ViewModelFOV       = 54
SWEP.ViewModelFlip      = false
SWEP.HoldType              = "normal"
SWEP.EquipMenuData = {
type = "BLANK Russian Roulette",
desc = "Always misses"
};

SWEP.Icon               = "vgui/ttt/icon_bullet"


SWEP.Base                  = "weapon_tttbase"

-- if I run out of ammo types, this weapon is one I could move to a custom ammo
-- handling strategy, because you never need to pick up ammo for it
SWEP.Primary.Ammo          = "AlyxGun"
SWEP.Primary.Recoil        = 0
SWEP.Primary.Damage        = 0
SWEP.Primary.Delay         = 5.0
SWEP.Primary.Cone          = 0
SWEP.Primary.ClipSize      = 0
SWEP.Primary.Automatic     = false
SWEP.Primary.DefaultClip   = 0
SWEP.Primary.ClipMax       = 0
SWEP.Primary.Sound         = Sound( "Weapon_357.Single" )

SWEP.Kind                  = WEAPON_EQUIP2
SWEP.CanBuy                = {ROLE_TRAITOR} -- only traitors can buy
SWEP.LimitedStock          = true -- only buyable once

SWEP.Tracer                = "AR2Tracer"

SWEP.UseHands              = true
SWEP.ViewModel             = Model("models/weapons/c_357.mdl")
SWEP.WorldModel            = Model("models/weapons/w_357.mdl")

local inUse = false

function SWEP:PullTrigger()

end

function SWEP:CanPrimaryAttack()
  return true;
end

function SWEP:PrimaryAttack()
  self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
  self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

  if not self:CanPrimaryAttack() then return end
  inUse = true

if SERVER then
  
  local response_table = {
    Sound( "npc_citizen.answer04"),
    Sound( "npc_citizen.answer05"),
    Sound( "npc_citizen.answer12"),
    Sound( "npc_citizen.answer17"),
    Sound( "npc_citizen.answer23"),
    Sound( "npc_citizen.answer22"),
    Sound( "npc_citizen.answer27"),
    Sound( "npc_citizen.die"),
    Sound( "npc_citizen.finally"),
    Sound( "npc_citizen.gethellout"),
    Sound( "npc_citizen.goodgod"),
    Sound( "npc_citizen.gordead_ans04"),
    Sound( "npc_citizen.gordead_ans05"),
    Sound( "npc_citizen.gordead_ans06"),
    Sound( "npc_citizen.gordead_ans10"),
    Sound( "npc_citizen.gordead_ans11"),
    Sound( "npc_citizen.gordead_ans12"),
    Sound( "npc_citizen.gordead_ans13"),
    Sound( "npc_citizen.gordead_ques02"),
    Sound( "npc_citizen.letsgo02"),
    Sound( "npc_citizen.ohno"),
    Sound( "npc_citizen.okimready03"),
    Sound( "npc_citizen.outofyourway02"),
    Sound( "npc_citizen.question03"),
    Sound( "npc_citizen.question02"),
    Sound( "npc_citizen.question07"),
    Sound( "npc_citizen.question10"),
    Sound( "npc_citizen.question13"),
    Sound( "npc_citizen.question18"),
    Sound( "npc_citizen.question21"),
    Sound( "npc_citizen.question30"),
    Sound( "npc_citizen.uhoh")
  };
  local ply = self:GetOwner()
  local gun = self
  sound.Play(table.Random(response_table), ply:GetPos())
  timer.Simple(3,function()
    sound.Play("Weapon_Pistol.Empty", ply:GetPos())
    inUse = false
  end)
end

if ( (game.SinglePlayer() && SERVER) || CLIENT ) then
  self:SetNWFloat( "LastShootTime", CurTime() )
end
end

function SWEP:SecondaryAttack()
  self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
  self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
  self:EmitSound( "Weapon_357.Spin" )
end

function SWEP:PreDrop()
  if inUse == true then
    return
  end
  return self.BaseClass.PreDrop(self)
end

function SWEP:Holster()
 if inUse == true then
  return false
 else
  return true
 end
end

function SWEP:Deploy()
  self:EmitSound( "Weapon_357.Spin" )
  if SERVER and IsValid(self:GetOwner()) then
     self:GetOwner():DrawViewModel(false)
  end

  self:DrawShadow(false)

  return true
end