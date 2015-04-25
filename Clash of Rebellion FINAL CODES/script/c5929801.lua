--Raidraptor - Fuzzy Lanius
function c5929801.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,23790562)
	e1:SetCost(c5929801.cost)
	e1:SetTarget(c5929801.thtg2)
	e1:SetOperation(c5929801.tgop2)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,5929801)
	e2:SetCost(c5929801.cost)
	e2:SetCondition(c5929801.sscon)
	e2:SetTarget(c5929801.sstg)
	e2:SetOperation(c5929801.ssop)
	c:RegisterEffect(e2)
	if not c5929801.global_check then
		c5929801.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c5929801.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c5929801.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c5929801.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if not tc:IsSetCard(0xba) then
			c5929801[tc:GetSummonPlayer()]=false
		end
		tc=eg:GetNext()
	end
end
function c5929801.clear(e,tp,eg,ep,ev,re,r,rp)
	c5929801[0]=true
	c5929801[1]=true
end
function c5929801.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return c5929801[tp] end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c5929801.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c5929801.splimit(e,c)
	return not c:IsSetCard(0xba)
end

function c5929801.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0xba) and c:GetCode()~=5929801
end
function c5929801.sscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c5929801.filter1,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c5929801.sstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c5929801.ssop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c5929801.filter1,tp,LOCATION_ONFIELD,0,1,nil) then return end
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end

function c5929801.thfilter2(c)
	return c:GetCode()==5929801 and c:IsAbleToHand()
end
function c5929801.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c5929801.thfilter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c5929801.tgop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c5929801.thfilter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
