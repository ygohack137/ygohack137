--Ruins of the Great Divine Dragon
function c13718203.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c13718203.condition)
	e1:SetTarget(c13718203.target)
	e1:SetOperation(c13718203.operation)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(63014935,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c13718203.damcost)
	e2:SetTarget(c13718203.damtg)
	e2:SetOperation(c13718203.damop)
	c:RegisterEffect(e2)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(97439806,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(c13718203.cost)
	e1:SetTarget(c13718203.tg)
	e1:SetOperation(c13718203.op)
	c:RegisterEffect(e1)
end
function c13718203.cfilter(c)
	return c:IsFaceup() and not c:IsPreviousLocation(LOCATION_GRAVE)
end
function c13718203.dfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON) and (c:GetLevel()==7 or c:GetLevel()==8)
end
function c13718203.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c13718203.cfilter,1,nil) and Duel.IsExistingMatchingCard(c13718203.dfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c13718203.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c13718203.cfilter,nil)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c13718203.filter(c,e)
	return c:IsFaceup() and not c:IsPreviousLocation(LOCATION_GRAVE) and c:IsRelateToEffect(e)
end
function c13718203.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c13718203.filter,nil,e)
	if g:GetCount()>0 then
	local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
			tc:RegisterEffect(e2)
			if tc:IsType(TYPE_TRAPMONSTER) then
				local e3=Effect.CreateEffect(e:GetHandler())
				e3:SetType(EFFECT_TYPE_SINGLE)
				e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
				e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
				tc:RegisterEffect(e3)
			end
			tc=g:GetNext()
		end
	end
end

function c13718203.costfilter1(c)
	return c:IsAbleToGraveAsCost() and c:IsFaceup()
end
function c13718203.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13718203.costfilter1,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c13718203.costfilter1,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c13718203.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,13718204,0,0x4011,0,0,1,RACE_DRAGON,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c13718203.damop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,13718204,0,0x4011,0,0,1,RACE_DRAGON,ATTRIBUTE_LIGHT) then return end
	local token=Duel.CreateToken(tp,13718204)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end

function c13718203.costfilter(c)
	return c:IsRace(RACE_DRAGON) and (c:GetLevel()==7 or c:GetLevel()==8)
end
function c13718203.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13718203.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c13718203.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c13718203.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c13718203.op(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,e:GetHandler())
	end
end

