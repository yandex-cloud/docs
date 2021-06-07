---
editable: false
---

# Метод createExternalDictionary
Создает внешний словарь для указанного кластера ClickHouse.
 

 
## HTTP-запрос {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}:createExternalDictionary
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера ClickHouse, для которого следует создать внешний словарь. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-clickhouse/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "externalDictionary": {
    "name": "string",
    "structure": {
      "id": {
        "name": "string"
      },
      "key": {
        "attributes": [
          {
            "name": "string",
            "type": "string",
            "nullValue": "string",
            "expression": "string",
            "hierarchical": true,
            "injective": true
          }
        ]
      },
      "rangeMin": {
        "name": "string",
        "type": "string",
        "nullValue": "string",
        "expression": "string",
        "hierarchical": true,
        "injective": true
      },
      "rangeMax": {
        "name": "string",
        "type": "string",
        "nullValue": "string",
        "expression": "string",
        "hierarchical": true,
        "injective": true
      },
      "attributes": [
        {
          "name": "string",
          "type": "string",
          "nullValue": "string",
          "expression": "string",
          "hierarchical": true,
          "injective": true
        }
      ]
    },
    "layout": {
      "type": "string",
      "sizeInCells": "string"
    },

    // `externalDictionary` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
    "fixedLifetime": "string",
    "lifetimeRange": {
      "min": "string",
      "max": "string"
    },
    // конец списка возможных полей`externalDictionary`

    "httpSource": {
      "url": "string",
      "format": "string"
    },
    "mysqlSource": {
      "db": "string",
      "table": "string",
      "port": "string",
      "user": "string",
      "password": "string",
      "replicas": [
        {
          "host": "string",
          "priority": "string",
          "port": "string",
          "user": "string",
          "password": "string"
        }
      ],
      "where": "string",
      "invalidateQuery": "string"
    },
    "clickhouseSource": {
      "db": "string",
      "table": "string",
      "host": "string",
      "port": "string",
      "user": "string",
      "password": "string",
      "where": "string"
    },
    "mongodbSource": {
      "db": "string",
      "collection": "string",
      "host": "string",
      "port": "string",
      "user": "string",
      "password": "string"
    },
    "postgresqlSource": {
      "db": "string",
      "table": "string",
      "hosts": [
        "string"
      ],
      "port": "string",
      "user": "string",
      "password": "string",
      "invalidateQuery": "string",
      "sslMode": "string"
    }
  }
}
```

 
Поле | Описание
--- | ---
externalDictionary | **object**<br><p>Конфигурация внешнего словаря.</p> 
externalDictionary.<br>name | **string**<br><p>Обязательное поле. Имя внешнего словаря.</p> 
externalDictionary.<br>structure | **object**<br>Обязательное поле. Набор атрибутов внешнего словаря. Подробное описание см. в [документации ClickHouse](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_structure/).<br>
externalDictionary.<br>structure.<br>id | **object**<br><p>Один столбец с числовыми ключами для словаря.</p> <p>Числовой ключ.</p> 
externalDictionary.<br>structure.<br>id.<br>name | **string**<br><p>Обязательное поле. Имя числового ключа.</p> 
externalDictionary.<br>structure.<br>key | **object**<br><p>Составной ключ для словаря, содержащего один или несколько столбцов с ключами. Подробнее см. в <a href="https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_structure/#composite-key">документации ClickHouse</a>.</p> <p>Составной ключ.</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[] | **object**<br><p>Обязательное поле. Поля составного ключа.</p> <p>Должен содержать хотя бы один элемент.</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[].<br>name | **string**<br><p>Обязательное поле. Имя столбца.</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[].<br>type | **string**<br><p>Обязательное поле. Тип столбца.</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[].<br>nullValue | **string**<br><p>Значение по умолчанию для элемента без данных (например, пустая строка).</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[].<br>expression | **string**<br><p>Выражение, описывающее атрибут, если применимо.</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Признак поддержки иерархии. Значение по умолчанию &quot;false&quot;.</p> 
externalDictionary.<br>structure.<br>key.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Признакт инъективного отображения &quot;id -&gt; атрибут&quot;. Значение по умолчанию &quot;false&quot;.</p> 
externalDictionary.<br>structure.<br>rangeMin | **object**<br><p>Поле, содержащее начало диапазона для словарей, которые хранятся в памяти способом &quot;RANGE_HASHED&quot;. Подробнее см.<a href="https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_layout/#range-hashed">документации ClickHouse</a></p> 
externalDictionary.<br>structure.<br>rangeMin.<br>name | **string**<br><p>Обязательное поле. Имя столбца.</p> 
externalDictionary.<br>structure.<br>rangeMin.<br>type | **string**<br><p>Обязательное поле. Тип столбца.</p> 
externalDictionary.<br>structure.<br>rangeMin.<br>nullValue | **string**<br><p>Значение по умолчанию для элемента без данных (например, пустая строка).</p> 
externalDictionary.<br>structure.<br>rangeMin.<br>expression | **string**<br><p>Выражение, описывающее атрибут, если применимо.</p> 
externalDictionary.<br>structure.<br>rangeMin.<br>hierarchical | **boolean** (boolean)<br><p>Признак поддержки иерархии. Значение по умолчанию &quot;false&quot;.</p> 
externalDictionary.<br>structure.<br>rangeMin.<br>injective | **boolean** (boolean)<br><p>Признакт инъективного отображения &quot;id -&gt; атрибут&quot;. Значение по умолчанию &quot;false&quot;.</p> 
externalDictionary.<br>structure.<br>rangeMax | **object**<br><p>Поле, содержащее конец диапазона для словарей, которые хранятся в памяти способом &quot;RANGE_HASHED&quot;. Подробнее см.<a href="https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_layout/#range-hashed">документации ClickHouse</a></p> 
externalDictionary.<br>structure.<br>rangeMax.<br>name | **string**<br><p>Обязательное поле. Имя столбца.</p> 
externalDictionary.<br>structure.<br>rangeMax.<br>type | **string**<br><p>Обязательное поле. Тип столбца.</p> 
externalDictionary.<br>structure.<br>rangeMax.<br>nullValue | **string**<br><p>Значение по умолчанию для элемента без данных (например, пустая строка).</p> 
externalDictionary.<br>structure.<br>rangeMax.<br>expression | **string**<br><p>Выражение, описывающее атрибут, если применимо.</p> 
externalDictionary.<br>structure.<br>rangeMax.<br>hierarchical | **boolean** (boolean)<br><p>Признак поддержки иерархии. Значение по умолчанию &quot;false&quot;.</p> 
externalDictionary.<br>structure.<br>rangeMax.<br>injective | **boolean** (boolean)<br><p>Признакт инъективного отображения &quot;id -&gt; атрибут&quot;. Значение по умолчанию &quot;false&quot;.</p> 
externalDictionary.<br>structure.<br>attributes[] | **object**<br><p>Обязательное поле. Описание полей, доступных для запросов к базе данных. Подробнее см. в <a href="https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_structure/#attributes">документации ClickHouse</a>.</p> <p>Должен содержать хотя бы один элемент.</p> 
externalDictionary.<br>structure.<br>attributes[].<br>name | **string**<br><p>Обязательное поле. Имя столбца.</p> 
externalDictionary.<br>structure.<br>attributes[].<br>type | **string**<br><p>Обязательное поле. Тип столбца.</p> 
externalDictionary.<br>structure.<br>attributes[].<br>nullValue | **string**<br><p>Значение по умолчанию для элемента без данных (например, пустая строка).</p> 
externalDictionary.<br>structure.<br>attributes[].<br>expression | **string**<br><p>Выражение, описывающее атрибут, если применимо.</p> 
externalDictionary.<br>structure.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Признак поддержки иерархии. Значение по умолчанию &quot;false&quot;.</p> 
externalDictionary.<br>structure.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Признакт инъективного отображения &quot;id -&gt; атрибут&quot;. Значение по умолчанию &quot;false&quot;.</p> 
externalDictionary.<br>layout | **object**<br>Обязательное поле. Макет для хранения словаря в памяти. Подробное описание см. в [документации ClickHouse](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_layout/).<br><p>Макет, определяющий способ хранения словаря в памяти.</p> 
externalDictionary.<br>layout.<br>type | **string**<br><p>Обязательное поле. Тип макета для внешнего словаря.</p> <ul> <li>FLAT: Весь словарь хранится в памяти в виде плоских массивов. Доступно для любых источников словарей.</li> <li>HASHED: Весь словарь хранится в памяти в виде хэш-таблицы. Доступно для любых источников словарей.</li> <li>COMPLEX_KEY_HASHED: Аналогичен HASHED, для использования с составными ключами. Доступно для любых источников словарей.</li> <li>RANGE_HASHED: Весь словарь хранится в памяти в виде хэш-таблицы, с упорядоченным массивом диапазонов и соответствующих им значений. Доступно для любых источников словарей.</li> <li>CACHE: Словарь хранится в кэше с заданным количеством ячеек. Доступно для источников словарей MySQL, ClickHouse и HTTP.</li> <li>COMPLEX_KEY_CACHE: Аналогичен CACHE, для использования с составными ключами. Доступно для источников словарей MySQL, ClickHouse и HTTP.</li> </ul> 
externalDictionary.<br>layout.<br>sizeInCells | **string** (int64)<br><p>Количество ячеек в кэше. Округляется до степени двойки. Применимо только для типов макета CACHE и COMPLEX_KEY_CACHE.</p> 
externalDictionary.<br>fixedLifetime | **string** (int64) <br>`externalDictionary` включает только одно из полей `fixedLifetime`, `lifetimeRange`<br><br><p>Жесткий интервал между обновлениями словаря.</p> 
externalDictionary.<br>lifetimeRange | **object**<br>Диапазон интервалов между обновлениями словаря, из которых может выбирать ClickHouse. <br>`externalDictionary` включает только одно из полей `fixedLifetime`, `lifetimeRange`<br><br>
externalDictionary.<br>lifetimeRange.<br>min | **string** (int64)<br><p>Минимальное время жизни словаря.</p> 
externalDictionary.<br>lifetimeRange.<br>max | **string** (int64)<br><p>Максимальное время жизни словаря.</p> 
externalDictionary.<br>httpSource | **object**<br>HTTP-источник для словаря. <br>`externalDictionary` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
externalDictionary.<br>httpSource.<br>url | **string**<br><p>Обязательное поле. URL внешнего словаря, доступного по HTTP.</p> 
externalDictionary.<br>httpSource.<br>format | **string**<br><p>Обязательное поле. Формат данных. Допустимые значения: все форматы, поддерживаемые диалектом ClickHouse SQL.</p> 
externalDictionary.<br>mysqlSource | **object**<br>MySQL-источник для словаря. <br>`externalDictionary` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
externalDictionary.<br>mysqlSource.<br>db | **string**<br><p>Обязательное поле. Имя базы данных MySQL, к которой нужно подключаться.</p> 
externalDictionary.<br>mysqlSource.<br>table | **string**<br><p>Обязательное поле. Имя таблицы базы данных, которую следует использовать в качестве словаря ClickHouse.</p> 
externalDictionary.<br>mysqlSource.<br>port | **string** (int64)<br><p>Порт по умолчанию, который нужно использовать при подключении к реплике источника словаря.</p> <p>Допустимые значения — от 0 до 65535 включительно.</p> 
externalDictionary.<br>mysqlSource.<br>user | **string**<br><p>Имя пользователя по умолчанию для реплик источника словаря.</p> 
externalDictionary.<br>mysqlSource.<br>password | **string**<br><p>Пароль пользователя по умолчанию для реплик источника словаря.</p> 
externalDictionary.<br>mysqlSource.<br>replicas[] | **object**<br><p>Обязательное поле. Список реплик базы данных MySQL, используемой в качестве источника словаря.</p> <p>Должен содержать хотя бы один элемент.</p> 
externalDictionary.<br>mysqlSource.<br>replicas[].<br>host | **string**<br><p>Обязательное поле. Хост реплики MySQL.</p> <p>Максимальная длина строки в символах — 253.</p> 
externalDictionary.<br>mysqlSource.<br>replicas[].<br>priority | **string** (int64)<br><p>Обязательное поле. Приоритет реплики, который ClickHouse должен учитывать при подключении. Реплике с наивысшим приоритетом должно соответствовать наименьшее значение в этом поле.</p> <p>Значение должно быть больше 0.</p> 
externalDictionary.<br>mysqlSource.<br>replicas[].<br>port | **string** (int64)<br><p>Порт, который нужно использовать при подключении к реплике. Если для какой-либо реплики не указан порт, ClickHouse использует порт, указанный для источника.</p> <p>Допустимые значения — от 0 до 65535 включительно.</p> 
externalDictionary.<br>mysqlSource.<br>replicas[].<br>user | **string**<br><p>Имя пользователя базы данных MySQL.</p> 
externalDictionary.<br>mysqlSource.<br>replicas[].<br>password | **string**<br><p>Пароль пользователя базы данных MySQL.</p> 
externalDictionary.<br>mysqlSource.<br>where | **string**<br><p>Критерии выбора данных в указанной таблице MySQL.</p> 
externalDictionary.<br>mysqlSource.<br>invalidateQuery | **string**<br><p>Запрос на проверку состояния словаря, который позволит извлекать только обновленные данные. Дополнительные сведения см. в <a href="https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_lifetime/">документации ClickHouse on dictionaries</a>.</p> 
externalDictionary.<br>clickhouseSource | **object**<br>ClickHouse-источник для словаря. <br>`externalDictionary` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
externalDictionary.<br>clickhouseSource.<br>db | **string**<br><p>Обязательное поле. Имя базы данных ClickHouse.</p> 
externalDictionary.<br>clickhouseSource.<br>table | **string**<br><p>Обязательное поле. Имя таблицы в указанной базе данных, используемой в качестве источника словаря.</p> 
externalDictionary.<br>clickhouseSource.<br>host | **string**<br><p>Обязательное поле. Хост ClickHouse для указанной базы данных.</p> <p>Максимальная длина строки в символах — 253.</p> 
externalDictionary.<br>clickhouseSource.<br>port | **string** (int64)<br><p>Порт для подключения к хосту.</p> <p>Допустимые значения — от 0 до 65535 включительно.</p> 
externalDictionary.<br>clickhouseSource.<br>user | **string**<br><p>Обязательное поле. Имя пользователя базы данных ClickHouse.</p> 
externalDictionary.<br>clickhouseSource.<br>password | **string**<br><p>Пароль пользователя базы данных ClickHouse.</p> 
externalDictionary.<br>clickhouseSource.<br>where | **string**<br><p>Критерии выбора данных в указанной таблице ClickHouse.</p> 
externalDictionary.<br>mongodbSource | **object**<br>MongoDB-источник для словаря. <br>`externalDictionary` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
externalDictionary.<br>mongodbSource.<br>db | **string**<br><p>Обязательное поле. Имя базы данных MongoDB.</p> 
externalDictionary.<br>mongodbSource.<br>collection | **string**<br><p>Обязательное поле. Имя коллекции в указанной базе данных, которую следует использовать в качестве источника словаря.</p> 
externalDictionary.<br>mongodbSource.<br>host | **string**<br><p>Обязательное поле. Хост MongoDB для указанной базы данных.</p> <p>Максимальная длина строки в символах — 253.</p> 
externalDictionary.<br>mongodbSource.<br>port | **string** (int64)<br><p>Порт для подключения к хосту.</p> <p>Допустимые значения — от 0 до 65535 включительно.</p> 
externalDictionary.<br>mongodbSource.<br>user | **string**<br><p>Обязательное поле. Имя пользователя базы данных MongoDB.</p> 
externalDictionary.<br>mongodbSource.<br>password | **string**<br><p>Пароль пользователя базы данных MongoDB.</p> 
externalDictionary.<br>postgresqlSource | **object**<br>PostgreSQL-источник для словаря. <br>`externalDictionary` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
externalDictionary.<br>postgresqlSource.<br>db | **string**<br><p>Обязательное поле. Имя базы данных PostrgreSQL.</p> 
externalDictionary.<br>postgresqlSource.<br>table | **string**<br><p>Обязательное поле. Имя таблицы в указанной базе данных, используемой в качестве источника словаря.</p> 
externalDictionary.<br>postgresqlSource.<br>hosts[] | **string**<br><p>Обязательное поле. Имя хоста PostrgreSQL.</p> <p>Должен содержать хотя бы один элемент.</p> 
externalDictionary.<br>postgresqlSource.<br>port | **string** (int64)<br><p>Порт для подключения к хосту.</p> <p>Допустимые значения — от 0 до 65535 включительно.</p> 
externalDictionary.<br>postgresqlSource.<br>user | **string**<br><p>Обязательное поле. Имя пользователя базы данных PostrgreSQL.</p> 
externalDictionary.<br>postgresqlSource.<br>password | **string**<br><p>Пароль пользователя базы данных PostrgreSQL.</p> 
externalDictionary.<br>postgresqlSource.<br>invalidateQuery | **string**<br><p>Запрос на проверку состояния словаря, который позволит извлекать только обновленные данные. Дополнительные сведения см. в <a href="https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_lifetime/">документации ClickHouse on dictionaries</a>.</p> 
externalDictionary.<br>postgresqlSource.<br>sslMode | **string**<br><p>Режим SSL TCP/IP соединения с хостом PostgreSQL. Дополнительные сведения см. в <a href="https://www.postgresql.org/docs/current/libpq-ssl.html">PostgreSQL documentation</a>.</p> <ul> <li>DISABLE: SSL-соединение не используется.</li> <li>ALLOW: Сначала предпринимается попытка установить незашифрованное соединение. Если это не удается, устанавливается SSL-соединение.</li> <li>PREFER: Сначала предпринимается попытка установить SSL-соединение. Если это не удается, устанавливается незашифрованное соединение.</li> <li>VERIFY_CA: Устанавливается только SSL-соединение и только при условии, что сертификат выдан доверенным центром сертификации (CA).</li> <li>VERIFY_FULL: Устанавливается только SSL-соединение и только при условии, что сертификат выдан доверенным центром сертификации и что имя хоста сервера совпадает с указанным в сертификате.</li> </ul> 
 
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
done | **boolean** (boolean)<br><p>Если значение равно ``false`` — операция еще выполняется. Если ``true`` — операция завершена, и задано значение одного из полей ``error`` или ``response``.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``metadata``.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``response``.</p> 