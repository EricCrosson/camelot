#define collision   (in_cs > 1)

never {
  do
  :: assert(! collision);
  od;
}
