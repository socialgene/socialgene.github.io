## Celery task handler info

- tips
  - <https://www.vinta.com.br/blog/2018/celery-wild-tips-and-tricks-run-async-tasks-real-world/>

TODO: this all needs to be looked through and re-written

 <https://github.com/pydanny/cookiecutter-django/>

git init
pre-commit install

docker-compose -f local.yml build
docker-compose -f local.yml up

# Create a new Django app

`docker-compose -f local.yml run --rm django python manage.py startapp new-app-name`

# Migrate DBs

docker-compose -f local.yml run --rm django python manage.py migrate
