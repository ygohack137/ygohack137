--D/D/D Cursed King Siegfried
function c13703007.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0xaf),1)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13703007,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,13703007)
	e1:SetHintTiming(0,0x1c0)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c13703007.negtg)
	e1:SetOperation(c13703007.negop)	
	c:RegisterEffect(e1)
	--return
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(64379430,0))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c13703007.retcon)
	e3:SetTarget(c13703007.rettg)
	e3:SetOperation(c13703007.retop)
	c:RegisterEffect(e3)
end
function c13703007.negtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and aux.disfilter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(aux.disfilter1,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,aux.disfilter1,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c13703007.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and not tc:IsDisabled() and tc:IsRelateToEffect(e) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_STANDBY)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_STANDBY)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_STANDBY)
			tc:RegisterEffect(e3)
		end
	end
end

function c13703007.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c13703007.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xae)
end
function c13703007.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13703007.filter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.SetTargetPlayer(tp)
	local rec=Duel.GetMatchingGroupCount(c13703007.filter,tp,LOCATION_SZONE,0,nil)*1000
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c13703007.retop(e,tp,eg,ep,ev,re,r,rp)
	local rec=Duel.GetMatchingGroupCount(c13703007.filter,tp,LOCATION_SZONE,0,nil)*1000
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Recover(p,rec,REASON_EFFECT)
end
