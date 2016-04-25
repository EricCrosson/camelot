#define cs   (P[1]@critical_section)

never {    /* ! ([] ((! cs) -> <> cs)) */
T0_init:
	if
	:: (! ((cs))) -> goto accept_S4
	:: (1) -> goto T0_init
	fi;
accept_S4:
	if
	:: (! ((cs))) -> goto accept_S4
	fi;
}
