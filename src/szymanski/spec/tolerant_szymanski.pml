/** Eric Crosson 
 * based on https://github.com/stupaq/promela-szymanski by Mateusz Machalica.
 *
 * This specification has been modified to more closely resemble the ACM
 * publication it is modeling, and has been modified to fit the scope of this
 * investigation.
 */

/* LTL metamacros are prepared for 2 <= N <= 4, if you wish to use different
 * value of N, you must modify them acordingly in lib/ltls.pml. */
#ifndef N
/* 01 */  #define N 4                           /* liczba procesow */
#endif
#ifndef EPILOGUE
#define EPILOGUE 312
#endif
#ifndef LTL
#define LTL 999
#endif

byte in_cs;
/* 02 */        bool intent[N], door_in[N], door_out[N];
/* 03 */        #define i _pid

#include "../lib/commons.pml"

/* 04 */        active [N] proctype P()
/* 05 */        {
                    byte k;
                    count_init();
                    goto start;

                restart:
                    /* \forall_k (!door_in[k] || door_out[k]) \iff \neg \exists_k (door_in[k] && !door_out[k]) \iff #(door_in && !door_out) = 0 */
                    (count(0,1,0) + count(1,1,0) == 0);

/* 06 */        start:

                    /* SEKCJA LOKALNA */
                    local_section();

                    /* PROLOG */
                    begin_state_change
/* 07 */            intent[i] = true;
                    end_state_change
                started_protocol:
                    skip;

                    /* \forall_k !(intent[k] && door_in[k]) \iff \neq \exists_k (intent[k] && door_in[k]) \iff #(intent && door_in) = 0 */
                    (count(1,1,0) + count(1,1,1) == 0);

                    begin_state_change
/* 08 */            door_in[i] = true;
                    end_state_change

                anteroom_check:
                    if
                      /* \exists_k (intent[k] && !door_in[k]) \iff #(intent && !door_in) > 0 */
                      :: (count(1,0,0) + count(1,0,1) > 0) ->
/* 09 */                {
                            begin_state_change
/* 10 */                    intent[i] = false;
                            end_state_change

                        in_anteroom:
                            (
                            /* \exists_k door_out[k] \iff #(door_out) > 0 */
                            (count(0,0,1) + count(0,1,1) + count(1,0,1) + count(1,1,1) > 0)
                            ||
                            /* \forall_k (!intent[k] || door_in[k]) \iff \neg \exists_k (intent[k] && !door_in[k])
                            * \iff #(intent && !door_in) = 0 */
                            (count(1,0,0) + count(1,0,1) == 0)
                            );

                            begin_state_change
/* 11 */                    intent[i] = true;
                            end_state_change

                            if
                              /* \neg \exists_k door_out[k] \iff #(door_out) == 0 */
                              :: (count(0,0,1) + count(0,1,1) + count(1,0,1) + count(1,1,1) == 0)
                                    -> goto anteroom_check
                              :: else
                            fi;
/* 12 */                }
                      :: else
                    fi;

                    begin_state_change
/* 13 */            door_out[i] = true;
                    end_state_change

                    /* \forall_k (k > i \implies (!door_in || door_out)) */
                    wait_forall(k, i + 1, N, (!door_in[k] || door_out[k]));

                    /* \forall_k (k < i \implies !door_in) */
                    wait_forall(k, 0, i, (!door_in[k]));

                    /* SEKCJA KRYTYCZNA */

                    in_cs++;
                critical_section:
                    in_cs--;
                    skip;

                    /* EPILOG */

#if EPILOGUE == 321
                    begin_state_change
/* 14 */            door_out[i] = false;
                    interrupt_change
/* 15 */            door_in[i] = false;
                    interrupt_change
/* 16 */            intent[i] = false;
                    end_state_change
#elif EPILOGUE == 312
                    begin_state_change
                    door_out[i] = false;
                    interrupt_change
                    intent[i] = false;
                    interrupt_change
                    door_in[i] = false;
                    end_state_change
#else
#error "epilogue protocol not defined"
#endif

/* 17 */            goto start
/* 18 */        }

#include "../lib/ltls.pml"
