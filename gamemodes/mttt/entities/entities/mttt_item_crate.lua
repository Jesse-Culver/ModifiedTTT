AddCSLuaFile()

ENT.Type = "anim"
ENT.Model = Model("models/items/item_item_crate.mdl")

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	if SERVER then
		self:SetMaxHealth(20)
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetMass(20)
		end
	end
	self:SetHealth(20)
	--DO NOT INDENT
	local defaultContents = [[
weapon_ttt_teleport
weapon_zm_rifle
weapon_ttt_flaregun
weapon_ttt_health_station]]
	--Check for directory
	if file.IsDir("mttt", "DATA") != true then
		file.CreateDir("mttt")
	end
	--Check for file
	if file.Read("mttt/item_crate_contents.txt") == nil then
		file.Write("mttt/item_crate_contents.txt", defaultContents)
	end
end

local opensound = Sound("weapons/explode5.wav")

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	if self:Health() < 0 then
		sound.Play(opensound, self:GetPos())
		self:SpawnItem()
	end
end

local mttt_item_crate_contents = {
};

function ENT:SpawnItem()
	if SERVER then
		local cpos = self:GetPos()
		local cvel = self:GetVelocity()
		local contentsFile = file.Read("mttt/item_crate_contents.txt")
		local contentsTableTemp = string.Explode("\n", contentsFile)
		for k, v in pairs(contentsTableTemp) do
			table.insert(mttt_item_crate_contents, k, v)
		end
		
		local item = ents.Create(table.Random(mttt_item_crate_contents))
			item:SetPos(cpos)
			item:Spawn()
			item:PhysWake()
			local phys = item:GetPhysicsObject()
			if IsValid(phys) then
				phys:SetVelocity(cvel)
			end
		self:Remove()
	end
end