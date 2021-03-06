--Electromagnet Warrior Beta
function c13722001.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCountLimit(1,13722001)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c13722001.target)
	e1:SetOperation(c13722001.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(48686504,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1)
	e3:SetCost(c13722001.cost2)
	e3:SetTarget(c13722001.target2)
	e3:SetOperation(c13722001.operation2)
	c:RegisterEffect(e3)
end
function c13722001.filter(c)
	return (c:IsCode(13722000) or c:IsCode(13722002) or c:IsCode(99785935) or c:IsCode(39256679) or c:IsCode(11549357)) and c:IsAbleToHand()
end
function c13722001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13722001.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13722001.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c13722001.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

function c13722001.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c13722001.filter2(c,e,tp)
	return (c:IsCode(99785935) or c:IsCode(39256679) or c:IsCode(11549357)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c13722001.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and tp~=Duel.GetTurnPlayer()
		and Duel.IsExistingMatchingCard(c13722001.filter2,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
end
function c13722001.operation2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c13722001.filter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
--Original Magnet Warriors  (c:IsCode(99785935) or c:IsCode(39256679) or c:IsCode(11549357))
