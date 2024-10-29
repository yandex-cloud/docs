# HTTP_JSON

Тип тестовых данных для генератора нагрузки Pandora. Представляет собой HTTP-запросы, помещенные в структуры JSON.

Тип тестовых данных указывается при [создании теста](../../operations/create-test-bucket.md#create-test).

Формат данных:

```json
{"host": "example.com", "method": "GET", "uri": "/api/url1", "tag": "url1", "headers": {"User-agent": "Tank", "Connection": "close"}}
{"host": "example.com", "method": "POST", "uri": "/api/url2", "tag": "url2", "headers": {"User-agent": "Tank", "Connection": "close"}, "body": "body_data"}
```

Где:

* `host` — значение заголовка `Host`.
* `method` — метод HTTP-запроса.
* `uri` — URI запроса.
* `tag` — тег запроса для отображения в отчетах.
* `headers` — заголовки запроса.
* `body` — тело POST-запроса. Указывается, если `method=POST`.

Если в параметре `body` передается структура JSON, внутри нее следует экранировать кавычки символом `\`:

```json
{"host": "example.com", "method": "POST", "uri": "/api/url2", "tag": "url2", "headers": {"User-agent": "Tank", "Connection": "close"}, "body": "{\"data\": \"some_data\"}"}
```

При конфигурации генератора нагрузки Pandora с помощью файла необходимо указать тип `http/json` в секции `ammo`:

```yaml
config_content:
          pools:
           - id: HTTP
             ammo:
               type: http/json
               file: ./ammo.json
```

При загрузке файла с тестовыми данными через консоль управления это происходит автоматически.