AddCSLuaFile()

SWEP.HoldType = "normal"

if CLIENT then
	SWEP.PrintName = "Item Crate"
	SWEP.Slot = 6

	SWEP.ViewModelFOV = 10

	SWEP.EquipMenuData = {
		type = "weapon",
		desc = "Contains a random weapon,\n might be a non buyable weapon!"
	};
	SWEP.Icon = "vgui/mttt/icon_item_crate"
end

SWEP.Base = "weapon_tttbase"

SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/items_item_crate.mdl"

SWEP.DrawCrosshair = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 1.0

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 1.0

SWEP.Kind = WEAPON_EQUIP1
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.LimitedStock = true

SWEP.AllowDrop = false

SWEP.NoSights = true

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:CrateCreate()
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryAttack(CurTime() + self.Primary.Delay)
	selef:CrateCreate()
end

local throwsound = Sound( "Weapon_SLAM.SatchelThrow" )

function SWEP:CrateCreate()
	if SERVER then
		local ply = self.Owner
		if not IsValid(ply) then return end

		if self.Planted then return end

		local vsrc = ply:GetShootPos()
		local vang = ply:GetAimVector()
		local vvel = ply:GetVelocity()

		local vthrow = vvel + vang * 200

		local crate = ents.Create("mttt_item_crate")
		if IsValid(crate) then
			crate:SetPos(vsrc + vang * 10)
			crate:Spawn()

			crate:PhysWake()
			local phys = crate:GetPhysicsObject()
			if IsValid(phys) then
				phys:SetVelocity(vthrow)
			end
			self:Remove()

			self.Planted = true
		end
	end
   self:EmitSound(throwsound)
end

function SWEP:Reload()
   return false
end

function SWEP:OnRemove()
   if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then
      RunConsoleCommand("lastinv")
   end
	 self:Holster()
end

function SWEP:Deploy()
   if SERVER and IsValid(self.Owner) then
      self.Owner:DrawViewModel(false)
   end
   return true
end

function SWEP:DrawWorldModel()
end

function SWEP:DrawWorldModelTranslucent()
end

function SWEP:OnDrop()
	self:Remove()
end
