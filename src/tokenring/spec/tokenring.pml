#ifndef N
#define N 10
#endif

#ifndef size
#define size 10
#endif

byte state[N];
bit _Permission[N];
bit _Executing[N];

byte in_cs;
byte token;  /* Defines who has the token by index*/

init {
  atomic {
    byte i = 0;
	token = 0;
    do
    :: i < N -> run P(i); i++;
    :: else  -> break;
    od;
  }
}


proctype P(byte id) {
NonCritical:
  _Permission[id] = true;
  printf("Token value: %d", token);

Wait:
  _Executing[id] = true;
  if
  :: id != token -> _Permission[id] = false; goto Wait;
  :: id == token
  fi; 
  if
  :: _Permission[id] == false -> goto NonCritical; /* This shouldn't happen (but could, theoretically)*/
  :: atomic { _Permission[id] == true -> in_cs++; }
  fi; 
Critical:
	 atomic { in_cs--; }
	printf("Process %d has entered CS!", id);
	_Permission[id] = false;
	_Executing[id] = false;
	if
    :: token < N -> token = ((token + 1) % N);
	:: atomic{token > (N-1) -> token = 0;  }
    fi;
	goto NonCritical; 
} 


proctype A(short index) {
    do
    :: atomic{ state[index] == state[N-1] -> if
                                             :: (state[index] + 1 == N) ->
                                                    state[index] = 0
                                             :: (state[index] + 1 < N) ->
                                                    state[index] = state[index] + 1
                                             fi
             };
    od
}

proctype B(short index) {
    do
    :: atomic{ (state[index] != state[index - 1]) -> state[index] = state[index - 1] };
    od
}
