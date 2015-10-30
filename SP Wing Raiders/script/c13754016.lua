--Super Quantum Mecha Ship Magna-Carrier
function c13754016.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--xyz level
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(13754016,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(c13754016.tcost)
	e2:SetTarget(c13754016.ttarget)
	e2:SetOperation(c13754016.tactivate)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(13754016,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_FZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCost(c13754016.cost)
	e3:SetTarget(c13754016.target)
	e3:SetOperation(c13754016.activate)
	c:RegisterEffect(e3)
end
function c13754016.tcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c13754016.filter1(c,e,tp)
	local att=c:GetAttribute()
	return c:IsFaceup() and c:IsSetCard(0x1e72) and (not c:IsType(TYPE_XYZ))
		and Duel.IsExistingMatchingCard(c13754016.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,att)
end
function c13754016.filter2(c,e,tp,mc,att)
	return c:GetAttribute()==att  and c:IsSetCard(0x1e72) and c:IsType(TYPE_XYZ) and mc:IsCanBeXyzMaterial(c)
		and c:GetCode()~=13754008 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c13754016.ttarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c13754016.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c13754016.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c13754016.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c13754016.tactivate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c13754016.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetAttribute())
	local sc=g:GetFirst()
	if sc then
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end


function c13754016.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c13754016.filter(c,e,tp)
	return c:IsSetCard(0x1e72) and c:IsType(TYPE_XYZ) and c:GetCode()~=13754008
end
function c13754016.rfilter(c,e,tp)
	return c:GetCode()==13754008 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c13754016.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.GetMatchingGroup(c13754016.filter,tp,LOCATION_GRAVE+LOCATION_MZONE,0,nil,e,tp,e:GetHandler())
	local gf=Duel.GetMatchingGroup(c13754016.filter,tp,LOCATION_MZONE,0,nil,e,tp,e:GetHandler())
	local ct=g:GetClassCount(Card.GetCode)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_MZONE) and chkc:IsControler(tp) and c13754016.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and ct>2
		and Duel.IsExistingTarget(c13754016.filter,tp,LOCATION_GRAVE+LOCATION_MZONE,0,3,nil,e,tp)
		and Duel.IsExistingTarget(c13754016.filter,tp,LOCATION_GRAVE+LOCATION_MZONE,0,3,nil,e,tp) end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then
	local g1=gf:Select(tp,1,1,nil)
	g:Remove(Card.IsCode,nil,g1:GetFirst():GetCode())
	local g2=g:Select(tp,1,1,nil)
	g:Remove(Card.IsCode,nil,g2:GetFirst():GetCode())
	g1:Merge(g2)
	g2=g:Select(tp,1,1,nil)
	g1:Merge(g2)
	Duel.SetTargetCard(g1)
	else
	local g1=g:Select(tp,1,1,nil)
	g:Remove(Card.IsCode,nil,g1:GetFirst():GetCode())
	local g2=g:Select(tp,1,1,nil)
	g:Remove(Card.IsCode,nil,g2:GetFirst():GetCode())
	g1:Merge(g2)
	g2=g:Select(tp,1,1,nil)
	g1:Merge(g2)
	Duel.SetTargetCard(g1)
	end
end


function c13754016.activate(e,tp,eg,ep,ev,re,r,rp)
	local mg0=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local mg=mg0:Filter(Card.IsRelateToEffect,nil,e)
	if mg:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c13754016.rfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,mg0)
	local sc=g:GetFirst()
	if sc then
	local tc=mg:GetFirst()
	local sg=Group.CreateGroup()
		while tc do
			sg:Merge(tc:GetOverlayGroup())
			tc=mg:GetNext()
			Duel.Overlay(sc,sg)
		end
		Duel.Overlay(sc,mg)
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
	end
end
