-module(pmap).

-export([pmap/1, add/1]).

add({X, Y}) ->
	X+Y.

pmap(L) ->
	S = self(),
	Pids = [do(S, F) || F <- L],
	[receive {Pid, Val} -> Val end || Pid <- Pids].

do(Parent, F) ->
	spawn(
		fun() -> 
		Parent ! {self(), F()}
		end
	).