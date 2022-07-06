



## help	:	Print help info
help : Makefile
	@sed -n 's/^##//p' $<

## clean	:	Clean temporary files, INCLUDES DELETING THE NEXTFLOW TEMPORY WORK DIRECTORY
clean:
	@echo "Cleaning up temporary Python files..."
	find ./socialgene -type f -name "*.py[co]" -exec rm -r {} +
	find ./socialgene -type d -name "__pycache__" -exec rm -r {} +
	find ./socialgene -type d -name "htmlcov" -exec rm -r {} +
	find ./socialgene -type d -name "Autometa.egg-info" -exec rm -r {} +
	find ./socialgene -type d -name "dist" -exec rm -r {} +
	find ./socialgene -type d -name "build" -exec rm -r {} +
	find ./socialgene -type d -name ".eggs" -exec rm -r {} +
	find ./socialgene -type d -name "*.egg-info" -exec rm -r {} +
	find ./socialgene -type d -name ".pytest_cache" -exec rm -r {} +
	find ./socialgene -type d -name ".tox" -exec rm -r {} +
	find ./socialgene -type d -name ".coverage" -exec rm -r {} +
	find ./django -type d -name "local_postgres_data" -exec rm -r {} +
	find ./django -type d -name "local_postgres_data_backups" -exec rm -r {} +
	find ./django -type d -name "redis-data" -exec rm -r {} +
	find . -name ".nextflow.log.*" -exec rm -r {} +
	find . -type d -name ".nextflow" -exec rm -r {} +
	find . -name ".nextflow.log" -exec rm {} +
	find . -type d -name "work" -exec rm -r {} +
	find . -type d -name ".pytest_cache" -exec rm -r {} +
	find . -type d -name "__pycache__" -exec rm -r {} +
	find . -type d -name "site" -exec rm -r {} +


##
## DOCUMENTATION BUILDING/SERVING
##

create_conda: 
	conda create --name sg_doc_build python=3.10 mkdocs mkdocstrings  mkdocs-material -y
	# conda activate sg_doc_build


## doc_build	:	Build the mkdocs documentation
build: 
	mkdocs build

## doc_serve	:	Serve the mkdocs documentation locally
serve: 
	mkdocs serve

