--Metalphosis Combination
function c13790921.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c13790921.drcon)
	e2:SetTarget(c13790921.drtg)
	e2:SetOperation(c13790921.drop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCondition(c13790921.thcon)
	e3:SetTarget(c13790921.thtg)
	e3:SetOperation(c13790921.thop)
	c:RegisterEffect(e3)
end
function c13790921.drcon(e,tp,eg,ep,ev,re,r,rp)
	local tg=eg:GetFirst()
	return tg:GetSummonType()==SUMMON_TYPE_FUSION
end
function c13790921.filter(c,lv)
	local tlv=c:GetLevel()
	return tlv<lv and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x1371) and c:IsAbleToHand()
end
function c13790921.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local lv=eg:GetFirst():GetLevel()
	if chkc then return chkc:GetControler()==tp and chkc:GetLocation()==LOCATION_GRAVE end
	if chk==0 then return Duel.IsExistingTarget(c13790921.filter,tp,LOCATION_GRAVE,0,1,nil,lv) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c13790921.filter,tp,LOCATION_GRAVE,0,1,1,nil,lv)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c13790921.drop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c13790921.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c13790921.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x1371) and c:IsAbleToHand()
end
function c13790921.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13790921.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13790921.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c13790921.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
