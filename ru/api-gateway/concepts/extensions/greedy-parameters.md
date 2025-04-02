# Жадные параметры

[Спецификация OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) позволяет захватывать только один сегмент URL. Чтобы захватить несколько сегментов, добавьте `+` после имени параметра: `/prefix/{param+}/suffix`.

Например, чтобы захватить `/static/js/main.js`, добавьте в спецификацию `/static/{file+}` вместо `/static/{file}`.

Жадные параметры совместимы со всеми типами расширения [x-yc-apigateway-integration](./index.md#integration).

## Спецификация расширения {#spec}

Пример спецификации:

```yaml
/static/{file+}:
    get:
      summary: Serve static file from Yandex Cloud Object Storage
      parameters:
        - name: file
          in: path
          required: true
          schema:
            type: string
      x-yc-apigateway-integration:
        type: object_storage
        bucket: my-example-bucket
        object: '{file}'
        error_object: error.html
```

## Примеры использования {#examples}

* [{#T}](../../tutorials/deploy-app-container.md)
