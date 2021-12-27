# RAW

Тип тестовых данных для генератора нагрузки Pandora. Аналог типа данных [PHANTOM](phantom.md).

Формат данных:

```
73 good
GET / HTTP/1.0
Host: xxx.tanks.example.com
User-Agent: xxx (shell 1)

77 bad
GET /abra HTTP/1.0
Host: xxx.tanks.example.com
User-Agent: xxx (shell 1)
```

При конфигурации генератора нагрузки Pandora с помощью файла необходимо указать тип `raw` в секции `ammo`:

```
config_content:
          pools:
           - id: HTTP
             ammo:
               type: raw
               file: ./ammo.raw
```

При загрузке файла с тестовыми данными через консоль управления типы данных и пути подставляются автоматически.