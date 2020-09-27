#!/bin/bash
echo "Script started"
echo

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
echo
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
echo
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
echo
echo "Testing with multithreading..."
cd $TARGETDIR/C

for t in {2,4,8,16,32} ; do
	echo
	echo "Using "$t" threads..."

	# Replace default header with header that has required thread count
	rm $TARGETDIR/C/src/CHeterodyning_threaded.h
	cp $TARGETDIR/C/src/CHeterodyning_threaded_$t.h $TARGETDIR/C/src/CHeterodyning_threaded.h

	# Compile
	echo "Compiling..."
	make threaded

	# Run a few times to get average time
	for i in {1..10} ; do
	        echo "-- Run "$i" of 10"
	        make run_threaded >>$OUTDIR/thread_$t.txt
	        echo >>$OUTDIR/thread_$t.txt # Newline
	done
done

# End
# ===
echo
echo "Script ended"
