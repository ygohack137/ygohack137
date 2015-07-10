--Chaos Field
function c13790657.initial_effect(c)
	c:EnableCounterPermit(0x3001)
	c:SetCounterLimit(0x3001,6)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,13790657+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c13790657.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,13790657)
	e2:SetCost(c13790657.thcost)
	e2:SetTarget(c13790657.thtg1)
	e2:SetOperation(c13790657.thop1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c13790657.descon)
	e3:SetOperation(c13790657.desop)
	c:RegisterEffect(e3)
end
function c13790657.filter(c)
	return (c:IsSetCard(0xbd) and c:IsType(TYPE_MONSTER))
		or (c:IsSetCard(0x1373) and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_RITUAL)) and c:IsAbleToHand()
end
function c13790657.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or not Duel.IsExistingMatchingCard(c13790657.filter,tp,LOCATION_DECK,0,1,nil) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c13790657.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

function c13790657.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_HAND+LOCATION_ONFIELD) and c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_MONSTER)
end
function c13790657.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c13790657.cfilter,1,nil,tp)
end
function c13790657.desop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x3001,1)
end

function c13790657.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x3001,3,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x3001,3,REASON_COST)
end
function c13790657.thfilter1(c)
	return c:IsType(TYPE_SPELL) and c:IsType(TYPE_RITUAL) and c:IsAbleToHand()
end
function c13790657.thtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13790657.thfilter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13790657.thop1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c13790657.thfilter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
