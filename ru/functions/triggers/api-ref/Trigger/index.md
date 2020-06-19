---
editable: false
---

# Trigger
Набор методов управления триггерами для бессерверных функций.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "rule": {

    // `rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`
    "timer": {
      "cronExpression": "string",
      "invokeFunction": {
        "functionId": "string",
        "functionTag": "string",
        "serviceAccountId": "string"
      }
    },
    "messageQueue": {
      "queueId": "string",
      "serviceAccountId": "string",
      "batchSettings": {
        "size": "string",
        "cutoff": "string"
      },
      "visibilityTimeout": "string",
      "invokeFunction": {
        "functionId": "string",
        "functionTag": "string",
        "serviceAccountId": "string"
      }
    },
    "iotMessage": {
      "registryId": "string",
      "deviceId": "string",
      "mqttTopic": "string",
      "invokeFunction": {
        "functionId": "string",
        "functionTag": "string",
        "serviceAccountId": "string",
        "retrySettings": {
          "retryAttempts": "string",
          "interval": "string"
        }
      }
    },
    "objectStorage": {
      "eventType": [
        "string"
      ],
      "bucketId": "string",
      "prefix": "string",
      "suffix": "string",
      "invokeFunction": {
        "functionId": "string",
        "functionTag": "string",
        "serviceAccountId": "string",
        "retrySettings": {
          "retryAttempts": "string",
          "interval": "string"
        }
      }
    },
    // конец списка возможных полей`rule`

  }
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор триггера. Генерируется во время создания.</p> 
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, в котором создается триггер.</p> <p>Максимальная длина строки в символах — 50.</p> 
createdAt | **string** (date-time)<br><p>Время создания триггера.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя триггера.</p> <p>Длина строки в символах должна быть от 3 до 63.</p> 
description | **string**<br><p>Описание триггера.</p> <p>Длина строки в символах должна быть от 0 до 256.</p> 
labels | **object**<br><p>Метки триггеров в виде пар <code>key:value</code> .</p> 
rule | **object**<br><p>Обязательное поле. Правило активации триггера (всегда соответствует типу триггера).</p> <p>Описание правила активации триггера.</p> 
rule.<br>timer | **object** <br>`rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`<br><br><p>Правило активации для таймера.</p> 
rule.<br>timer.<br>cronExpression | **string**<br><p>Обязательное поле. Описание расписания в виде <a href="/docs/functions/concepts/trigger/timer">cron-выражения</a>.</p> <p>Максимальная длина строки в символах — 100.</p> 
rule.<br>timer.<br>invokeFunction | **object**<br><p>Единичный вызов функции.</p> 
rule.<br>timer.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>timer.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии функции для выполнения.</p> 
rule.<br>timer.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, от имени которого будет вызываться функция.</p> 
rule.<br>messageQueue | **object** <br>`rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`<br><br><p>Правило для активации триггера очереди сообщений.</p> 
rule.<br>messageQueue.<br>queueId | **string**<br><p>Обязательное поле. Идентификатор очереди сообщений в Yandex Message Queue.</p> 
rule.<br>messageQueue.<br>serviceAccountId | **string**<br><p>Обязательное поле. Идентификатор сервисного аккаунта с ролью на чтение очереди сообщений.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>messageQueue.<br>batchSettings | **object**<br><p>Настройки обработки группы сообщений в очереди.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>size | **string** (int64)<br><p>Размер группы сообщений. Триггер отправит группу сообщений в соответствующую функцию, когда число сообщений в очереди достигнет этого значения, или прошло <code>cutoff</code> время.</p> <p>Допустимые значения — от 0 до 10 включительно.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>cutoff | **string**<br><p>Обязательное поле. Максимальное время ожидания. Триггер отправит группу сообщений, если время с момента последнего пакета превышает <code>cutoff</code> значение, независимо от количества сообщений в очереди.</p> 
rule.<br>messageQueue.<br>visibilityTimeout | **string**<br><p>Переопределение таймаута видимости очереди.</p> <p>Максимальное значение — 43200 seconds.</p> 
rule.<br>messageQueue.<br>invokeFunction | **object**<br>Инструкции для вызова функции один раз.<br><p>Единичный вызов функции.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии функции для выполнения.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, от имени которого будет вызываться функция.</p> 
rule.<br>iotMessage | **object** <br>`rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`<br><br><p>Правило для активации триггера Yandex IoT Core.</p> 
rule.<br>iotMessage.<br>registryId | **string**<br><p>Обязательное поле. Идентификатор реестра Yandex IoT Core.</p> 
rule.<br>iotMessage.<br>deviceId | **string**<br><p>Идентификатор устройства в реестре Yandex IoT.</p> 
rule.<br>iotMessage.<br>mqttTopic | **string**<br><p>MQTT-топик, сообщения котрого активируют триггер.</p> 
rule.<br>iotMessage.<br>invokeFunction | **object**<br><p>Вызов функции с повторными попытками.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии функции для выполнения.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта с ролью на вызов функции.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Политика повторных попыток. Если поле не указано или значение пусто, повторные попытки не предпринимаются.</p> <p>Параметры повторной попытки вызова функции.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Максимальное количество повторных попыток (дополнительных вызовов), прежде чем действие будет считаться неудачным.</p> <p>Допустимые значения — от 1 до 5 включительно.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Обязательное поле. Время ожидания между повторными попытками, в секундах.</p> 
rule.<br>objectStorage | **object** <br>`rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`<br><br>
rule.<br>objectStorage.<br>eventType[] | **string**<br><p>Обязательное поле. Тип (имя) событий, требуется хотя бы одно значение.</p> <p>Должен содержать хотя бы один элемент.</p> 
rule.<br>objectStorage.<br>bucketId | **string**<br>
rule.<br>objectStorage.<br>prefix | **string**<br><p>Фильтр, опционально.</p> 
rule.<br>objectStorage.<br>suffix | **string**<br>
rule.<br>objectStorage.<br>invokeFunction | **object**<br>Инструкции для вызова функции с повторными попытками по мере необходимости.<br><p>Вызов функции с повторными попытками.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии функции для выполнения.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта с ролью на вызов функции.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Политика повторных попыток. Если поле не указано или значение пусто, повторные попытки не предпринимаются.</p> <p>Параметры повторной попытки вызова функции.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Максимальное количество повторных попыток (дополнительных вызовов), прежде чем действие будет считаться неудачным.</p> <p>Допустимые значения — от 1 до 5 включительно.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Обязательное поле. Время ожидания между повторными попытками, в секундах.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает триггер в указанном каталоге.
[delete](delete.md) | Удаляет указанный триггер.
[get](get.md) | Возвращает указанный триггер.
[list](list.md) | Возвращает список триггеров в указанном каталоге.
[listOperations](listOperations.md) | Возвращает список операций для указанного триггера.
[update](update.md) | Обновляет указанный триггер.