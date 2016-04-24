#define someoneincs (in_cs == 1)

never {    /* ! ([] <> someoneincs) */
T0_init:
	if
	:: (! ((someoneincs))) -> goto accept_S4
	:: (1) -> goto T0_init
	fi;
accept_S4:
	if
	:: (! ((someoneincs))) -> goto accept_S4
	fi;
}
