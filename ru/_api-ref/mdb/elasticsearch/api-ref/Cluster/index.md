---
editable: false
---

# Cluster
Набор методов для управления кластерами Elasticsearch.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "monitoring": [
    {
      "name": "string",
      "description": "string",
      "link": "string"
    }
  ],
  "config": {
    "version": "string",
    "elasticsearch": {
      "dataNode": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        },
        "elasticsearchConfigSet_7_6": {
          "effectiveConfig": {
            "fielddataCacheSize": "integer",
            "maxClauseCount": "integer"
          },
          "userConfig": {
            "fielddataCacheSize": "integer",
            "maxClauseCount": "integer"
          },
          "defaultConfig": {
            "fielddataCacheSize": "integer",
            "maxClauseCount": "integer"
          }
        }
      },
      "masterNode": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      }
    }
  },
  "networkId": "string",
  "health": "string",
  "status": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор кластера Elasticsearch. Этот идентификатор генерируется при создании кластера.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер Elasticsearch.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя кластера Elasticsearch. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов.</p> 
description | **string**<br><p>Описание кластера Elasticsearch. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Пользовательские метки для кластера Elasticsearch в виде пар `key:value`. Максимум 64 на ресурс.</p> 
environment | **string**<br><p>Среда развертывания кластера Elasticsearch.</p> <ul> <li>PRODUCTION: стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li> </ul> 
monitoring[] | **object**<br><p>Метаданные системы мониторинга.</p> 
monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
monitoring[].<br>link | **string**<br><p>Ссылка на графики системы мониторинга для кластера Elasticsearch.</p> 
config | **object**<br><p>Конфигурация кластера Elasticsearch.</p> 
config.<br>version | **string**<br><p>Версия Elasticsearch.</p> 
config.<br>elasticsearch | **object**<br><p>Конфигурация и распределение ресурсов для узлов Elasticsearch.</p> 
config.<br>elasticsearch.<br>dataNode | **object**<br><p>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Data node.</p> 
config.<br>elasticsearch.<br>dataNode.<br>resources | **object**<br>
config.<br>elasticsearch.<br>dataNode.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т.д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-elasticsearch/concepts/instance-types">документации</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>elasticsearch.<br>dataNode.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Все доступные типы перечислены в <a href="/docs/managed-elasticsearch/concepts/storage">документации</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6 | **object**<br><p>Конфигурация Elasticsearch 7.6 для узла с ролью Data node.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>effectiveConfig | **object**<br><p>Обязательное поле. Действующие настройки для кластера Elasticsearch (сочетание параметров, определенных в `userConfig` и `defaultConfig`).</p> <p>Здесь перечислены поддерживаемые параметры конфигурации Elasticsearch 7.6.</p> <p>Подробное описание всех параметров доступно в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html">документации Elasticsearch</a>.</p> <p>Любые параметры, не перечисленные здесь, не поддерживаются.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>effectiveConfig.<br>fielddataCacheSize | **integer** (int64)<br><p>Максимальный процент от общего объема кучи (heap), который может выделяться под кэш данных в полях.</p> <p>Все значения полей, помещенные в этот кэш, загружаются в память для обеспечения быстрого доступа к этим значениям при работе с документами. Построение кэша данных для поля — затратная операция, поэтому рекомендуется иметь достаточный объем памяти для этого кэша и поддерживать его в заполненном состоянии.</p> <p>Значение по умолчанию: не ограничено.</p> <p>См. подробное описание в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-fielddata.html">документации Elasticsearch</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>effectiveConfig.<br>maxClauseCount | **integer** (int64)<br><p>Максимальное число выражений, которое может содержаться в булевом запросе (bool query).</p> <p>Эта настройка позволяет не допустить разрастания поисковых запросов до больших размеров, чтобы запросы не потребляли много памяти и ресурсов процессора. Настройка влияет не только на запросы типа `bool`, но и на многие другие запросы, которые неявно преобразуются Elasticsearch в запросы типа `bool`.</p> <p>Значение по умолчанию: `1024`.</p> <p>См. подробное описание в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/search-settings.html">документации Elasticsearch</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера Elasticsearch.</p> <p>Здесь перечислены поддерживаемые параметры конфигурации Elasticsearch 7.6.</p> <p>Подробное описание всех параметров доступно в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html">документации Elasticsearch</a>.</p> <p>Любые параметры, не перечисленные здесь, не поддерживаются.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>userConfig.<br>fielddataCacheSize | **integer** (int64)<br><p>Максимальный процент от общего объема кучи (heap), который может выделяться под кэш данных в полях.</p> <p>Все значения полей, помещенные в этот кэш, загружаются в память для обеспечения быстрого доступа к этим значениям при работе с документами. Построение кэша данных для поля — затратная операция, поэтому рекомендуется иметь достаточный объем памяти для этого кэша и поддерживать его в заполненном состоянии.</p> <p>Значение по умолчанию: не ограничено.</p> <p>См. подробное описание в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-fielddata.html">документации Elasticsearch</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>userConfig.<br>maxClauseCount | **integer** (int64)<br><p>Максимальное число выражений, которое может содержаться в булевом запросе (bool query).</p> <p>Эта настройка позволяет не допустить разрастания поисковых запросов до больших размеров, чтобы запросы не потребляли много памяти и ресурсов процессора. Настройка влияет не только на запросы типа `bool`, но и на многие другие запросы, которые неявно преобразуются Elasticsearch в запросы типа `bool`.</p> <p>Значение по умолчанию: `1024`.</p> <p>См. подробное описание в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/search-settings.html">документации Elasticsearch</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>defaultConfig | **object**<br><p>Настройки по умолчанию для кластера Elasticsearch.</p> <p>Здесь перечислены поддерживаемые параметры конфигурации Elasticsearch 7.6.</p> <p>Подробное описание всех параметров доступно в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html">документации Elasticsearch</a>.</p> <p>Любые параметры, не перечисленные здесь, не поддерживаются.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>defaultConfig.<br>fielddataCacheSize | **integer** (int64)<br><p>Максимальный процент от общего объема кучи (heap), который может выделяться под кэш данных в полях.</p> <p>Все значения полей, помещенные в этот кэш, загружаются в память для обеспечения быстрого доступа к этим значениям при работе с документами. Построение кэша данных для поля — затратная операция, поэтому рекомендуется иметь достаточный объем памяти для этого кэша и поддерживать его в заполненном состоянии.</p> <p>Значение по умолчанию: не ограничено.</p> <p>См. подробное описание в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-fielddata.html">документации Elasticsearch</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>defaultConfig.<br>maxClauseCount | **integer** (int64)<br><p>Максимальное число выражений, которое может содержаться в булевом запросе (bool query).</p> <p>Эта настройка позволяет не допустить разрастания поисковых запросов до больших размеров, чтобы запросы не потребляли много памяти и ресурсов процессора. Настройка влияет не только на запросы типа `bool`, но и на многие другие запросы, которые неявно преобразуются Elasticsearch в запросы типа `bool`.</p> <p>Значение по умолчанию: `1024`.</p> <p>См. подробное описание в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/search-settings.html">документации Elasticsearch</a>.</p> 
config.<br>elasticsearch.<br>masterNode | **object**<br><p>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Master node.</p> 
config.<br>elasticsearch.<br>masterNode.<br>resources | **object**<br><p>Ресурсы, выделенные узлам Elasticsearch с ролью Master node.</p> 
config.<br>elasticsearch.<br>masterNode.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т.д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-elasticsearch/concepts/instance-types">документации</a>.</p> 
config.<br>elasticsearch.<br>masterNode.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>elasticsearch.<br>masterNode.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Все доступные типы перечислены в <a href="/docs/managed-elasticsearch/concepts/storage">документации</a>.</p> 
networkId | **string**<br><p>Идентификатор сети, к которой принадлежит кластер.</p> 
health | **string**<br><p>Здоровье кластера.</p> <ul> <li>HEALTH_UNKNOWN: состояние кластера неизвестно (`health` всех хостов в кластере — `UNKNOWN`).</li> <li>ALIVE: кластер работает нормально (`health` всех хостов в кластере — `ALIVE`).</li> <li>DEAD: кластер не работает (`health` всех хостов в кластере — `DEAD`).</li> <li>DEGRADED: кластер находится в состоянии деградации (`health` по крайней мере одного из хостов в кластере — не `ALIVE`).</li> </ul> 
status | **string**<br><p>Текущее состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: состояние кластера неизвестно.</li> <li>CREATING: кластер создается.</li> <li>RUNNING: кластер работает нормально.</li> <li>ERROR: в кластере произошла ошибка, блокирующая работу.</li> <li>UPDATING: кластер изменяется.</li> <li>STOPPING: кластер останавливается.</li> <li>STOPPED: кластер остановлен.</li> <li>STARTING: кластер запускается.</li> </ul> 

## Методы {#methods}
Метод | Описание
--- | ---
[addHosts](addHosts.md) | Добавляет новые хосты в указанный кластер Elasticsearch.
[create](create.md) | Создает новый кластер Elasticsearch в указанном каталоге.
[delete](delete.md) | Удаляет указанный кластер Elasticsearch.
[deleteHosts](deleteHosts.md) | Удаляет хосты из указанного кластера Elasticsearch.
[get](get.md) | Возвращает указанный кластер Elasticsearch.
[list](list.md) | Получает список кластеров Elasticsearch, принадлежащих указанному каталогу.
[listHosts](listHosts.md) | Получает список хостов для указанного кластера Elasticsearch.
[listLogs](listLogs.md) | Получает логи для указанного кластера Elasticsearch.
[listOperations](listOperations.md) | Получает список операций для указанного кластера Elasticsearch.
[move](move.md) | Перемещает кластер Elasticsearch в указанный каталог.
[start](start.md) | Запускает указанный кластер Elasticsearch.
[stop](stop.md) | Останавливает указанный кластер Elasticsearch.
[streamLogs](streamLogs.md) | То же самое, что [listLogs](/docs/managed-elasticsearch/api-ref/Cluster/listLogs), с той разницей, что со стороны сервера передается поток логов. Допускается использовать семантику `tail -f` при работе с потоком логов.
[update](update.md) | Изменяет указанный кластер Elasticsearch.