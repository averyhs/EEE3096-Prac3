#!/bin/bash
echo "Script started"

# Directories
# ===========
TARGETDIR="$HOME/Documents/EEE3096S-Pracs-2020/Prac3"
BASEDIR="$HOME/Documents/HRRHAN002_TSHWAN006"
OUTDIR="$BASEDIR/raw_out"

# Clean output directory
# ======================
echo "Cleaning output directory..."
rm -f $OUTDIR/*

# Warm up cache
# =============
echo "Warming up cache..."

# compile C files
echo "Compiling C files..."
cd $TARGETDIR/C
make >/dev/null
make threaded >/dev/null

# Run python and C heterodyning 5 times
echo "Run 5 times to warm up..."
for i in {1..5} ; do
	cd $TARGETDIR/Python
	./PythonHeterodyning.py >/dev/null
	cd $TARGETDIR/C
	make run >/dev/null
	make run_threaded >/dev/null
done


# Run python code to establish a golden measure
# =============================================
echo "Establishing a golden measure..."
cd $TARGETDIR/Python

# Run a few times to get average time
for i in {1..10} ; do
	echo "-- Run "$i" of 10"
	./PythonHeterodyning.py >>$OUTDIR/gold_py.txt
	echo >>$OUTDIR/gold_py.txt # Newline
done

# Run C code with no threading or optimization
# ============================================
echo "Testing with no threading or optimization..."
cd $TARGETDIR/C

echo "Compiling..."
make

# Run a few times to get average time
for i in {1..10} ; do
	echo "-- Run "$i" of 10"
	make run >>$OUTDIR/original_c.txt
	echo >>$OUTDIR/original_c.txt # Newline
done

# Run C code using multithreading
# ===============================

# 2 threads
# prompt to edit code for 2 threads
# recompile threaded
# run and direct output to file

# 4 threads
# ...

# End
# ===
echo "Script ended"
