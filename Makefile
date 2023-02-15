## help	:	Print help info
help : Makefile
	@sed -n 's/^##//p' $<



##
## DOCUMENTATION BUILDING/SERVING
##

create_conda: 
	conda create --name sg_doc_build python mkdocs mkdocstrings  mkdocs-material -y
	# conda activate sg_doc_build


## doc_build	:	Build the mkdocs documentation
build: 
	mkdocs build

## doc_serve	:	Serve the mkdocs documentation locally
serve: 
	mkdocs serve

