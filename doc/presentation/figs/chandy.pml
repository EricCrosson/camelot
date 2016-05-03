mtype { message, marker };
chan ch = [N] of 
        { mtype, byte };

active proctype Sender() {
  do
  :: lastSent < NUM_MESSAGES -> 
       lastSent++;
       ch ! message(lastSent)
  :: ch ! marker(0) ->
       break
  od }
active proctype Receiver() {
  byte received;
  do
  :: ch ? message(received) ->
        lastReceived = received
  :: ch ? marker(_) ->
        messageAtMarker = 
           lastReceived;
        if
        :: !recorded ->
             messageAtRecord = 
               lastReceived
        :: else
        fi;
        break
  :: !recorded ->
       messageAtRecord = 
          lastReceived;
       recorded = true
  od
}
