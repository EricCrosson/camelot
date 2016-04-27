start:
    /* 1. SEKCJA LOKALNA */

    local_section();

    /* 2. PROLOG */
    begin_state_change
    intent[i] = true;
    end_state_change

started_protocol:
    skip;

    /* 3. Others are trying to
     * enter waiting room? */
    (count(1,1,0) +
      count(1,1,1) == 0);

    /* 4. Enter waiting room */
    begin_state_change
    door_in[i] = true;
    end_state_change

TODO: keep numbering numbnuts


anteroom_check:
    if
      :: (count(1,0,0) +
            count(1,0,1) > 0) ->
        {
            begin_state_change
            intent[i] = false;
            end_state_change

        in_anteroom:
            ((count(0,0,1) +
              count(0,1,1) +
              count(1,0,1) +
              count(1,1,1) > 0)
            );

            begin_state_change
            intent[i] = true;
            end_state_change
        }
      :: else
    fi;



    /* . Proceed into CS when
     * it is your turn */
    begin_state_change
    door_out[i] = true;
    end_state_change

    wait_forall(k, i + 1, N,
      (!door_in[k] || door_out[k]));

    wait_forall(k, 0, i,
      (!door_in[k]));

    /* . SEKCJA KRYTYCZNA */

 critical_section:
    /* CS is thread-specific
     * and thus omitted here */

    /* EPILOG */
    door_out[i] = false;
    door_in[i] = false;
    intent[i] = false;

