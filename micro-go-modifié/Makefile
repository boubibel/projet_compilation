EXE=_build/default/mgoc.exe

all: $(EXE)

$(EXE): *.ml*
	dune build @all

test: $(EXE) tests/test.go
	-./$(EXE) --type-only tests/test.go


.PHONY: clean
clean:
	dune clean
	rm -f *~ tests/*~
