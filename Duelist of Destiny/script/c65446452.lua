--Aquarium Set
function c65446452.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--ad up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(c65446452.val)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetValue(c65446452.val2)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_DEFENCE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetValue(c65446452.val)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_UPDATE_DEFENCE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetValue(c65446452.val2)
	c:RegisterEffect(e5)
	
    local e6=Effect.CreateEffect(c)
    e6:SetDescription(aux.Stringid(56638325,1))
    e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e6:SetCode(EVENT_TO_GRAVE)
    e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e6:SetCondition(c65446452.spcon)
    e6:SetTarget(c65446452.sptg)
    e6:SetOperation(c65446452.spop)
    c:RegisterEffect(e6)
end
function c65446452.val(e,c)
	if c:IsFaceup() and c:IsSetCard(0x1373) then return 300
	else
	return 0
	end 
end
function c65446452.val2(e,c)
	if c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER) then return 300
	else
	return 0
	end 
end

function c65446452.spcon(e,tp,eg,ep,ev,re,r,rp)
        return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c65446452.spfilter(c,e,tp)
        return c:IsRace(RACE_AQUA) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c65446452.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
                and Duel.IsExistingMatchingCard(c65446452.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
        Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c65446452.spop(e,tp,eg,ep,ev,re,r,rp)
        if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
        local g=Duel.SelectMatchingCard(tp,c65446452.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
        if g:GetCount()>0 then
                Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
                local e1=Effect.CreateEffect(e:GetHandler())
                e1:SetType(EFFECT_TYPE_FIELD)
                e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
                e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
                e1:SetTargetRange(1,0)
                e1:SetTarget(c65446452.splimit)
                e1:SetReset(RESET_PHASE+PHASE_END)
                Duel.RegisterEffect(e1,tp)
        end
end
function c65446452.splimit(e,c)
        return c:GetRace()~=RACE_AQUA
end
