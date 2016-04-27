#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC Receiver */
	case 3: // STATE 1 - chandy.pml:29 - [ch?message,received] (0:0:1 - 0)
		reached[1][1] = 1;
		if (q_len(now.ch) == 0) continue;

		XX=1;
		if (2 != qrecv(now.ch, 0, 0, 0)) continue;
		(trpt+1)->bup.oval = ((int)((P1 *)this)->received);
		;
		((P1 *)this)->received = qrecv(now.ch, XX-1, 1, 1);
#ifdef VAR_RANGES
		logval("Receiver:received", ((int)((P1 *)this)->received));
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.ch);
		sprintf(simtmp, "%d", 2); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((int)((P1 *)this)->received)); strcat(simvals, simtmp);		}
#endif
		;
		_m = 4; goto P999; /* 0 */
	case 4: // STATE 2 - chandy.pml:30 - [lastReceived = received] (0:0:1 - 0)
		IfNotBlocked
		reached[1][2] = 1;
		(trpt+1)->bup.oval = ((int)now.lastReceived);
		now.lastReceived = ((int)((P1 *)this)->received);
#ifdef VAR_RANGES
		logval("lastReceived", ((int)now.lastReceived));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 3 - chandy.pml:31 - [ch?marker,_] (0:0:1 - 0)
		reached[1][3] = 1;
		if (q_len(now.ch) == 0) continue;

		XX=1;
		if (1 != qrecv(now.ch, 0, 0, 0)) continue;
		(trpt+1)->bup.oval = qrecv(now.ch, XX-1, 1, 0);
		;
		qrecv(now.ch, XX-1, 1, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.ch);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((int)_)); strcat(simvals, simtmp);		}
#endif
		;
		_m = 4; goto P999; /* 0 */
	case 6: // STATE 4 - chandy.pml:32 - [messageAtMarker = lastReceived] (0:0:1 - 0)
		IfNotBlocked
		reached[1][4] = 1;
		(trpt+1)->bup.oval = ((int)now.messageAtMarker);
		now.messageAtMarker = ((int)now.lastReceived);
#ifdef VAR_RANGES
		logval("messageAtMarker", ((int)now.messageAtMarker));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 5 - chandy.pml:34 - [(!(recorded))] (0:0:0 - 0)
		IfNotBlocked
		reached[1][5] = 1;
		if (!( !(((int)now.recorded))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 6 - chandy.pml:35 - [messageAtRecord = lastReceived] (0:0:1 - 0)
		IfNotBlocked
		reached[1][6] = 1;
		(trpt+1)->bup.oval = ((int)now.messageAtRecord);
		now.messageAtRecord = ((int)now.lastReceived);
#ifdef VAR_RANGES
		logval("messageAtRecord", ((int)now.messageAtRecord));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 11 - chandy.pml:39 - [(!(recorded))] (0:0:0 - 0)
		IfNotBlocked
		reached[1][11] = 1;
		if (!( !(((int)now.recorded))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 12 - chandy.pml:40 - [messageAtRecord = lastReceived] (0:0:1 - 0)
		IfNotBlocked
		reached[1][12] = 1;
		(trpt+1)->bup.oval = ((int)now.messageAtRecord);
		now.messageAtRecord = ((int)now.lastReceived);
#ifdef VAR_RANGES
		logval("messageAtRecord", ((int)now.messageAtRecord));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 13 - chandy.pml:41 - [recorded = 1] (0:0:1 - 0)
		IfNotBlocked
		reached[1][13] = 1;
		(trpt+1)->bup.oval = ((int)now.recorded);
		now.recorded = 1;
#ifdef VAR_RANGES
		logval("recorded", ((int)now.recorded));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 17 - chandy.pml:44 - [assert((lastSent==messageAtMarker))] (0:0:0 - 0)
		IfNotBlocked
		reached[1][17] = 1;
		spin_assert((((int)now.lastSent)==((int)now.messageAtMarker)), "(lastSent==messageAtMarker)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 18 - chandy.pml:45 - [assert((messageAtRecord>=lastReceived))] (0:0:0 - 0)
		IfNotBlocked
		reached[1][18] = 1;
		spin_assert((((int)now.messageAtRecord)>=((int)now.lastReceived)), "(messageAtRecord>=lastReceived)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 19 - chandy.pml:46 - [-end-] (0:0:0 - 0)
		IfNotBlocked
		reached[1][19] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Sender */
	case 15: // STATE 1 - chandy.pml:18 - [((lastSent<6))] (0:0:0 - 0)
		IfNotBlocked
		reached[0][1] = 1;
		if (!((((int)now.lastSent)<6)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 2 - chandy.pml:19 - [lastSent = (lastSent+1)] (0:0:1 - 0)
		IfNotBlocked
		reached[0][2] = 1;
		(trpt+1)->bup.oval = ((int)now.lastSent);
		now.lastSent = (((int)now.lastSent)+1);
#ifdef VAR_RANGES
		logval("lastSent", ((int)now.lastSent));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 3 - chandy.pml:20 - [ch!message,lastSent] (0:0:0 - 0)
		IfNotBlocked
		reached[0][3] = 1;
		if (q_full(now.ch))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", now.ch);
		sprintf(simtmp, "%d", 2); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((int)now.lastSent)); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.ch, 0, 2, ((int)now.lastSent), 2);
		_m = 2; goto P999; /* 0 */
	case 18: // STATE 4 - chandy.pml:21 - [ch!marker,0] (0:0:0 - 0)
		IfNotBlocked
		reached[0][4] = 1;
		if (q_full(now.ch))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", now.ch);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.ch, 0, 1, 0, 2);
		_m = 2; goto P999; /* 0 */
	case 19: // STATE 9 - chandy.pml:24 - [-end-] (0:0:0 - 0)
		IfNotBlocked
		reached[0][9] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

