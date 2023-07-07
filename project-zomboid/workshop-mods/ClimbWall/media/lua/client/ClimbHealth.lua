
Climb = Climb or {}

function Climb.isHealthInhibitingClimb_BodyPart(bP)
    if Climb.Verbose then print ('Climb.isHealthInhibitingClimb part '..BodyPartType.getDisplayName(bP:getType())..' Fracture='..bP:getFractureTime()..' DW='..b2str(bP:isDeepWounded())..' Health='..bP:getHealth()..' Pain='..bP:getPain()) end
    return bP:getFractureTime() > 0.0F
        or bP:isDeepWounded()
        or bP:getHealth() < 50.0
        or bP:getStiffness() >= 50.0
end

function Climb.isHealthInhibitingClimb(isoPlayer)
    local bd = isoPlayer and isoPlayer:getBodyDamage()
    if not bd then return false end
    
    return Climb.isHealthInhibitingClimb_BodyPart(bd:getBodyPart(BodyPartType.Hand_L))
        or Climb.isHealthInhibitingClimb_BodyPart(bd:getBodyPart(BodyPartType.Hand_R))
        or Climb.isHealthInhibitingClimb_BodyPart(bd:getBodyPart(BodyPartType.ForeArm_L))
        or Climb.isHealthInhibitingClimb_BodyPart(bd:getBodyPart(BodyPartType.ForeArm_R))
        or Climb.isHealthInhibitingClimb_BodyPart(bd:getBodyPart(BodyPartType.UpperArm_L))
        or Climb.isHealthInhibitingClimb_BodyPart(bd:getBodyPart(BodyPartType.UpperArm_R))
        or Climb.isHealthInhibitingClimb_BodyPart(bd:getBodyPart(BodyPartType.Torso_Upper))
        or Climb.isHealthInhibitingClimb_BodyPart(bd:getBodyPart(BodyPartType.Torso_Lower))
end
