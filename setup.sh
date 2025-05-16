#!/bin/bash

set -e

BASE_DIR="./grep_awk_sed_practice"

if [ -d "$BASE_DIR" ]; then
        echo "Running this script will re-create the files, any changes will be lost"
        echo "Would you like to continue? (y for yes)"
        read CONT
        if [ "$CONT" != "y" ]; then
                exit 1
        fi
fi

rm -rf "$BASE_DIR" || true
mkdir -p "$BASE_DIR"

# --- Create single root CSV for AWK practice ---
CSV_FILE="$BASE_DIR/data.csv"
echo "name course grade " > "$CSV_FILE"
echo "Alice Operating-Systems Linux Advanced-Linux 89 " >> "$CSV_FILE"
echo "Bob C 58 " >> "$CSV_FILE"
echo "" >> $CSV_FILE
echo "Charlie Linux 90 " >> "$CSV_FILE"
echo "Diana CSharp 74 " >> "$CSV_FILE"
echo "Eve C 45 " >> "$CSV_FILE"
echo "Frank Linux 66 " >> "$CSV_FILE"
echo "Grace CSharp 85 " >> "$CSV_FILE"
echo "Heidi C 63 " >> "$CSV_FILE"
echo "Ivan Linux 91 " >> "$CSV_FILE"
echo "Judy CSharp 79 " >> "$CSV_FILE"

# --- Create subdirectories ---
for i in {1..10}; do
  mkdir -p "$BASE_DIR/dir_$i"
done

# --- Create 99 mixed files ---
for i in {1..99}; do
  DIR_NUM=$(( (RANDOM % 10) + 1 ))
  DIR_PATH="$BASE_DIR/dir_$DIR_NUM"

  FILE_TYPE=$(( RANDOM % 3 ))
  case $FILE_TYPE in
    0)
      FILE="$DIR_PATH/file_$i.log"
      for j in {1..5}; do
        case $(( RANDOM % 5 )) in
          0) echo "ERROR: 01/01/2024 database connection failed at $j " >> "$FILE" ;;
          1) echo "ERROR: user not found at $j " >> "$FILE" && echo "ERROR: user not found at $j " >> "$FILE" ;;
          2) echo "INFO: 01/01/2024 operation completed successfully $j " >> "$FILE" ;;
          3) echo "DEBUG: 01/01/2024 value set to 42 at line $j " >> "$FILE" ;;
          4) echo "ERROR: $(date +%m/%d/%y) database reports error at $j " >> "$FILE" ;;
        esac
      done
      ;;
    1)
      FILE="$DIR_PATH/file_$i.txt"
      for j in {1..5}; do
        echo "This is a general text line number $j from file $i " >> "$FILE"
      done
      ;;
    2)
      FILE="$DIR_PATH/script_$i.sh"
      echo "#!/bin/bash" > "$FILE"
      echo "echo 'Running script $i' " >> "$FILE"
      # chmod +x "$FILE"
      ;;
  esac
done

# --- Add a couple large files for 'find > 1MB' ---
dd if=/dev/urandom of="$BASE_DIR/dir_1/bigfile1.dat" bs=1M count=2 &> /dev/null
dd if=/dev/urandom of="$BASE_DIR/dir_2/bigfile2.dat" bs=1M count=2 &> /dev/null

# --- Add empty dirs for 'find empty dirs' ---
mkdir -p "$BASE_DIR/dir_empty_1"
mkdir -p "$BASE_DIR/dir_5/dir_empty_2"

# --- Set some files to 777 ---
chmod -R 777 "$BASE_DIR/dir_1/"

# --- Touch a file for time-based find ---
touch "$BASE_DIR/dir_3/touched_recently.txt"

echo "Done. Practice files ready under $BASE_DIR"
