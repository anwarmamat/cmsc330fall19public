OCAML_VERSION=$(ocaml --version | rev | cut -d' ' -f 1 | rev)
if [ $OCAML_VERSION = '4.07.1' ] ; then
    export OCAMLPATH=dep4.07.1
elif [ $OCAML_VERSION = '4.07.0' ] ; then
    export OCAMLPATH=dep
else
    echo 'You must have OCaml version 4.07.0 or 4.07.1 for this project.'
    echo $OCAML_VERSION ' is not valid.'
fi
