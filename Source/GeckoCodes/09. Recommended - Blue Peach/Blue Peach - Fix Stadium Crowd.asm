#To be inserted at 801A34CC
# Used at [$Recommended: Blue Peach vs Red or Orange Opponents] at R4QP01.ini
loc_0x0:
  lwz r5, 0(r30)
  cmpwi r5, 0x5
  bne+ loc_0x10
  li r3, 0x0

loc_0x10:
  cmpwi r3, 0x0

