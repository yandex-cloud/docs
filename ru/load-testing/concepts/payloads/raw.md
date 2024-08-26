# RAW

Тип тестовых данных для генератора нагрузки Pandora. Аналог типа данных [PHANTOM](phantom.md). Позволяет передавать HTTP-запросы с любыми методами и в любых сочетаниях.

Тип тестовых данных указывается при [создании теста](../../operations/create-test-bucket.md#create-test).

Формат данных:

```http
73 good
GET / HTTP/1.0
Host: xxx.tanks.example.com
User-Agent: xxx (shell 1)

77 bad
GET /abra HTTP/1.0
Host: xxx.tanks.example.com
User-Agent: xxx (shell 1)
```

При конфигурации генератора нагрузки Pandora с помощью yaml-файла необходимо указать тип `raw` в секции `ammo`:

```yaml
config_content:
   pools:
   - id: HTTP
      ammo:
         type: raw
         file: ./ammo.raw
```

При загрузке файла с тестовыми данными через консоль управления типы данных и пути подставляются автоматически.