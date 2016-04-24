#define wait   (P[1]@Wait)
#define cs     (P[1]@Critical)

never {    /* ! ([] (wait -> <> (cs))) */
T0_init:
	if
	:: (! ((cs)) && (wait)) -> goto accept_S4
	:: (1) -> goto T0_init
	fi;
accept_S4:
	if
	:: (! ((cs))) -> goto accept_S4
	fi;
}
