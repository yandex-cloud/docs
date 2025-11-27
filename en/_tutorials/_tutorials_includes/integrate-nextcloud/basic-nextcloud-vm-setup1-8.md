Enable the required [Apache web server](https://en.wikipedia.org/wiki/Apache_HTTP_Server) modules:

```bash
sudo a2enmod rewrite
sudo a2enmod headers
a2enmod env
a2enmod dir
a2enmod mime
```