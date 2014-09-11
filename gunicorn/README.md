Creates a gunicorn/nginx wrapper around your WGSI application.

This was written for Django but you ought to be able to use it for any WSGI
application.  Of course, if you're not using Django then the `manage.py`
reference below won't be applicable.

Requirements:
- `manage.py` must be placed in `/app`, for example:
```
    ADD salaries/manage.py /app/
```
- `wsgi.py` must be named that and present in `/app`:
```
    ADD salaries/salaries/wsgi.py /app/
```
If the WSGI file can't be placed there for whatever reason use `sed` or similar
in your descendent image to change the path in `gunicorn.supervisor.conf`

- `DJANGO_SETTINGS_MODULE` should be specified relative to the repository's root directory:
```
    ENV DJANGO_SETTINGS_MODULE salaries.salaries.settings.production
```
