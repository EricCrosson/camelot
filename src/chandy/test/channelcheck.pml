#define invalidchannelstate   (messageAtRecord < lastReceived)

never {
  T0_init:
    if 
      :: invalidchannelstate -> goto accept
      :: else -> goto T0_init
    fi;
  accept:
}