BYTECC = ocamlc
NATIVECC = ocamlopt
CMO_DEPENDS = sets.cmo
PACKS = str

all: sets.cma

sets.cma: $(CMO_DEPENDS)
	ocamlfind $(BYTECC) -a -o $@ -linkpkg -package $(PACKS) -g $(CMO_DEPENDS)
