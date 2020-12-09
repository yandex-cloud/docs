---
editable: false
---

# Метод create
Создает триггер в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
POST https://serverless-triggers.api.cloud.yandex.net/triggers/v1/triggers
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "rule": {

    // `rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`
    "timer": {
      "cronExpression": "string",

      // `rule.timer` включает только одно из полей `invokeFunction`, `invokeFunctionWithRetry`
      "invokeFunction": {
        "functionId": "string",
        "functionTag": "string",
        "serviceAccountId": "string"
      },
      "invokeFunctionWithRetry": {
        "functionId": "string",
        "functionTag": "string",
        "serviceAccountId": "string",
        "retrySettings": {
          "retryAttempts": "string",
          "interval": "string"
        },
        "deadLetterQueue": {
          "queueId": "string",
          "serviceAccountId": "string"
        }
      },
      // конец списка возможных полей`rule.timer`

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
        },
        "deadLetterQueue": {
          "queueId": "string",
          "serviceAccountId": "string"
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
        },
        "deadLetterQueue": {
          "queueId": "string",
          "serviceAccountId": "string"
        }
      }
    },
    "containerRegistry": {
      "eventType": [
        "string"
      ],
      "registryId": "string",
      "imageName": "string",
      "tag": "string",
      "invokeFunction": {
        "functionId": "string",
        "functionTag": "string",
        "serviceAccountId": "string",
        "retrySettings": {
          "retryAttempts": "string",
          "interval": "string"
        },
        "deadLetterQueue": {
          "queueId": "string",
          "serviceAccountId": "string"
        }
      }
    },
    "cloudLogs": {
      "logGroupId": [
        "string"
      ],
      "batchSettings": {
        "size": "string",
        "cutoff": "string"
      },
      "invokeFunction": {
        "functionId": "string",
        "functionTag": "string",
        "serviceAccountId": "string",
        "retrySettings": {
          "retryAttempts": "string",
          "interval": "string"
        },
        "deadLetterQueue": {
          "queueId": "string",
          "serviceAccountId": "string"
        }
      }
    },
    // конец списка возможных полей`rule`

  }
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, в котором создается триггер.</p> <p>Чтобы получить идентификатор каталога, используйте запрос <a href="/docs/resource-manager/api-ref/Folder/list">list</a>.</p> 
name | **string**<br><p>Имя триггера. Имя должно быть уникальным в рамках каталога.</p> <p>Значение должно соответствовать регулярному выражению `` \|[a-z][-a-z0-9]{1,61}[a-z0-9] ``.</p> 
description | **string**<br><p>Описание триггера.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Метки ресурса в формате `key:value`.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению `` [a-z][-_0-9a-z]* ``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению `` [-_0-9a-z]* ``.</p> 
rule | **object**<br><p>Обязательное поле. Тип триггера.</p> <p>Описание правила активации триггера.</p> 
rule.<br>timer | **object**<br>Правило для таймера. <br>`rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br><p>Правило активации таймера.</p> 
rule.<br>timer.<br>cronExpression | **string**<br><p>Обязательное поле. Описание расписания в виде <a href="/docs/functions/concepts/trigger/timer">cron expression</a>.</p> <p>Максимальная длина строки в символах — 100.</p> 
rule.<br>timer.<br>invokeFunction | **object**<br>Инструкции для единичного вызова функции. <br>`rule.timer` включает только одно из полей `invokeFunction`, `invokeFunctionWithRetry`<br><br><p>Единичный вызов функции.</p> 
rule.<br>timer.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>timer.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
rule.<br>timer.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, от имени которого будет вызываться функция.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry | **object**<br>Инструкции для вызова функции с повторными попытками по мере необходимости. <br>`rule.timer` включает только одно из полей `invokeFunction`, `invokeFunctionWithRetry`<br><br><p>Вызов функции с повторными попытками.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта с правами на вызов функции.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings | **object**<br><p>Политика повторных попыток. Если поле не указано или значение пусто, повторные попытки не предпринимаются.</p> <p>Параметры повторной попытки вызова функции.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Максимальное количество повторных попыток (дополнительных вызовов), прежде чем действие будет считаться неудачным.</p> <p>Допустимые значения — от 1 до 5 включительно.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>interval | **string**<br><p>Обязательное поле. Время ожидания между повторными попытками, в секундах.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue | **object**<br><p>Политика DLQ (отсутствие значения означает отказ от сообщения).</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>queueId | **string**<br><p>Идентификатор очереди.</p> 
rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт с правами на запись в очередь.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>messageQueue | **object**<br>Правило для триггера очереди сообщений. <br>`rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br><p>Правило для активации триггера очереди сообщений.</p> 
rule.<br>messageQueue.<br>queueId | **string**<br><p>Обязательное поле. Идентификатор очереди сообщений в Yandex Message Queue.</p> 
rule.<br>messageQueue.<br>serviceAccountId | **string**<br><p>Обязательное поле. Идентификатор сервисного аккаунта с ролью на чтение очереди сообщений.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>messageQueue.<br>batchSettings | **object**<br>Обязательное поле. Настройки группы сообщений для обработки сообщений в очереди.<br><p>Настройки обработки группы сообщений в очереди.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>size | **string** (int64)<br><p>Размер группы сообщений. Триггер отправит группу сообщений в функцию, когда число сообщений в очереди достигнет `size` или истечет `cutoff`.</p> <p>Допустимые значения — от 0 до 10 включительно.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>cutoff | **string**<br><p>Обязательное поле. Максимальное время ожидания. Триггер отправит группу сообщений в функцию, когда число сообщений в очереди достигнет `size` или истечет `cutoff`.</p> 
rule.<br>messageQueue.<br>visibilityTimeout | **string**<br><p>Переопределение таймаута видимости очереди.</p> <p>Максимальное значение — 43200 seconds.</p> 
rule.<br>messageQueue.<br>invokeFunction | **object**<br>Инструкции для единичного вызова функции.<br><p>Единичный вызов функции.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, от имени которого будет вызываться функция.</p> 
rule.<br>iotMessage | **object**<br>Правило для триггера Yandex IoT Core. <br>`rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br><p>Правило для активации триггера Yandex IoT Core.</p> 
rule.<br>iotMessage.<br>registryId | **string**<br><p>Обязательное поле. Идентификатор реестра Yandex IoT Core.</p> 
rule.<br>iotMessage.<br>deviceId | **string**<br><p>Идентификатор устройства в реестре Yandex IoT.</p> 
rule.<br>iotMessage.<br>mqttTopic | **string**<br><p>MQTT-топик, сообщения котрого активируют триггер.</p> 
rule.<br>iotMessage.<br>invokeFunction | **object**<br>Инструкции для вызова функции с повторными попытками по мере необходимости.<br><p>Вызов функции с повторными попытками.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта с правами на вызов функции.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Политика повторных попыток. Если поле не указано или значение пусто, повторные попытки не предпринимаются.</p> <p>Параметры повторной попытки вызова функции.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Максимальное количество повторных попыток (дополнительных вызовов), прежде чем действие будет считаться неудачным.</p> <p>Допустимые значения — от 1 до 5 включительно.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Обязательное поле. Время ожидания между повторными попытками, в секундах.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>Политика DLQ (отсутствие значения означает отказ от сообщения).</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>Идентификатор очереди.</p> 
rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт с правами на запись в очередь.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>objectStorage | **object** <br>`rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br>
rule.<br>objectStorage.<br>eventType[] | **string**<br><p>Обязательное поле. Тип (имя) событий, требуется хотя бы одно значение.</p> <p>Должен содержать хотя бы один элемент.</p> 
rule.<br>objectStorage.<br>bucketId | **string**<br><p>Идентификатор бакета.</p> 
rule.<br>objectStorage.<br>prefix | **string**<br><p>Префикс ключа объекта. Фильтр, опционально.</p> 
rule.<br>objectStorage.<br>suffix | **string**<br><p>Суффикс ключа объекта. Фильтр, опционально.</p> 
rule.<br>objectStorage.<br>invokeFunction | **object**<br>Инструкции для вызова функции с повторными попытками по мере необходимости.<br><p>Вызов функции с повторными попытками.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта с правами на вызов функции.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Политика повторных попыток. Если поле не указано или значение пусто, повторные попытки не предпринимаются.</p> <p>Параметры повторной попытки вызова функции.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Максимальное количество повторных попыток (дополнительных вызовов), прежде чем действие будет считаться неудачным.</p> <p>Допустимые значения — от 1 до 5 включительно.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Обязательное поле. Время ожидания между повторными попытками, в секундах.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>Политика DLQ (отсутствие значения означает отказ от сообщения).</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>Идентификатор очереди.</p> 
rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт с правами на запись в очередь.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>containerRegistry | **object** <br>`rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br>
rule.<br>containerRegistry.<br>eventType[] | **string**<br><p>Обязательное поле. Тип (имя) событий, требуется хотя бы одно значение.</p> <p>Должен содержать хотя бы один элемент.</p> 
rule.<br>containerRegistry.<br>registryId | **string**<br><p>Идентификатор реестра.</p> 
rule.<br>containerRegistry.<br>imageName | **string**<br><p>Имя Docker-образа. Фильтр, опционально.</p> 
rule.<br>containerRegistry.<br>tag | **string**<br><p>Тег Docker-образа. Фильтр, опционально.</p> 
rule.<br>containerRegistry.<br>invokeFunction | **object**<br>Инструкции для вызова функции с повторными попытками по мере необходимости.<br><p>Вызов функции с повторными попытками.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта с правами на вызов функции.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings | **object**<br><p>Политика повторных попыток. Если поле не указано или значение пусто, повторные попытки не предпринимаются.</p> <p>Параметры повторной попытки вызова функции.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Максимальное количество повторных попыток (дополнительных вызовов), прежде чем действие будет считаться неудачным.</p> <p>Допустимые значения — от 1 до 5 включительно.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Обязательное поле. Время ожидания между повторными попытками, в секундах.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>Политика DLQ (отсутствие значения означает отказ от сообщения).</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>Идентификатор очереди.</p> 
rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт с правами на запись в очередь.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>cloudLogs | **object** <br>`rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br>
rule.<br>cloudLogs.<br>logGroupId[] | **string**<br><p>Идентификаторы групп журналов, по крайней мере, одно значение обязательно.</p> 
rule.<br>cloudLogs.<br>batchSettings | **object**<br>Обязательное поле. Пакетные настройки для обработки событий журнала.<br>
rule.<br>cloudLogs.<br>batchSettings.<br>size | **string** (int64)<br><p>Размер группы сообщений. Триггер отправит группу сообщений в функцию, когда число сообщений в лог-группе достигнет `size` или истечет `cutoff`.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
rule.<br>cloudLogs.<br>batchSettings.<br>cutoff | **string**<br><p>Максимальное время ожидания. Триггер отправит группу сообщений в функцию, когда число сообщений в лог-группе достигнет `size` или истечет `cutoff`.</p> <p>Допустимые значения — от 1 seconds до 60 seconds включительно.</p> 
rule.<br>cloudLogs.<br>invokeFunction | **object**<br>Инструкции для вызова функции с повторными попытками по мере необходимости.<br><p>Вызов функции с повторными попытками.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта с правами на вызов функции.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings | **object**<br><p>Политика повторных попыток. Если поле не указано или значение пусто, повторные попытки не предпринимаются.</p> <p>Параметры повторной попытки вызова функции.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Максимальное количество повторных попыток (дополнительных вызовов), прежде чем действие будет считаться неудачным.</p> <p>Допустимые значения — от 1 до 5 включительно.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Обязательное поле. Время ожидания между повторными попытками, в секундах.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>Политика DLQ (отсутствие значения означает отказ от сообщения).</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>Идентификатор очереди.</p> 
rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт с правами на запись в очередь.</p> <p>Максимальная длина строки в символах — 50.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  включает только одно из полей `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // конец списка возможных полей

}
```
Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`.</p> 