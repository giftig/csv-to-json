#!/bin/bash

# Process files in "in" and send them to "out", zipped

for f in $(ls -1 in); do OUT="out/$(uuidgen).json"; ./jsonify.py -i "in/$f" -o "$OUT" && gzip "$OUT"; done
