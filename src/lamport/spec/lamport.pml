#ifndef  N
#define  N  3
#endif

bit _Permission[N];
bit _Executing[N];
bit _Priority[N];  /*Lower priority goes first*/
byte in_cs;

init {
  atomic {
    byte i = 0;

    do
    :: i < N -> run P(i); i++;
    :: else  -> break;
    od;
  }
}

inline Low(k, i) {
  d_step {
  i = 0;
  do
  :: i == 0 && _Priority[i] == _Priority[N-1] -> k = 0; break;
  :: i == 0 && _Priority[i] != _Priority[N-1] -> i++;
  :: i > 0 && _Priority[i] != _Priority[i-1] -> k = i; break;
  :: i > 0 && _Priority[i] == _Priority[i-1] -> i++;
  od;
  }
}

proctype P(byte id) {
  byte i, k;
  bit temp;
NonCritical:
  _Permission[id] = true;
Wait:
  _Executing[id] = true;
  Low(k, i);
  if
  :: k != id -> i = k;
     do
     :: (i % N != id-1) ->
        if
        :: _Executing[i%N] == true -> _Permission[id] = false; goto Wait;
        :: _Executing[i%N] == false -> i++;
        fi;
     :: (i % N == id-1); break;
     od;
  :: k == id;
  fi;
  if
  :: _Permission[id] == false -> goto NonCritical;
  :: atomic { _Permission[id] == true -> i = id + 1; }
  fi;
  do
  :: atomic { (i % N != k-1) && _Permission[i%N] == false -> i++; }
  :: (i % N != k-1) && _Permission[i%N] == true; goto NonCritical;
  :: atomic { (i % N == k-1) -> in_cs++; } break;
  od;
Critical:
  atomic { temp = 1 - _Priority[id]; in_cs--; }
  _Priority[id] = temp;
  _Permission[id] = false;
  _Executing[id] = false;
  goto NonCritical;
}
