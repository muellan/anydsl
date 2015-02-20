#!/bin/sh -e

filename=$(basename "$1")
name=`echo $filename | cut -f1 -d'.'`

mkdir -p tmp
cd tmp

echo "# Compiling the infrastructure ..."
#clang ../impala/test/infrastructure/call_impala_main.c -O2 -c
clang ../tests/infrastructure/call_impala_main.c -O2 -c

echo "# Running impala on file $1 ..."
impala --emit-llvm -Othorin ../"$1"

echo "# Compiling program with infrastrcuture ..."
clang "$name".bc call_impala_main.o

echo "# Running the compiled program ..."
./a.out $2 $3
echo ""

#echo "-> return code was ($?)"

cd ..