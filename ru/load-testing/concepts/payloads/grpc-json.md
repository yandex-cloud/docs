# GRPC_JSON

Тип тестовых данных для генератора нагрузки Pandora. Поддерживает [gRPC](../../../glossary/grpc)-запросы. 

Тип тестовых данных указывается при [создании теста](../../operations/create-test-bucket.md#create-test).

Формат данных:

```json
{"tag": "/Add", "call": "api.Adder.Add", "metadata": {"Authorization": "Bearer $YC_TOKEN"}, "payload": {"x": 21, "y": 12}}
{"tag": "/Add", "call": "api.Adder.Add", "metadata": {"Authorization": "Bearer $YC_TOKEN"}, "payload": {"x": 22, "y": 13}}
{"tag": "/Add", "call": "api.Adder.Add", "metadata": {"Authorization": "Bearer $YC_TOKEN"}, "payload": {"x": 23, "y": 14}}
```
Где:
   * `tag` - уcловное обозначение запроса (тег), которое используется в интерфейсе отображения результатов. Позволяет пометить запросы разными тегами для группировки и фильтрации результатов тестов.
   * `call` - сервис и его вызываемый метод.
   * `metadata` - используется для отправки хедеров, например `Authorization`.
   * `payload` - тело запроса.


При конфигурации генератора нагрузки Pandora с помощью yaml-файла необходимо указать тип `grpc/json` в секции `ammo`:

```yaml
pandora:
  enabled: true
  config_content:
    pools:
      - id: Custom
        gun:
          type: grpc
          target: 'test.hostname:80'
        ammo:
          type: grpc/json
          file: ./ammo.json
        result:
          type: phout
          destination: ./phout.log
        rps:
          - duration: 8m
            from: 1
            to: 700
            type: line
        startup:
          - type: once
            times: 8000
    log:
      level: debug
    monitoring:
      expvar:
        enabled: true
        port: 1234
```

При загрузке файла с тестовыми данными через консоль управления типы данных и пути подставляются автоматически.