--Red Nova
function c13703002.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,13703002)
	e1:SetCondition(c13703002.spcon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c13703002.matcon)
	e2:SetTarget(c13703002.mattg)
	e2:SetOperation(c13703002.matop)
	c:RegisterEffect(e2)
end
function c13703002.cfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(8) and c:IsType(TYPE_SYNCHRO) and c:IsRace(RACE_DRAGON)
end
function c13703002.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c13703002.cfilter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,1,nil)
end

function c13703002.matcon(e,tp,eg,ep,ev,re,r,rp)
  return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO and e:GetHandler():GetReasonCard():GetMaterial():FilterCount(Card.IsType,nil,TYPE_TUNER)>=2
end
function c13703002.matfilter(c,e,tp)
  return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsRace(RACE_FIEND) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c13703002.mattg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c13703002.matfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
  Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c13703002.matop(e,tp,eg,ep,ev,re,r,rp)
  if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
  local g=Duel.SelectMatchingCard(tp,c13703002.matfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
  if g:GetCount()>0 then
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
  end
end
