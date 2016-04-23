--Verserion the Electromagna Warrior
function c13722003.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c13722003.sspcon)
	e1:SetOperation(c13722003.sspop)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCondition(c13722003.spcon)
	e2:SetTarget(c13722003.sptg)
	e2:SetOperation(c13722003.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(28423537,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c13722003.descost)
	e3:SetTarget(c13722003.destg)
	e3:SetOperation(c13722003.desop)
	c:RegisterEffect(e3)
end
function c13722003.sspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD,0,1,nil,13722000)
	and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD,0,1,nil,13722001)
	and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD,0,1,nil,13722002)
end	
function c13722003.sspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD,0,1,1,nil,13722000)
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD,0,1,1,nil,13722001)
	local g3=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD,0,1,1,nil,13722002)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end

function c13722003.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetPreviousControler()==tp and c:IsReason(REASON_BATTLE) or (rp~=tp and c:IsReason(REASON_EFFECT))
end
function c13722003.spfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c13722003.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=2
		and Duel.IsExistingTarget(c13722003.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp,13722000)
		and Duel.IsExistingTarget(c13722003.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp,13722001)
		and Duel.IsExistingTarget(c13722003.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp,13722002) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c13722003.spfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp,13722000)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c13722003.spfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp,13722001)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g3=Duel.SelectTarget(tp,c13722003.spfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp,13722002)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,3,0,0)
end
function c13722003.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if g:GetCount()~=3 or ft<3 then return end
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end

function c13722003.rfilter(c)
	return c:IsAbleToRemoveAsCost() and (c:IsCode(13722000) or c:IsCode(13722001) or c:IsCode(13722002))
	 or (c:IsCode(99785935) or c:IsCode(39256679) or c:IsCode(11549357))
end
function c13722003.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13722003.rfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c13722003.rfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c13722003.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c13722003.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
