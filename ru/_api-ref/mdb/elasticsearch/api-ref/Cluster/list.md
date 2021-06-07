---
editable: false
---

# Метод list
Получает список кластеров Elasticsearch, принадлежащих указанному каталогу.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-elasticsearch/v1/clusters
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, для которого нужно получить список кластеров Elasticsearch.  Чтобы получить идентификатор каталога, выполните запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/managed-elasticsearch/api-ref/Cluster/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/managed-elasticsearch/api-ref/Cluster/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Выражение, позволяющее отфильтровать информацию о ресурсах в ответе, оставив только нужную.  В этом выражении должны быть указаны: 1. Имя поля, по которому нужно выполнить фильтрацию. В настоящее время фильтрацию можно использовать только по полю [Cluster.name](/docs/managed-elasticsearch/api-ref/Cluster#representation). 2. Условный оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. 3. Значение. Должно содержать от 1 до 63 символов и соответствовать регулярному выражению `^[a-zA-Z0-9_-]+$`.  Пример фильтра: `name NOT IN 'test,beta'`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clusters": [
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
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
clusters[] | **object**<br><p>Кластер Elasticsearch. Подробнее читайте в разделе <a href="/docs/managed-elasticsearch/concepts">Концепции</a> документации.</p> 
clusters[].<br>id | **string**<br><p>Идентификатор кластера Elasticsearch. Этот идентификатор генерируется при создании кластера.</p> 
clusters[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер Elasticsearch.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
clusters[].<br>name | **string**<br><p>Имя кластера Elasticsearch. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов.</p> 
clusters[].<br>description | **string**<br><p>Описание кластера Elasticsearch. Длина описания должна быть от 0 до 256 символов.</p> 
clusters[].<br>labels | **object**<br><p>Пользовательские метки для кластера Elasticsearch в виде пар ``key:value``. Максимум 64 на ресурс.</p> 
clusters[].<br>environment | **string**<br><p>Среда развертывания кластера Elasticsearch.</p> <ul> <li>PRODUCTION: стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Метаданные системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Ссылка на графики системы мониторинга для кластера Elasticsearch.</p> 
clusters[].<br>config | **object**<br><p>Конфигурация кластера Elasticsearch.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Версия Elasticsearch.</p> 
clusters[].<br>config.<br>elasticsearch | **object**<br><p>Конфигурация и распределение ресурсов для узлов Elasticsearch.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode | **object**<br><p>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Data node.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>resources | **object**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Data node.<br>
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т.д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-elasticsearch/concepts/instance-types">документации</a>.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Все доступные типы перечислены в <a href="/docs/managed-elasticsearch/concepts/storage">документации</a>.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6 | **object**<br>Конфигурация Elasticsearch 7.6 для узла с ролью Data node.<br><p>Конфигурация Elasticsearch 7.6 для узла с ролью Data node.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>effectiveConfig | **object**<br><p>Обязательное поле. Действующие настройки для кластера Elasticsearch (сочетание параметров, определенных в ``userConfig`` и ``defaultConfig``).</p> <p>Здесь перечислены поддерживаемые параметры конфигурации Elasticsearch 7.6.</p> <p>Подробное описание всех параметров доступно в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html">документации Elasticsearch</a>.</p> <p>Любые параметры, не перечисленные здесь, не поддерживаются.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>effectiveConfig.<br>fielddataCacheSize | **integer** (int64)<br><p>Максимальный процент от общего объема кучи (heap), который может выделяться под кэш данных в полях.</p> <p>Все значения полей, помещенные в этот кэш, загружаются в память для обеспечения быстрого доступа к этим значениям при работе с документами. Построение кэша данных для поля — затратная операция, поэтому рекомендуется иметь достаточный объем памяти для этого кэша и поддерживать его в заполненном состоянии.</p> <p>Значение по умолчанию: не ограничено.</p> <p>См. подробное описание в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-fielddata.html">документации Elasticsearch</a>.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>effectiveConfig.<br>maxClauseCount | **integer** (int64)<br><p>Максимальное число выражений, которое может содержаться в булевом запросе (bool query).</p> <p>Эта настройка позволяет не допустить разрастания поисковых запросов до больших размеров, чтобы запросы не потребляли много памяти и ресурсов процессора. Настройка влияет не только на запросы типа ``bool``, но и на многие другие запросы, которые неявно преобразуются Elasticsearch в запросы типа ``bool``.</p> <p>Значение по умолчанию: ``1024``.</p> <p>См. подробное описание в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/search-settings.html">документации Elasticsearch</a>.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера Elasticsearch.</p> <p>Здесь перечислены поддерживаемые параметры конфигурации Elasticsearch 7.6.</p> <p>Подробное описание всех параметров доступно в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html">документации Elasticsearch</a>.</p> <p>Любые параметры, не перечисленные здесь, не поддерживаются.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>userConfig.<br>fielddataCacheSize | **integer** (int64)<br><p>Максимальный процент от общего объема кучи (heap), который может выделяться под кэш данных в полях.</p> <p>Все значения полей, помещенные в этот кэш, загружаются в память для обеспечения быстрого доступа к этим значениям при работе с документами. Построение кэша данных для поля — затратная операция, поэтому рекомендуется иметь достаточный объем памяти для этого кэша и поддерживать его в заполненном состоянии.</p> <p>Значение по умолчанию: не ограничено.</p> <p>См. подробное описание в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-fielddata.html">документации Elasticsearch</a>.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>userConfig.<br>maxClauseCount | **integer** (int64)<br><p>Максимальное число выражений, которое может содержаться в булевом запросе (bool query).</p> <p>Эта настройка позволяет не допустить разрастания поисковых запросов до больших размеров, чтобы запросы не потребляли много памяти и ресурсов процессора. Настройка влияет не только на запросы типа ``bool``, но и на многие другие запросы, которые неявно преобразуются Elasticsearch в запросы типа ``bool``.</p> <p>Значение по умолчанию: ``1024``.</p> <p>См. подробное описание в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/search-settings.html">документации Elasticsearch</a>.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>defaultConfig | **object**<br><p>Настройки по умолчанию для кластера Elasticsearch.</p> <p>Здесь перечислены поддерживаемые параметры конфигурации Elasticsearch 7.6.</p> <p>Подробное описание всех параметров доступно в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html">документации Elasticsearch</a>.</p> <p>Любые параметры, не перечисленные здесь, не поддерживаются.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>defaultConfig.<br>fielddataCacheSize | **integer** (int64)<br><p>Максимальный процент от общего объема кучи (heap), который может выделяться под кэш данных в полях.</p> <p>Все значения полей, помещенные в этот кэш, загружаются в память для обеспечения быстрого доступа к этим значениям при работе с документами. Построение кэша данных для поля — затратная операция, поэтому рекомендуется иметь достаточный объем памяти для этого кэша и поддерживать его в заполненном состоянии.</p> <p>Значение по умолчанию: не ограничено.</p> <p>См. подробное описание в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-fielddata.html">документации Elasticsearch</a>.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>defaultConfig.<br>maxClauseCount | **integer** (int64)<br><p>Максимальное число выражений, которое может содержаться в булевом запросе (bool query).</p> <p>Эта настройка позволяет не допустить разрастания поисковых запросов до больших размеров, чтобы запросы не потребляли много памяти и ресурсов процессора. Настройка влияет не только на запросы типа ``bool``, но и на многие другие запросы, которые неявно преобразуются Elasticsearch в запросы типа ``bool``.</p> <p>Значение по умолчанию: ``1024``.</p> <p>См. подробное описание в <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/search-settings.html">документации Elasticsearch</a>.</p> 
clusters[].<br>config.<br>elasticsearch.<br>masterNode | **object**<br><p>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Master node.</p> 
clusters[].<br>config.<br>elasticsearch.<br>masterNode.<br>resources | **object**<br><p>Ресурсы, выделенные узлам Elasticsearch с ролью Master node.</p> 
clusters[].<br>config.<br>elasticsearch.<br>masterNode.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т.д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-elasticsearch/concepts/instance-types">документации</a>.</p> 
clusters[].<br>config.<br>elasticsearch.<br>masterNode.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
clusters[].<br>config.<br>elasticsearch.<br>masterNode.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Все доступные типы перечислены в <a href="/docs/managed-elasticsearch/concepts/storage">документации</a>.</p> 
clusters[].<br>networkId | **string**<br><p>Идентификатор сети, к которой принадлежит кластер.</p> 
clusters[].<br>health | **string**<br><p>Здоровье кластера.</p> <ul> <li>HEALTH_UNKNOWN: состояние кластера неизвестно (``health`` всех хостов в кластере — ``UNKNOWN``).</li> <li>ALIVE: кластер работает нормально (``health`` всех хостов в кластере — ``ALIVE``).</li> <li>DEAD: кластер не работает (``health`` всех хостов в кластере — ``DEAD``).</li> <li>DEGRADED: кластер находится в состоянии деградации (``health`` по крайней мере одного из хостов в кластере — не ``ALIVE``).</li> </ul> 
clusters[].<br>status | **string**<br><p>Текущее состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: состояние кластера неизвестно.</li> <li>CREATING: кластер создается.</li> <li>RUNNING: кластер работает нормально.</li> <li>ERROR: в кластере произошла ошибка, блокирующая работу.</li> <li>UPDATING: кластер изменяется.</li> <li>STOPPING: кластер останавливается.</li> <li>STOPPED: кластер остановлен.</li> <li>STARTING: кластер запускается.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе.</p> <p>Если количество результатов больше чем <a href="/docs/managed-elasticsearch/api-ref/Cluster/list#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/managed-elasticsearch/api-ref/Cluster/list#query_params">pageToken</a> в следующем запросе. Все последующие запросы будут получать свои значения ``next_page_token`` для перебора страниц результатов.</p> 