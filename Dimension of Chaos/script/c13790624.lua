--Dracoruler Vector Pendulum
function c13790624.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(0,LOCATION_SZONE)
	e1:SetTarget(c13790624.distg)
	c:RegisterEffect(e1)

end
function c13790624.distg(e,c)
	return c:IsType(TYPE_PENDULUM)
end
