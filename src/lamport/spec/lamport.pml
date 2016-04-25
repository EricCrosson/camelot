#ifndef  N
#define  N  3
#endif

bit _IsMyTurn[N];
bit _RequestCS[N];
bit _Priority[N];  /* Lower index -> higher priority */
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

/* Returns the next process id with permission to enter
 * critical section. */
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

/* Defines one of the N processes contesting for mutual exclusion. */
proctype P(byte id) {
  byte i, k;
  bit temp;
NonCritical:
  _IsMyTurn[id] = true;
Wait:
  _RequestCS[id] = true;
  Low(k, i);
  if
  :: k != id -> i = k;
     do
     :: (i % N != id-1) ->
        if
        :: _RequestCS[i%N] == true -> _IsMyTurn[id] = false; goto Wait;
        :: _RequestCS[i%N] == false -> i++;
        fi;
     :: (i % N == id-1); break;
     od;
  :: k == id;
  fi;
  if
  :: _IsMyTurn[id] == false -> goto NonCritical;
  :: atomic { _IsMyTurn[id] == true -> i = id + 1; }
  fi;
  do
  :: atomic { (i % N != k-1) && _IsMyTurn[i%N] == false -> i++; }
  :: (i % N != k-1) && _IsMyTurn[i%N] == true; goto NonCritical;
  :: atomic { (i % N == k-1) -> in_cs++; } break;
  od;

/* Resets the process variables after exiting CS */ 
Critical:
  atomic { temp = 1 - _Priority[id]; in_cs--; }
  _Priority[id] = temp;
  _IsMyTurn[id] = false;
  _RequestCS[id] = false;
  goto NonCritical;
}
