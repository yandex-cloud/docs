---
editable: false
---

# Метод list
Возвращает список триггеров в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://serverless-triggers.api.cloud.yandex.net/triggers/v1/triggers
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка триггеров.  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `pageSize` , сервис вернет значение [nextPageToken](/docs/functions/triggers/api-ref/Trigger/list#responses), которое можно использовать для получения следующей страницы.  Значение по умолчанию: 100.
pageToken | Токен страницы. Установите значение `pageToken` равным значению поля [nextPageToken](/docs/functions/triggers/api-ref/Trigger/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.
filter | Параметры фильтрации ресурсов в ответе.  В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Trigger.name](/docs/functions/triggers/api-ref/Trigger#representation). 2. Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Пример фильтра: `name=my-trigger`.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "triggers": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "rule": {

        // `triggers[].rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`
        "timer": {
          "cronExpression": "string",

          // `triggers[].rule.timer` включает только одно из полей `invokeFunction`, `invokeFunctionWithRetry`
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
          // конец списка возможных полей`triggers[].rule.timer`

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
        // конец списка возможных полей`triggers[].rule`

      },
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
triggers[] | **object**<br><p>Триггер для вызова бессерверной функции. Дополнительные сведения см. в разделе <a href="/docs/functions/concepts/trigger">Triggers</a>.</p> 
triggers[].<br>id | **string**<br><p>Идентификатор триггера. Генерируется при создании.</p> 
triggers[].<br>folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, в котором создается триггер.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>createdAt | **string** (date-time)<br><p>Время создания триггера.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
triggers[].<br>name | **string**<br><p>Имя триггера.</p> <p>Длина строки в символах должна быть от 3 до 63.</p> 
triggers[].<br>description | **string**<br><p>Описание триггера.</p> <p>Длина строки в символах должна быть от 0 до 256.</p> 
triggers[].<br>labels | **object**<br><p>Метки триггеров в виде пар `key:value` .</p> 
triggers[].<br>rule | **object**<br><p>Обязательное поле. Правило активации триггера (всегда соответствует типу триггера).</p> <p>Описание правила активации триггера.</p> 
triggers[].<br>rule.<br>timer | **object**<br>Правило для таймера. <br>`triggers[].rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br><p>Правило активации таймера.</p> 
triggers[].<br>rule.<br>timer.<br>cronExpression | **string**<br><p>Обязательное поле. Описание расписания в виде <a href="/docs/functions/concepts/trigger/timer">cron expression</a>.</p> <p>Максимальная длина строки в символах — 100.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunction | **object**<br>Инструкции для единичного вызова функции. <br>`triggers[].rule.timer` включает только одно из полей `invokeFunction`, `invokeFunctionWithRetry`<br><br><p>Единичный вызов функции.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, от имени которого будет вызываться функция.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry | **object**<br>Инструкции для вызова функции с повторными попытками по мере необходимости. <br>`triggers[].rule.timer` включает только одно из полей `invokeFunction`, `invokeFunctionWithRetry`<br><br><p>Вызов функции с повторными попытками.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта с правами на вызов функции.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings | **object**<br><p>Политика повторных попыток. Если поле не указано или значение пусто, повторные попытки не предпринимаются.</p> <p>Параметры повторной попытки вызова функции.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Максимальное количество повторных попыток (дополнительных вызовов), прежде чем действие будет считаться неудачным.</p> <p>Допустимые значения — от 1 до 5 включительно.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>interval | **string**<br><p>Обязательное поле. Время ожидания между повторными попытками, в секундах.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue | **object**<br><p>Политика DLQ (отсутствие значения означает отказ от сообщения).</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>queueId | **string**<br><p>Идентификатор очереди.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт с правами на запись в очередь.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>rule.<br>messageQueue | **object**<br>Правило для триггера очереди сообщений. <br>`triggers[].rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br><p>Правило для активации триггера очереди сообщений.</p> 
triggers[].<br>rule.<br>messageQueue.<br>queueId | **string**<br><p>Обязательное поле. Идентификатор очереди сообщений в Yandex Message Queue.</p> 
triggers[].<br>rule.<br>messageQueue.<br>serviceAccountId | **string**<br><p>Обязательное поле. Идентификатор сервисного аккаунта с ролью на чтение очереди сообщений.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>rule.<br>messageQueue.<br>batchSettings | **object**<br>Обязательное поле. Настройки группы сообщений для обработки сообщений в очереди.<br><p>Настройки обработки группы сообщений в очереди.</p> 
triggers[].<br>rule.<br>messageQueue.<br>batchSettings.<br>size | **string** (int64)<br><p>Размер группы сообщений. Триггер отправит группу сообщений в функцию, когда число сообщений в очереди достигнет `size` или истечет `cutoff`.</p> <p>Допустимые значения — от 0 до 10 включительно.</p> 
triggers[].<br>rule.<br>messageQueue.<br>batchSettings.<br>cutoff | **string**<br><p>Обязательное поле. Максимальное время ожидания. Триггер отправит группу сообщений в функцию, когда число сообщений в очереди достигнет `size` или истечет `cutoff`.</p> 
triggers[].<br>rule.<br>messageQueue.<br>visibilityTimeout | **string**<br><p>Переопределение таймаута видимости очереди.</p> <p>Максимальное значение — 43200 seconds.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeFunction | **object**<br>Инструкции для единичного вызова функции.<br><p>Единичный вызов функции.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, от имени которого будет вызываться функция.</p> 
triggers[].<br>rule.<br>iotMessage | **object**<br>Правило для триггера Yandex IoT Core. <br>`triggers[].rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br><p>Правило для активации триггера Yandex IoT Core.</p> 
triggers[].<br>rule.<br>iotMessage.<br>registryId | **string**<br><p>Обязательное поле. Идентификатор реестра Yandex IoT Core.</p> 
triggers[].<br>rule.<br>iotMessage.<br>deviceId | **string**<br><p>Идентификатор устройства в реестре Yandex IoT.</p> 
triggers[].<br>rule.<br>iotMessage.<br>mqttTopic | **string**<br><p>MQTT-топик, сообщения котрого активируют триггер.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction | **object**<br>Инструкции для вызова функции с повторными попытками по мере необходимости.<br><p>Вызов функции с повторными попытками.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта с правами на вызов функции.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Политика повторных попыток. Если поле не указано или значение пусто, повторные попытки не предпринимаются.</p> <p>Параметры повторной попытки вызова функции.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Максимальное количество повторных попыток (дополнительных вызовов), прежде чем действие будет считаться неудачным.</p> <p>Допустимые значения — от 1 до 5 включительно.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Обязательное поле. Время ожидания между повторными попытками, в секундах.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>Политика DLQ (отсутствие значения означает отказ от сообщения).</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>Идентификатор очереди.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт с правами на запись в очередь.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>rule.<br>objectStorage | **object** <br>`triggers[].rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br>
triggers[].<br>rule.<br>objectStorage.<br>eventType[] | **string**<br><p>Обязательное поле. Тип (имя) событий, требуется хотя бы одно значение.</p> <p>Должен содержать хотя бы один элемент.</p> 
triggers[].<br>rule.<br>objectStorage.<br>bucketId | **string**<br><p>Идентификатор бакета.</p> 
triggers[].<br>rule.<br>objectStorage.<br>prefix | **string**<br><p>Префикс ключа объекта. Фильтр, опционально.</p> 
triggers[].<br>rule.<br>objectStorage.<br>suffix | **string**<br><p>Суффикс ключа объекта. Фильтр, опционально.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction | **object**<br>Инструкции для вызова функции с повторными попытками по мере необходимости.<br><p>Вызов функции с повторными попытками.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта с правами на вызов функции.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Политика повторных попыток. Если поле не указано или значение пусто, повторные попытки не предпринимаются.</p> <p>Параметры повторной попытки вызова функции.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Максимальное количество повторных попыток (дополнительных вызовов), прежде чем действие будет считаться неудачным.</p> <p>Допустимые значения — от 1 до 5 включительно.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Обязательное поле. Время ожидания между повторными попытками, в секундах.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>Политика DLQ (отсутствие значения означает отказ от сообщения).</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>Идентификатор очереди.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт с правами на запись в очередь.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>rule.<br>containerRegistry | **object** <br>`triggers[].rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br>
triggers[].<br>rule.<br>containerRegistry.<br>eventType[] | **string**<br><p>Обязательное поле. Тип (имя) событий, требуется хотя бы одно значение.</p> <p>Должен содержать хотя бы один элемент.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>registryId | **string**<br><p>Идентификатор реестра.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>imageName | **string**<br><p>Имя Docker-образа. Фильтр, опционально.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>tag | **string**<br><p>Тег Docker-образа. Фильтр, опционально.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction | **object**<br>Инструкции для вызова функции с повторными попытками по мере необходимости.<br><p>Вызов функции с повторными попытками.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта с правами на вызов функции.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings | **object**<br><p>Политика повторных попыток. Если поле не указано или значение пусто, повторные попытки не предпринимаются.</p> <p>Параметры повторной попытки вызова функции.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Максимальное количество повторных попыток (дополнительных вызовов), прежде чем действие будет считаться неудачным.</p> <p>Допустимые значения — от 1 до 5 включительно.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Обязательное поле. Время ожидания между повторными попытками, в секундах.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>Политика DLQ (отсутствие значения означает отказ от сообщения).</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>Идентификатор очереди.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт с правами на запись в очередь.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>rule.<br>cloudLogs | **object** <br>`triggers[].rule` включает только одно из полей `timer`, `messageQueue`, `iotMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`<br><br>
triggers[].<br>rule.<br>cloudLogs.<br>logGroupId[] | **string**<br><p>Идентификаторы групп журналов, по крайней мере, одно значение обязательно.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>batchSettings | **object**<br>Обязательное поле. Пакетные настройки для обработки событий журнала.<br>
triggers[].<br>rule.<br>cloudLogs.<br>batchSettings.<br>size | **string** (int64)<br><p>Размер группы сообщений. Триггер отправит группу сообщений в функцию, когда число сообщений в лог-группе достигнет `size` или истечет `cutoff`.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>batchSettings.<br>cutoff | **string**<br><p>Максимальное время ожидания. Триггер отправит группу сообщений в функцию, когда число сообщений в лог-группе достигнет `size` или истечет `cutoff`.</p> <p>Допустимые значения — от 1 seconds до 60 seconds включительно.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction | **object**<br>Инструкции для вызова функции с повторными попытками по мере необходимости.<br><p>Вызов функции с повторными попытками.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>functionId | **string**<br><p>Обязательное поле. Идентификатор вызываемой функции.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>functionTag | **string**<br><p>Тег версии выполняемой функции.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта с правами на вызов функции.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings | **object**<br><p>Политика повторных попыток. Если поле не указано или значение пусто, повторные попытки не предпринимаются.</p> <p>Параметры повторной попытки вызова функции.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Максимальное количество повторных попыток (дополнительных вызовов), прежде чем действие будет считаться неудачным.</p> <p>Допустимые значения — от 1 до 5 включительно.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Обязательное поле. Время ожидания между повторными попытками, в секундах.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>Политика DLQ (отсутствие значения означает отказ от сообщения).</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>Идентификатор очереди.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Обязательное поле. Сервисный аккаунт с правами на запись в очередь.</p> <p>Максимальная длина строки в символах — 50.</p> 
triggers[].<br>status | **string**<br><p>Состояние триггера</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем <a href="/docs/functions/triggers/api-ref/Trigger/list#query_params">pageSize</a>, используйте `nextPageToken` в качестве значения параметра <a href="/docs/functions/triggers/api-ref/Trigger/list#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>Все последующие запросы будут получать свои значения `nextPageToken` для перебора страниц результатов.</p> 