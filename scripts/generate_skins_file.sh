color_schemes_dir="./color-schemes"
skins_file="./base16_sublime_text.skins"

if [ ! -d "$color_schemes_dir" ]; then
    echo "Generate template with a builder first and then run this script again..."
    exit 1
fi

concatenated_names=""

for file in "$color_schemes_dir"/*.sublime-color-scheme; do
    name=$(basename "$file" .sublime-color-scheme)
    slug="${name#base16-}"

    # Generate json
    concatenated_names="$concatenated_names\"$slug\": "
      concatenated_names="$concatenated_names{ \"Preferences\": {"
        concatenated_names="$concatenated_names \"color_scheme\": \"Packages/base16_sublime_text/color_scheme/$name.sublime-color-scheme\", "
        concatenated_names="$concatenated_names \"theme\": \"Packages/base16_sublime_text/$name.sublime-theme\""
      concatenated_names="$concatenated_names }"
    concatenated_names="$concatenated_names },"
done

echo "{ ${concatenated_names%?} }" > "$skins_file"
