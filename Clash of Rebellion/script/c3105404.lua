--Brilliant Spark
function c3105404.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c3105404.condition)
	e1:SetTarget(c3105404.target)
	e1:SetOperation(c3105404.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetDescription(aux.Stringid(1264319,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,3105404)
	e2:SetCost(c3105404.thcost)
	e2:SetTarget(c3105404.thtg)
	e2:SetOperation(c3105404.thop)
	c:RegisterEffect(e2)
end
function c3105404.filter(c,tp)
	return c:GetPreviousControler()==tp and c:IsLocation(LOCATION_GRAVE) and c:IsSetCard(0x1047)
end
function c3105404.condition(e,tp,eg,ep,ev,re,r,rp,chk)
	return eg:IsExists(c3105404.filter,1,nil,tp)
end
function c3105404.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return eg:IsContains(chkc) and c3105404.filter(chkc,e,tp) end
	if chk==0 then return eg:IsExists(c3105404.filter,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=eg:FilterSelect(tp,c3105404.filter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
end
function c3105404.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	Duel.Damage(1-tp,tc:GetBaseAttack(),REASON_EFFECT)
end

function c3105404.thfilter(c)
	return c:IsSetCard(0x1047) and c:IsAbleToRemoveAsCost()
end
function c3105404.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3105404.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c3105404.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c3105404.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c3105404.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end
