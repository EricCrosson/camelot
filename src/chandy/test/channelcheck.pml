#define invalidchannelstate   (messageAtRecord < lastReceived)

never {
  do
  :: recorded -> assert(!invalidchannelstate);
  od;
}
