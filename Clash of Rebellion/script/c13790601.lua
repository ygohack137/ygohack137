--Magical Abductor
function c13790601.initial_effect(c)
	c:EnableCounterPermit(0x3001)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--add counter
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetCode(EVENT_CHAINING)
	e0:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e0:SetOperation(aux.chainreg)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e1:SetOperation(c13790601.acop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(70791313,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e2:SetCost(c13790601.drcost)
	e2:SetTarget(c13790601.drtg)
	e2:SetOperation(c13790601.drop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c13790601.attackup)
	c:RegisterEffect(e3)
end
function c13790601.acop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and rp~=tp and e:GetHandler():GetFlagEffect(1)>0 then
		e:GetHandler():AddCounter(0x3001,1)
	end
end
function c13790601.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x3001,3,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x3001,3,REASON_COST)
end
function c13790601.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (e:GetHandler():GetLocation()==LOCATION_SZONE and Duel.IsExistingMatchingCard(c13790601.filter,tp,LOCATION_DECK,0,1,nil)) 
	or (e:GetHandler():GetLocation()==LOCATION_MZONE and Duel.IsExistingMatchingCard(c13790601.filter2,tp,LOCATION_DECK,0,1,nil)) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13790601.filter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c13790601.filter2(c)
	return c:GetLevel()==1 and c:IsRace(RACE_SPELLCASTER) and c:IsAbleToHand()
end
function c13790601.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	if e:GetHandler():GetLocation()==LOCATION_SZONE and Duel.IsExistingMatchingCard(c13790601.filter,tp,LOCATION_DECK,0,1,nil) then
	local g=Duel.SelectMatchingCard(tp,c13790601.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	end
	if e:GetHandler():GetLocation()==LOCATION_MZONE and Duel.IsExistingMatchingCard(c13790601.filter2,tp,LOCATION_DECK,0,1,nil) then
	local g=Duel.SelectMatchingCard(tp,c13790601.filter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	end
end

function c13790601.attackup(e,c)
	return c:GetCounter(0x3001)*100
end

