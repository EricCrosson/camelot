#define invalidprocessstate   (lastSent != messageAtMarker)

never {
T0_init:
    if 
      :: invalidprocessstate -> goto accept
      :: else -> goto T0_init
    fi;
  accept:
}
