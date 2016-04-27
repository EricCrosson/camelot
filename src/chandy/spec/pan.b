	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC Receiver */

	case 3: // STATE 1
		;
		XX = 1;
		unrecv(now.ch, XX-1, 0, 2, 1);
		unrecv(now.ch, XX-1, 1, ((int)((P1 *)this)->received), 0);
		((P1 *)this)->received = trpt->bup.oval;
		;
		;
		goto R999;

	case 4: // STATE 2
		;
		now.lastReceived = trpt->bup.oval;
		;
		goto R999;

	case 5: // STATE 3
		;
		XX = 1;
		unrecv(now.ch, XX-1, 0, 1, 1);
		unrecv(now.ch, XX-1, 1, trpt->bup.oval, 0);
		;
		;
		goto R999;

	case 6: // STATE 4
		;
		now.messageAtMarker = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 8: // STATE 6
		;
		now.messageAtRecord = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 10: // STATE 12
		;
		now.messageAtRecord = trpt->bup.oval;
		;
		goto R999;

	case 11: // STATE 13
		;
		now.recorded = trpt->bup.oval;
		;
		goto R999;
;
		;
		;
		;
		
	case 14: // STATE 19
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Sender */
;
		;
		
	case 16: // STATE 2
		;
		now.lastSent = trpt->bup.oval;
		;
		goto R999;

	case 17: // STATE 3
		;
		_m = unsend(now.ch);
		;
		goto R999;

	case 18: // STATE 4
		;
		_m = unsend(now.ch);
		;
		goto R999;

	case 19: // STATE 9
		;
		p_restor(II);
		;
		;
		goto R999;
	}

