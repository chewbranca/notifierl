REBAR?=./rebar


all: build


build: deps compile


clean:
	$(REBAR) clean
	rm -rf logs
	rm -rf .eunit
	rm -f test/*.beam


distclean: clean
	git clean -fxd


compile:
	./rebar compile


deps:
	./rebar get-deps update-deps


run:
	erl -pa deps/*/ebin ebin -s notifierl  -name notifierl-dev


eunit:
	$(REBAR) eunit skip_deps=true


check: build eunit


%.beam: %.erl
	erlc -o test/ $<


.PHONY: all clean distclean depends build eunit check
