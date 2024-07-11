Чтобы проверить работу хостинга:

1. Создайте главную страницу сайта — файл `index.html`

    {% cut "Пример файла index.html" %}

    ```html
    <!DOCTYPE html>
    <html>
      <head>
        <title>My site</title>
      </head>
      <body>
        <h1>This is my site</h1>
      </body>
    </html>
    ```

    {% endcut %}

1. Загрузите файл `index.html` на каждую ВМ:

    {% include [upload-files](../upload-web-site-files.md) %}

1. В браузере откройте сайт по адресу `http://my-site.com` — должно произойти перенаправление на страницу `https://my-site.com`, где уже подключен TLS-сертификат из {{ certificate-manager-name }}.