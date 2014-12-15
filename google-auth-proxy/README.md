This is just a Docker wrapper around this project:

https://github.com/bitly/google_auth_proxy

Follow the directions there for creating a client ID and secret.

You may want to run it something like this:

```
docker run -d --publish=0.0.0.0:8080:8080 texastribune/google-auth-proxy -client-id="<client id>" \
  -client-secret="<client secret>" -google-apps-domain="mydomain.org" \
  -http-address="0.0.0.0:8080" \
  -redirect-url="https://app.mydomain.org/oauth2/callback" \
  -upstream="http://my-protected-app.mydomain.org/"
```
