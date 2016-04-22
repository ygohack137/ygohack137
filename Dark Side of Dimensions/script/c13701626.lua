--Houkai Beast Dark Ganex
function c13701626.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetValue(1)
	e2:SetCondition(c13701626.spcon)
	e2:SetOperation(c13701626.spop)
	c:RegisterEffect(e2)
	--spsummon success
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c13701626.trigop)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetDescription(aux.Stringid(13701626,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_EVENT_PLAYER)
	e4:SetCode(13701626)
	e4:SetOperation(c13701626.operation)
	c:RegisterEffect(e4)
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(13521194,0))
	e6:SetCategory(CATEGORY_DAMAGE)
	e6:SetCode(EVENT_BATTLE_DESTROYING)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetTarget(c13701626.damtarget)
	e6:SetOperation(c13701626.damoperation)
	c:RegisterEffect(e6)
end
function c13701626.spfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xe3)
end
function c13701626.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c13701626.spfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c13701626.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c13701626.spfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g1,REASON_COST)
end

function c13701626.trigop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1 then
		Duel.RaiseSingleEvent(e:GetHandler(),13701626,e,r,rp,tp,0)
	end
end
function c13701626.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(1000)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
end


function c13701626.filter(c)
	return c:IsCode(13701614) and c:IsAbleToHand()
end
function c13701626.spfilter2(c,e,tp)
	return c:IsCode(13701611) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c13701626.damtarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c13701626.spfilter2(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c13701626.filter,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingTarget(c13701626.spfilter2,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	local ct=math.min(2,Duel.GetLocationCount(tp,LOCATION_MZONE))
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c13701626.spfilter2,tp,LOCATION_GRAVE,0,1,ct,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c13701626.damoperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local g=tg:Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c13701626.filter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
