#!/usr/bin/env python3
import sys

all = sys.stdin.buffer.read()
sys.stdout.buffer.write(all[:-769])
