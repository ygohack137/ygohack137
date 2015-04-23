---Red-Eyes Black Flare Dragon
function c13790500.initial_effect(c)
	aux.EnableDualAttribute(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13790500,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,13790500)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c13790500.destg)
	e1:SetOperation(c13790500.desop)
	c:RegisterEffect(e1)
end
function c13790500.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetBattledGroupCount()>0 end
end
function c13790500.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.Damage(1-tp,e:GetHandler():GetBaseAttack(),REASON_EFFECT)
	end
end
