/** @author Mateusz Machalica */

byte states_count[8];
/* With this macro it is easy to express conditions quantified existentially by
* comaring sum of counts with zero and conditions quantified universally by
* comparing sum to N or negating the condition. */
#define count(intent, door_in, door_out)     states_count[4*intent + 2*door_in + 1*door_out]
#define count_this                           count(intent[_pid], door_in[_pid], door_out[_pid])
#define begin_change                         skip; d_step { { count_this--; };
#define interrupt_change                     end_change begin_change
/* Door_In model failures in such a way, that entire local state (local
 * variables & instruction pointer) are lost, therefore to cover all possible
 * scenarios door_in can nondeterministically fail after each modification of
 * the global state only. */
#define end_change                  { count_this++; } } possibly_fail();

inline count_init() {
    /* Each starting process adds itself to the counter associated with initial
    * state and waits for all processes to join in. */
    atomic {
        count(0,0,0)++;
        (count(0,0,0) == N);
    }
}

inline local_section() {
#ifndef PROCESSES_NEVER_BLOCK
    atomic {
        if
          :: skip
          :: true ->
            end:
                false
        fi;
    }
#else
#warning "processes cannot block in local section and  will always request critical section reentry"
    skip;
#endif
}

inline possibly_fail() {
#ifdef RESTARTING_PROCESSES
#warning "processes may nondeterministically restart at any moment"
    atomic {
        if
          :: skip
          :: true ->
            {
                count_this--;
                intent[i] = false;
                door_in[i] = false;
                door_out[i] = false;
                count_this++;
                goto restart
            }
        fi;
    }
#else
    skip;
#endif
}

inline wait_forall(k, s, e, p) {
    atomic {
        k = (s);
        do
          :: k >= (e) -> break
          :: (k < (e)) && (p) -> k++
          :: else -> { (p); k++ }
        od;
    }
}
