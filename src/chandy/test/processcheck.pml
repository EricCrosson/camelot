#define invalidprocessstate   (lastSent != messageAtMarker)

never {
  do
  :: assert(invalidprocessstate);
  od;
}