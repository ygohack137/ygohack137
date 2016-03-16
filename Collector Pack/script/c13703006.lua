--Odd-Eyes Mirage Dragon
function c13703006.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCountLimit(1)
	e1:SetCondition(c13703006.spcon)
	e1:SetTarget(c13703006.sptg)
	e1:SetOperation(c13703006.pspop)
	c:RegisterEffect(e1)

	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9485511,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c13703006.tgcon)
	e2:SetTarget(c13703006.indtg)
	e2:SetOperation(c13703006.indop)
	c:RegisterEffect(e2)
end
function c13703006.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousControler()==tp
		and c:IsSetCard(0x99) and c:IsType(TYPE_PENDULUM)
end
function c13703006.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c13703006.cfilter,1,nil,tp)
end
function c13703006.filter(c)
	return (c:GetSequence()==6 or c:GetSequence()==7) and c:IsDestructable()
end
function c13703006.pcfilter(c)
	return c:IsSetCard(0x99) and c:IsType(TYPE_PENDULUM) and not c:IsForbidden() and c:GetCode()~=13703006
end
function c13703006.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c13703006.filter(chkc) end
	if chk==0 then return  Duel.IsExistingTarget(c13703006.filter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c13703006.filter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c13703006.pspop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local g=Duel.SelectMatchingCard(tp,c13703006.pcfilter,tp,LOCATION_EXTRA,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
end


function c13703006.tgcon(e)
	local tp=e:GetHandlerPlayer()
	local tc1=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
	local tc2=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	return (tc1 and tc1:IsSetCard(0x99)) or (tc2 and tc2:IsSetCard(0x99))
end
function c13703006.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x99)
end
function c13703006.indtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c13703006.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13703006.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c13703006.filter2,tp,LOCATION_MZONE,0,1,1,nil)
end
function c13703006.indop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCountLimit(1)
		e1:SetValue(c13703006.valcon)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c13703006.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
