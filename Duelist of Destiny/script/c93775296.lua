--Reverse Reuse
function c93775296.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c93775296.target)
	e1:SetOperation(c93775296.activate)
	c:RegisterEffect(e1)
end
function c93775296.filter(c,e,tp)
	return c:IsType(TYPE_FLIP) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENCE,POS_FACEDOWN_DEFENCE,1-tp)
end
function c93775296.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c83778600.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0
		and Duel.IsExistingTarget(c93775296.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c93775296.filter,tp,LOCATION_GRAVE,0,1,2,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c93775296.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,0,LOCATION_MZONE)
	local sg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	Duel.SpecialSummon(sg,0,tp,1-tp,false,false,POS_FACEUP_DEFENCE+POS_FACEDOWN_DEFENCE)
	Duel.ConfirmCards(1-tp,sg)
end
