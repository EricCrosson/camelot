#define invalidchannelstate   (messageAtRecord < lastReceived)

never {
  do
  :: assert(! invalidchannelstate);
  od;
}
