--Amorphous Persona
function c13790831.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1d1))
	e2:SetValue(300)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENCE)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(17626381,0))
	e4:SetCategory(CATEGORY_DRAW)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EVENT_RELEASE)
	e4:SetCountLimit(2)
	e4:SetCondition(c13790831.drcon)
	e4:SetTarget(c13790831.drtg)
	e4:SetOperation(c13790831.drop)
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(34834619,0))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCost(c13790831.spcost)
	e5:SetTarget(c13790831.sptg)
	e5:SetOperation(c13790831.spop)
	c:RegisterEffect(e5)
end
function c13790831.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp
	and c:IsSetCard(0x1d1)
end
function c13790831.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c13790831.cfilter,1,nil,tp)
end
function c13790831.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c13790831.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end


function c13790831.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c13790831.mtfilter(c,e)
	return c:GetLevel()>0 and c:IsType(TYPE_PENDULUM) and not c:IsImmuneToEffect(e)
end
function c13790831.spfilter(c,e,tp,m)
	return c:IsCode(13790827) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
		and m:CheckWithSumEqual(Card.GetRitualLevel,8,1,99,c)
end
function c13790831.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		local mg=Duel.GetMatchingGroup(c13790831.mtfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,e:GetHandler(),e)
		return Duel.IsExistingMatchingCard(c13790831.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c13790831.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg=Duel.GetMatchingGroup(c13790831.mtfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,e)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c13790831.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,mg)
	local tc=g:GetFirst()
	if tc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,8,1,99,tc)
		tc:SetMaterial(mat)
		Duel.ReleaseRitualMaterial(mat)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
