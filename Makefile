## help	:	Print help info
help : Makefile
	@sed -n 's/^##//p' $<

##
## DOCUMENTATION BUILDING/SERVING
##

pipify: 
	pip install mkdocs mkdocstrings mkdocs-material mkdocs-literate-nav mkdocs-section-index "mkdocstrings[python]" socialgene



## doc_build	:	Build the mkdocs documentation
build: 
	mkdocs build

## doc_serve	:	Serve the mkdocs documentation locally
serve: 
	mkdocs serve



