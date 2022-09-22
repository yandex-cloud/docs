# Настройка блокировок версий объектов (object lock) в бакете

## Включить возможность блокировок {#enable}

{% list tabs %}

- AWS CLI

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }}/ \
    s3api put-object-lock-configuration \
    --bucket <имя_бакета> \
    --object-lock-configuration ObjectLockEnabled=Enabled
  ```

{% endlist %}

## Настроить блокировки по умолчанию {#default}

{% list tabs %}

- AWS CLI

  1. Опишите конфигурацию блокировок по умолчанию в формате JSON:
 
     ```json
     {
       "Rule": {
         "DefaultRetention": {
           "Mode": "<тип_блокировки>",
           "Days": <срок_блокировки_в_днях>,
           "Years": <срок_блокировки_в_годах>
         }       
       }
     }
     ```
     
     Где:
 
     * `Mode` — [тип](../../concepts/object-lock.md#types) блокировки:
 
       * `GOVERNANCE` — временная управляемая блокировка.
       * `COMPLIANCE` — временная строгая блокировка.
 
     * `Days` — срок блокировки в днях от момента загрузки версии объекта. Должен быть положительным целым числом. Нельзя указывать вместе с `Years`.
     * `Years` — срок блокировки в годах от момента загрузки версии объекта. Должен быть положительным целым числом. Нельзя указывать вместе с `Days`.
 
     Готовую конфигурацию можно поместить в файл, например, `default-object-lock.json`.
 
  1. Загрузите конфигурацию в бакет:
 
     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api put-object-lock-configuration \
       --bucket <имя_бакета> \
       --object-lock-configuration file://default-object-lock.json
     ```
     
     Где:
 
     * `bucket` — имя бакета.
     * `object-lock-configuration` — настройки блокировок по умолчанию. В данном случае указаны в файле `default-object-lock.json`.

{% endlist %}