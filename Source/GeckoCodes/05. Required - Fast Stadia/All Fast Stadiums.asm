#To be inserted at 800081f0
# Used at [$Required: Fast Stadia] at R4QP01.ini
  lis r0, 0x909B        
  ori r0, r0, 0x6530    # Set r0 to 909B6530 - assumption here is bounce gets set last
  cmpw r0, r31          # Compare with r31
  bne- FINALLY          # Go to end of function

########### PUSH r14-r31 INTO THE STACK
  stwu sp, -0x0050 (sp) # make space for 18 registers
  stmw r14, 0x8 (sp)    # push r14-r31 onto the stack pointer

  lis r14, 0x80c5
  ori r14, r14, 0xf340  
  lbz r14, 0 (r14)      # load in flag for if online
  cmpwi r14, 0          # 0 = offline, 1 = online
  lis r14, 0x80c5
  beq OFFLINE

ONLINE:
  ori r14, r14, 0xf29b
  b CHECK_STADIUM_CHEAT

OFFLINE:
  ori r14, r14, 0xf303

CHECK_STADIUM_CHEAT:
  lbz r15, 0 (r14)
  cmpwi cr2, r15, 2
  li r16, 0
  bne cr2, POP_STACK
  li r16, 1
  li r15, 0
  stb r15, 0 (r14)

POP_STACK:
  cmpwi cr2, r16, 1
  lmw r14, 0x8 (sp)     # pop r14-r31 off the stack pointer
  addi sp, sp, 0x0050   # release the space
  beq cr2, FINALLY

SET_FIELD_PARAMS:
  # set speed
  lis r0, 0x3F26       
  ori r0, r0, 0x6666    # Load 3F266666 into r0 - this value equates to .65 in float
  stw r0, 0x3c (r31)    # and store it into 909B656C

  # set slipperyness
  lis r0, 0x0           # Wipe r0
  stw r0, 0x2c (r31)    # Store 0 into 909B655C

  # set friction
  lis r0, 0x3E4C       
  ori r0, r0, 0xCCCD    # Load 3E4CCCCD into r0 - this value equates to .2 in float
  stw r0, 0x1c (r31)    # and store it into 909B654C

  # set bounce
  lis r0, 0x3F19       
  ori r0, r0, 0x999A    # Load 3f19999a into r0 - this value equates to .6 in float
  stw r0, 0xc (r31)     # Store it into 909B6530

FINALLY:                # This function runs a whole lot more than just loading in the stadium terrain
  lwz r31, 0xc (sp)     # Hex to float converter here: https://gregstoll.com/~gregstoll/floattohex/