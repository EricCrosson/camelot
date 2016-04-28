start:
    /* 1. SEKCJA LOKALNA */

    local_section();

    /* 2. PROLOG */
    intent[i] = true;

started_protocol:
    skip;

    /* 3. Others are trying to
     * enter waiting room? */
    (count(1,1,0) +
      count(1,1,1) == 0);

    /* 4. Enter waiting room */
    door_in[i] = true;




anteroom_check:
    if
      :: (count(1,0,0) +
            count(1,0,1) > 0) ->
        {
            /* State 2  */
            intent[i] = false;

        in_anteroom:
            ((count(0,0,1) +
              count(0,1,1) +
              count(1,0,1) +
              count(1,1,1) > 0)
            );

            /* State 3 */
            intent[i] = true;
        }
      :: else
    fi;


    /* . Proceed into CS when
     * it is your turn */
    door_out[i] = true;

    wait_forall(k, i + 1, N,
      (!door_in[k] || door_out[k]));

    wait_forall(k, 0, i,
      (!door_in[k]));

 critical_section:
    /* . SEKCJA KRYTYCZNA */

    critical_section();

    /* . EPILOG */
    door_out[i] = false;
    door_in[i] = false;
    intent[i] = false;

