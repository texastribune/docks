Creates a gunicorn/nginx wrapper around your WGSI application.  

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
