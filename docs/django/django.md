## Create a superuser/admin account

Must be done at least once after running `make up` so the postgres database gets created.

Run the following at the top directory of socialgene:

```bash
make manage createsuperuser
```

# Create Super User

docker-compose -f local.yml run --rm django python manage.py createsuperuser

<https://www.csestack.org/create-html-form-insert-data-database-django/>
