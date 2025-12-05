EXE=_build/default/mgoc.exe
#GOFILES=$(wildcard tests/*.go)  #Teste tous les fichiers .go dans le dossier tests
GOFILES := $(filter-out tests/test.go, $(wildcard tests/*.go)) 
#Teste tous les fichiers .go dans le dossier tests sauf test.go

all: $(EXE)

$(EXE): *.ml*
	dune build @all

test: $(EXE)
	@for f in $(GOFILES); do \
		echo "Testing $$f"; \
		./$(EXE) --type-only $$f || exit 1; \
	done

.PHONY: clean
clean:
	dune clean
	rm -f *~ tests/*~
