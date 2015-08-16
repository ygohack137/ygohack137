--Synchro Cracker
function c13753013.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c13753013.target)
	e1:SetOperation(c13753013.activate)
	c:RegisterEffect(e1)
end
function c13753013.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c13753013.filter2(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk) and c:IsDestructable()
end
function c13753013.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c13753013.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13753013.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c13753013.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c13753013.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) and c:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 then
		local dg=Duel.GetMatchingGroup(c13753013.filter2,tp,0,LOCATION_MZONE,nil,tc:GetAttack())
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
