# socialgeneweb

<a href="https://github.com/pydanny/cookiecutter-django/" target="_blank">
  <img src="https://img.shields.io/badge/built%20with-Cookiecutter%20Django-ff69b4.svg?logo=cookiecutter"  alt = "Built with Cookiecutter Django"/>
</a>
<a href="https://github.com/ambv/black" target="_blank">
  <img src="https://img.shields.io/badge/code%20style-black-000000.svg"  alt = "Black code style"/>
</a>

## Info

99% of this templated from the cokiecutter template, when in doubt, or for more info, refer to the detailed [cookiecutter-django Docker documentation](https://cookiecutter-django.readthedocs.io/en/3.1.13)

## Settings

Advanced settings available from the cookiecutter template can be found here:

- [http://cookiecutter-django.readthedocs.io/en/latest/settings.html](http://cookiecutter-django.readthedocs.io/en/latest/settings.html)

## Setting Up Users

- To create a **normal user account**, just go to Sign Up and fill out the form. Once you submit it, you'll see a "Verify Your E-mail Address" page. Go to your console to see a simulated email verification message. Copy the link into your browser. Now the user's email should be verified and ready to go.

- To create an **superuser account**, use this command:

=== "shell"
```bash
python manage.py createsuperuser
```

For convenience, you can keep your normal user logged in on Chrome and your superuser logged in on Firefox (or similar), so that you can see how the site behaves for both kinds of users.

## Type checks

Running type checks with mypy:

=== "shell"
```bash
mypy socialgeneweb
```

## Test coverage

To run the tests, check your test coverage, and generate an HTML coverage report:

=== "shell"
```bash
coverage run -m pytest
coverage html
open htmlcov/index.html
```

## Running tests with py.test

=== "shell"
```bash
pytest
```

## Live reloading and Sass CSS compilation

Moved to `Live reloading and SASS compilation`_.

.. _`Live reloading and SASS compilation`: <http://cookiecutter-django.readthedocs.io/en/latest/live-reloading-and-sass-compilation.html>

## Celery

This app comes with Celery.

To run a celery worker:

=== "shell"
```bash
cd socialgeneweb
celery -A config.celery_app worker -l info
```

Please note: For Celery's import magic to work, it is important *where* the celery commands are run. If you are in the same folder with *manage.py*, you should be right.

## Email Server

In development, it is often nice to be able to see emails that are being sent from your application. For that reason local SMTP server `MailHog`_ with a web interface is available as docker container.

Container mailhog will start automatically when you will run all docker containers.
Please check `cookiecutter-django Docker documentation`_ for more details how to start all containers.

With MailHog running, to view messages that are sent by your application, open your browser and go to ``http://127.0.0.1:8025``

.. _mailhog: <https://github.com/mailhog/MailHog>

## Sentry

Sentry is an error logging aggregator service. You can sign up for a free account at  <https://sentry.io/signup/?code=cookiecutter>  or download and host it yourself.
The system is setup with reasonable defaults, including 404 logging and integration with the WSGI application.

You must set the DSN url in production.

## Deployment

The following details how to deploy this application.

## Docker

See detailed `cookiecutter-django Docker documentation`_.

.. _`cookiecutter-django Docker documentation`: <http://cookiecutter-django.readthedocs.io/en/latest/deployment-with-docker.html>
