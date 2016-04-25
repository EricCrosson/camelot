#ifndef N
#define N 10
#endif

#ifndef size
#define size 10
#endif

byte state[size];
byte in_cs;

init {
    atomic { state[0] = 1;
             state[1] = 2;
             state[2] = 3;
             state[4] = 4;
             state[5] = 5;
             state[6] = 3;
             state[7] = 4;
             state[8] = 6;
             state[9] = 9;
    };
    atomic { run A(0);
             run B(1);
             run B(2);
             run B(3);
             run B(4);
             run B(5);
             run B(6);
             run B(7);
             run B(8);
             run B(9);
    };
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
