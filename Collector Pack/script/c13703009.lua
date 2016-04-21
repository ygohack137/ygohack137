--Holding-Hand Genie
function c13703009.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c13703009.atlimit)
	c:RegisterEffect(e1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_DEFENCE)
	e1:SetValue(c13703009.val)
	c:RegisterEffect(e1)
end
function c13703009.atlimit(e,c)
	return c~=e:GetHandler()
end
function c13703009.defilter(c)
	return c:IsFaceup() and c:IsDefencePos()
end
function c13703009.val(e,c)
		local g=Duel.GetMatchingGroup(c13703009.defilter,tp,LOCATION_MZONE,0,e:GetHandler())
		local def=g:GetSum(Card.GetBaseDefence)
		return def
end
