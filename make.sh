#!/bin/bash
set -euf -o pipefail

scripts/make-images.sh
scripts/patch.py
