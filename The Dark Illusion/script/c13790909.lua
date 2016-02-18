--Magician's Rod
function c13790909.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,137909091)
	e1:SetTarget(c13790909.target)
	e1:SetOperation(c13790909.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(54161401,0))
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCountLimit(1,137909092)
	e2:SetCondition(c13790909.spcon2)
	e2:SetCost(c13790909.cost)
	e2:SetTarget(c13790909.sptg2)
	e2:SetOperation(c13790909.spop2)
	c:RegisterEffect(e2)
end
function c13790909.filter(c)
	return c:IsAbleToHand() and c:IsType(TYPE_SPELL+TYPE_TRAP) --and c:IsSetCard(Dark Magician Related SetCode)
	and (c:GetCode()==1784686 or c:GetCode()==99789342 or c:GetCode()==2314238 or c:GetCode()==69542930 or c:GetCode()==87210505 
	or c:GetCode()==13604200 or c:GetCode()==63391643 or c:GetCode()==67227834 or c:GetCode()==75190122 or c:GetCode()==48680970
	or c:GetCode()==68334074 or c:GetCode()==13790911 or c:GetCode()==13790912 or c:GetCode()==13790910 or 46986414)
end
function c13790909.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13790909.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13790909.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c13790909.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end


function c13790909.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and re:GetHandler():IsType(TYPE_TRAP+TYPE_SPELL) and Duel.GetTurnPlayer()~=tp
end
function c13790909.rfilter(c)
	return c:IsRace(RACE_SPELLCASTER)
end	
function c13790909.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c13790909.rfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c13790909.rfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c13790909.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c13790909.spop2(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,e:GetHandler())
	end
end
