
JumpI = JumpI or {}

function JumpI.isHealthInhibitingJump_BodyPart(bP)
    if JumpI.Verbose then print ('JumpI.isHealthInhibitingJump part '..BodyPartType.getDisplayName(bP:getType())..' Fracture='..bP:getFractureTime()..' DW='..b2str(bP:isDeepWounded())..' Health='..bP:getHealth()..' Pain='..bP:getPain()) end
    return bP:getFractureTime() > 0.0F
        or bP:isDeepWounded()
        or bP:getHealth() < 50.0
        or bP:getStiffness() >= 50.0
end

function JumpI.isHealthInhibitingJump(isoPlayer)
    local bd = isoPlayer and isoPlayer:getBodyDamage()
    if not bd then return false end
    
    return JumpI.isHealthInhibitingJump_BodyPart(bd:getBodyPart(BodyPartType.Torso_Lower))
        or JumpI.isHealthInhibitingJump_BodyPart(bd:getBodyPart(BodyPartType.Groin))
        or JumpI.isHealthInhibitingJump_BodyPart(bd:getBodyPart(BodyPartType.UpperLeg_L))
        or JumpI.isHealthInhibitingJump_BodyPart(bd:getBodyPart(BodyPartType.UpperLeg_R))
        or JumpI.isHealthInhibitingJump_BodyPart(bd:getBodyPart(BodyPartType.LowerLeg_L))
        or JumpI.isHealthInhibitingJump_BodyPart(bd:getBodyPart(BodyPartType.LowerLeg_R))
        or JumpI.isHealthInhibitingJump_BodyPart(bd:getBodyPart(BodyPartType.Foot_L))
        or JumpI.isHealthInhibitingJump_BodyPart(bd:getBodyPart(BodyPartType.Foot_R))
end
