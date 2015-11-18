--Priestess with Eyes of Blue
function c13701815.initial_effect(c)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13701815,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,13701815)
	e1:SetTarget(c13701815.sptg)
	e1:SetOperation(c13701815.spop)
	c:RegisterEffect(e1)
	--target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(13701815,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_BECOME_TARGET)
	e2:SetCountLimit(1,13701815)
	e2:SetCost(c13701815.thcost)
	e2:SetCondition(c13701815.thcon)
	e2:SetTarget(c13701815.thtg)
	e2:SetOperation(c13701815.thop)
	c:RegisterEffect(e2)
end

function c13701815.thfilter(c,e,tp)
	return c:IsSetCard(0xe0) and c:IsAbleToHand()
end
function c13701815.thfilter2(c,e,tp)
	return c:IsType(TYPE_EFFECT) and c:IsAbleToGraveAsCost()
end
function c13701815.tdfilter(c)
	return c:IsSetCard(0xe0) and c:IsAbleToDeck()
end
function c13701815.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c13701815.tdfilter(chkc) end
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingTarget(c13701815.tdfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c13701815.tdfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13701815.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)~=0
		and tc:IsLocation(LOCATION_DECK+LOCATION_EXTRA) and c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c13701815.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	return true
end
function c13701815.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsContains(e:GetHandler())
end
function c13701815.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c13701815.thfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) 
		and Duel.IsExistingMatchingCard(c13701815.thfilter2,tp,LOCATION_MZONE,0,1,e:GetHandler(),e,tp) end
	local g=Duel.SelectMatchingCard(tp,c13701815.thfilter2,tp,LOCATION_MZONE,0,1,1,e:GetHandler(),e,tp)
	Duel.SendtoGrave(g,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13701815.thop(e,tp,eg,ep,ev,re,r,rp)
	local rg=Duel.GetMatchingGroup(c13701815.thfilter,tp,LOCATION_DECK,0,nil)
	local g=Group.CreateGroup()
	local tc=rg:GetFirst()
	local ct=0
	while tc and ct~=2 do 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sc=rg:Select(tp,1,1,nil):GetFirst()
		g:AddCard(sc)
		ct=ct+1
		tc=rg:GetNext()
		rg:Remove(Card.IsCode,nil,sc:GetCode())
		if ct==2 or rg:GetCount()==0 or not Duel.SelectYesNo(tp,aux.Stringid(13701815,0)) then ct=2 end
	end
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
