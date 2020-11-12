#!/bin/bash
set -eu -o pipefail

# Ensure the working directory is set properly
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

# Check MD5 of inputs (this doesn't work inline for some reason)
bash -c 'cd inputs; diff MD5SUM <(find . -type f -print0 | xargs -0 openssl md5 | grep -v "MD5SUM" | sort) || echo Mismatched inputs'

rm -rf out/ || true
mkdir out
mkdir out/disk

mkdir out/asm
nasm -Ox -f bin asm/patch1.asm -o out/asm/patch1.com
nasm -Ox -f bin asm/patch3.asm -o out/asm/patch3.com
nasm -Ox -f bin asm/vgadetect.asm -o out/asm/vgadetect.com

scripts/make-images.sh
scripts/patch.py
cp inputs/planlust/*.{PIQ,EXE} out/disk/
cp out/asm/vgadetect.com out/disk/VGADET.COM
cp scripts/PLANETOF.BAT out/disk/
