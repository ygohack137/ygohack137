--Diceclops
function c13790835.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISCARD)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c13790835.target)
	e1:SetOperation(c13790835.activate)
	c:RegisterEffect(e1)
end
function c13790835.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then
		local h1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
		local h2=Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)
		return (h1>0 and h2>0)
	end
end
function c13790835.activate(e,tp,eg,ep,ev,re,r,rp)
	local h1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local h2=Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)
	local dc=Duel.TossDice(tp,1)
	if dc==1 and h2>=1 then 
		Duel.ConfirmCards(tp,hg)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
		local sg=hg:Select(tp,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
		Duel.ShuffleHand(1-tp)
	end
	if dc==2 or dc==3 or dc==4 or dc==5 and h1>=1 then
		Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
	end
	if dc==6 and h1>=1 then 
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
	end
end
