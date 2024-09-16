#!/bin/sh
set -e

printf '\\newpage\n\n' > combined.md
cat _index.md >> combined.md
printf '\n\n' >> combined.md
for md in procedures/*.md; do
	printf '\n\n\\newpage\n\n' >> combined.md
	pandoc $md \
		--lua-filter=.github/scripts/filter.lua \
		-f markdown-markdown_in_html_blocks \
		-t markdown >> combined.md
done
pandoc combined.md --toc -V toc-title:"Figma" --pdf-engine=xelatex setmainfont='Arial' -fmarkdown-implicit_figures -o Figma-Procedures-Combined.pdf
