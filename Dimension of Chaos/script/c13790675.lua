--Greydle Split
function c13790675.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c13790675.condition)
	e1:SetTarget(c13790675.target)
	e1:SetOperation(c13790675.operation)
	c:RegisterEffect(e1)
end
function c13790675.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c13790675.filter(c)
	return c:IsFaceup()
end
function c13790675.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c13790675.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13790675.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c13790675.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c13790675.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		c:CancelToGrave()
		--Atkup
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(400)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		if Duel.GetLocationCount(tp,LOCATION_SZONE)>=2 then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_EQUIP)
		e2:SetRange(LOCATION_SZONE)
		e2:SetCountLimit(1,13790634)
		e2:SetOperation(c13790675.rmop)
		c:RegisterEffect(e2)
		end
		--Equip limit
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_EQUIP_LIMIT)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetValue(1)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
	end
end
function c13790675.spfilter1(c,e,tp)
	return c:IsSetCard(0x1e71) and c:IsType(TYPE_MONSTER)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
		and Duel.IsExistingMatchingCard(c13790675.spfilter2,tp,LOCATION_DECK,0,1,c,e,tp,c:GetCode())
end
function c13790675.spfilter2(c,e,tp,code)
	return c:IsSetCard(0x1e71) and c:IsType(TYPE_MONSTER) and c:GetCode()~=code
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c13790675.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetHandler():GetEquipTarget()
	local fid=e:GetHandler():GetFieldID()
	local g=Group.FromCards(c,c:GetEquipTarget())
	if tc and Duel.Destroy(g,REASON_EFFECT)~=0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g1=Duel.SelectMatchingCard(tp,c13790675.spfilter1,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g1:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g2=Duel.SelectMatchingCard(tp,c13790675.spfilter2,tp,LOCATION_DECK,0,1,1,tc,e,tp,g1:GetFirst():GetCode())
			g1:Merge(g2)
			Duel.SpecialSummon(g1,0,tp,tp,false,false,POS_FACEUP)
			local e4=Effect.CreateEffect(c)
			e4:SetDescription(aux.Stringid(60549248,1))
			e4:SetCategory(CATEGORY_DESTROY)
			e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
			e4:SetCode(EVENT_PHASE+PHASE_END)
			e4:SetRange(LOCATION_MZONE)
			e4:SetCountLimit(1)
			e4:SetOperation(c13790675.desop)
			g1:GetFirst():RegisterEffect(e4)
			local e4=Effect.CreateEffect(c)
			e4:SetDescription(aux.Stringid(60549248,1))
			e4:SetCategory(CATEGORY_DESTROY)
			e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
			e4:SetCode(EVENT_PHASE+PHASE_END)
			e4:SetRange(LOCATION_MZONE)
			e4:SetCountLimit(1)
			e4:SetOperation(c13790675.desop)
			g1:GetNext():RegisterEffect(e4)
		end
	end
end
function c13790675.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end

