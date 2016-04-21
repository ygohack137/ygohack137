--Number 45: Crumble Logos
function c13703007.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,2,2,nil,nil,5)
	c:EnableReviveLimit()
	--target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76067258,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c13703007.cost)
	e1:SetTarget(c13703007.target)
	e1:SetOperation(c13703007.operation)
	c:RegisterEffect(e1)
end
c13703007.xyz_number=45
function c13703007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c13703007.filter(c,ec)
	return c:IsFaceup() and not c:IsDisabled() and (not c:IsType(TYPE_NORMAL) or bit.band(c:GetOriginalType(),TYPE_EFFECT)~=0)
	and not ec:IsHasCardTarget(c)
end
function c13703007.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField() and chkc~=c and c13703007.filter(chkc,c) end
	if chk==0 then return Duel.IsExistingTarget(c13703007.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c13703007.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,c,c)
end
function c13703007.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c13703007.rcon)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetCondition(c13703007.rcon)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			e3:SetCondition(c13703007.rcon)
			tc:RegisterEffect(e3)
		end
	local e4=Effect.CreateEffect(tc)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetTargetRange(1,1)
	e4:SetValue(c13703007.aclimit)
	e4:SetLabel(tc:GetCode())
	Duel.RegisterEffect(e4,tp)
	local e5=Effect.CreateEffect(tc)
	e5:SetLabel(tc:GetFieldID())
	Duel.RegisterEffect(e5,tp)
	e4:SetLabelObject(e5)
	end
end
function c13703007.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c13703007.aclimit(e,re,tp)
	if not e:GetHandler():IsOnField() then return false end
	local rc=re:GetHandler()
	return rc:IsCode(e:GetLabel())
end
