--Raidraptor - Wild Vulture
function c13790613.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c13790613.spcon)
	e1:SetCost(c13790613.spcost)
	e1:SetTarget(c13790613.sptg)
	e1:SetOperation(c13790613.spop)
	c:RegisterEffect(e1)
	if not c13790613.global_check then
		c13790613.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetLabel(13790613)
		ge1:SetOperation(aux.sumreg)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge2:SetLabel(13790613)
		Duel.RegisterEffect(ge2,0)
	end
end
function c13790613.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(13790613)>0
end
function c13790613.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c13790613.spfilter(c,e,tp,slv)
	local lv=c:GetLevel()
	return lv>=1 and (not slv or lv==slv) and c:IsSetCard(0xba)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c13790613.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft<=0 then return false end
		if ft==1 then return Duel.IsExistingMatchingCard(c13790613.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,e:GetHandler(),e,tp,6)
		else
			local g=Duel.GetMatchingGroup(c13790613.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,e:GetHandler(),e,tp)
			return g:CheckWithSumEqual(Card.GetLevel,6,2,2)
		end
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c13790613.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if ft==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c13790613.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp,6)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	else
		local g=Duel.GetMatchingGroup(c13790613.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,nil,e,tp)
		if g:CheckWithSumEqual(Card.GetLevel,6,2,2) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:SelectWithSumEqual(tp,Card.GetLevel,6,2,2)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
