#!/bin/bash
echo "Script started"

# Directories
# ===========
TARGETDIR="$HOME/Documents/EEE3096S-Pracs-2020/Prac3"
BASEDIR="$HOME/Documents/HRRHAN002_TSHWAN006"
OUTDIR="$BASEDIR/raw_out"

# Warm up cache
# =============
echo "Warming up cache"

# compile C files
echo "Compiling C files"
cd $TARGETDIR/C
make
make threaded

# Run python and C heterodyning 5 times
echo "Run 5 times to warm up"
for i in {1..5} ; do
	cd $TARGETDIR/Python
	./PythonHeterodyning.py
	cd $TARGETDIR/C
	make run
	make run_threaded
done


# Run python code to establish a golden measure
# =============================================

# End
# ===
echo "Script ended"