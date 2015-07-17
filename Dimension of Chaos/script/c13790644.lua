--D/D/D Caesar Ragnarok the Wave Complete Oblivion Overlord
function c13790644.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsSetCard,0x10af),aux.FilterBoolFunction(Card.IsSetCard,0x10af),true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c13790644.regcon)
	e1:SetTarget(c13790644.regtg)
	e1:SetOperation(c13790644.regop)
	c:RegisterEffect(e1)
end
function c13790644.regcon(e,tp,eg,ep,ev,re,r,rp)
	return (e:GetHandler()==Duel.GetAttacker() and Duel.GetAttackTarget()~=nil) or e:GetHandler()==Duel.GetAttackTarget()
end
function c13790644.thfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0xae) or c:IsSetCard(0xaf)) and c:IsAbleToHand()
end
function c13790644.eqfilter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c13790644.regtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local atk=e:GetHandler():GetBattleTarget()
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c13790644.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13790644.thfilter,tp,LOCATION_ONFIELD,0,1,nil)
	and Duel.IsExistingTarget(c13790644.eqfilter,tp,0,LOCATION_MZONE,1,atk) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c13790644.thfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c13790644.regop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local atk=e:GetHandler():GetBattleTarget()
	local c=e:GetHandler()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT) then
		local dg=Duel.GetMatchingGroup(c13790644.eqfilter,tp,0,LOCATION_MZONE,atk)
		if dg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local g=Duel.SelectMatchingCard(tp,c13790644.eqfilter,tp,0,LOCATION_MZONE,1,1,atk)
		local equip=g:GetFirst()
		local atk=equip:GetTextAttack()
		if atk<0 then atk=0 end
		if not Duel.Equip(tp,equip,c,false) then return end
		--Add Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c13790644.eqlimit)
		equip:RegisterEffect(e1)
		if atk>0 then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(atk)
			equip:RegisterEffect(e2)
		end
		end
	end
end
function c13790644.eqlimit(e,c)
	return e:GetOwner()==c
end
