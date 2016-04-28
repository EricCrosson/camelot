#define invalidprocessstate   (lastSent != messageAtMarker)

never {
  do
  :: recorded -> assert(!invalidprocessstate);
  od;
}
