Включите необходимые модули [веб-сервера Apache](https://ru.wikipedia.org/wiki/Apache_HTTP_Server):

```bash
sudo a2enmod rewrite
sudo a2enmod headers
a2enmod env
a2enmod dir
a2enmod mime
```