--Toon Barrel Dragon
function c13790638.initial_effect(c)
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c13790638.atklimit)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetCondition(c13790638.sdescon)
	e4:SetOperation(c13790638.sdesop)
	c:RegisterEffect(e4)
	--direct attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_DIRECT_ATTACK)
	e5:SetCondition(c13790638.dircon)
	c:RegisterEffect(e5)
	--damage
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(79875176,0))
	e6:SetCategory(CATEGORY_DAMAGE)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetTarget(c13790638.damtg)
	e6:SetOperation(c13790638.damop)
	c:RegisterEffect(e6)
end
function c13790638.atklimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c13790638.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==15259703 and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c13790638.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c13790638.sfilter,1,nil)
end
function c13790638.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c13790638.dirfilter1(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c13790638.dirfilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c13790638.dircon(e)
	return Duel.IsExistingMatchingCard(c13790638.dirfilter1,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
		and not Duel.IsExistingMatchingCard(c13790638.dirfilter2,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end

function c13790638.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,3)
end
function c13790638.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local c1,c2,c3=Duel.TossCoin(tp,3)
		if c1+c2+c3<2 then return end
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
