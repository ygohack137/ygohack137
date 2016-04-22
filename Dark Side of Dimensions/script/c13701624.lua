--Metalhold the Mobile Fortified Fortress
function c13701624.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c13701624.target)
	e1:SetOperation(c13701624.activate)
	c:RegisterEffect(e1)
end
function c13701624.filter1(c,e,tp)
	return c:GetLevel()==4 and c:IsRace(RACE_MACHINE)
end
function c13701624.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(c13701624.filter1,tp,LOCATION_MZONE,0,1,nil) and Duel.IsPlayerCanSpecialSummonMonster(tp,13701624,0,0x21,0,0,4,RACE_MACHINE,ATTRIBUTE_EARTH) 
	and ( Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and  Duel.GetLocationCount(tp,LOCATION_SZONE)>0) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	local g=Duel.SelectTarget(tp,c13701624.filter1,tp,LOCATION_MZONE,0,1,4,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c13701624.filter(c,e)
	return c:IsFacedown() and c:IsRelateToEffect(e)
end
function c13701624.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if ft<g:GetCount() then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,13701624,0,0x21,0,2000,4,RACE_MACHINE,ATTRIBUTE_EARTH) then return end
	c:AddTrapMonsterAttribute(TYPE_EFFECT,ATTRIBUTE_EARTH,RACE_MACHINE,4,0,0)
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	c:TrapMonsterBlock()
	
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local tc=g:GetFirst()
	while tc do
		local atk=tc:GetTextAttack()
		Duel.Equip(tp,tc,c,true,true)
			if atk>0 then
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
				e1:SetCode(EFFECT_EQUIP_LIMIT)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				e1:SetValue(c13701624.eqlimit)
				tc:RegisterEffect(e1)
				local e2=Effect.CreateEffect(c)
				e2:SetType(EFFECT_TYPE_EQUIP)
				e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
				e2:SetCode(EFFECT_UPDATE_ATTACK)
				e2:SetReset(RESET_EVENT+0x1fe0000)
				e2:SetValue(atk)
				tc:RegisterEffect(e2)
			end
		tc=g:GetNext()
	end
	Duel.EquipComplete()
		local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetValue(c13701624.tg)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SELECT_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetTargetRange(0,0xff)
	e2:SetValue(c13701624.tglimit)
	c:RegisterEffect(e2)
end
function c13701624.tg(e,c)
	return c:IsFaceup() and c:GetCode()~=13701624
end
function c13701624.tglimit(e,re,c)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and c:IsControler(e:GetHandlerPlayer()) and c:IsLocation(LOCATION_MZONE) 
		and c:IsFaceup() and c:GetCode()~=13701624
end
function c13701624.eqlimit(e,c)
	return e:GetOwner()==c
end

