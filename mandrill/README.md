## WARNING: If not careful you could configure an open relay with this.  Limit what can speak to port 25 of this container.

### Notes:
- `/var/log` is exported as a VOLUME so you can view the postfix logs
- uses `MANDRILL_USERNAME` and `MANDRILL_KEY` as environment variables
- see `Makefile`
