#!/bin/bash

prefix="-- nvim/"

find . -type f -name "*.lua" \
    ! -path "*/.git/*" \
    ! -path "*/.undodir/*" \
    ! -path "*/node_modules/*" \
    | while IFS= read -r file; do

    # Get relative path
    relative_path="${file#./}"
    comment="${prefix}${relative_path}"

    # Check if file already contains the comment in first 5 lines
    if head -n 5 "$file" | grep -Fq "$comment"; then
        echo "ℹ️ Already annotated: $relative_path"
    else
        tmpfile=$(mktemp)
        echo "$comment" > "$tmpfile"
        echo "" >> "$tmpfile"
        cat "$file" >> "$tmpfile"
        mv "$tmpfile" "$file"
        echo "✅ Annotated: $relative_path"
    fi
done
