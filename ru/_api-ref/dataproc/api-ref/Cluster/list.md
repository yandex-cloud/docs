---
editable: false
---

# Метод list
Возвращает список кластеров в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, для которого нужно получить список кластеров.  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/data-proc/api-ref/Cluster/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/data-proc/api-ref/Cluster/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации кластеров в ответе.  В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Cluster.name](/docs/data-proc/api-ref/Cluster#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Пример фильтра: `name=my-cluster`.  Максимальная длина строки в символах — 1000.
 
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
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "config": {
        "versionId": "string",
        "hadoop": {
          "services": [
            "string"
          ],
          "properties": "object",
          "sshPublicKeys": [
            "string"
          ]
        }
      },
      "health": "string",
      "status": "string",
      "zoneId": "string",
      "serviceAccountId": "string",
      "bucket": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
clusters[] | **object**<br><p>Кластер Data Proc. Дополнительные сведения о концепции см. в <a href="/docs/data-proc/concepts/">документации</a>.</p> 
clusters[].<br>id | **string**<br><p>Идентификатор кластера. Генерируется во время создания.</p> 
clusters[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
clusters[].<br>name | **string**<br><p>Имя кластера. Имя уникально в рамках каталога.</p> <p>Длина строки в символах должна быть от 1 до 63.</p> 
clusters[].<br>description | **string**<br><p>Описание кластера.</p> <p>Длина строки в символах должна быть от 0 до 256.</p> 
clusters[].<br>labels | **object**<br><p>Метки кластера как пары ``key:value``.</p> <p>Не более 64 на ресурс.</p> 
clusters[].<br>monitoring[] | **object**<br><p>Метаданные системы мониторинга для кластера Data Proc.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Ссылка на систему мониторинга.</p> 
clusters[].<br>config | **object**<br><p>Конфигурация кластера.</p> 
clusters[].<br>config.<br>versionId | **string**<br><p>Версия образа, которая используется при подготовке кластера. Все доступные версии перечислены в <a href="/docs/managed-hadoop/concepts/image-versions">документации</a>.</p> 
clusters[].<br>config.<br>hadoop | **object**<br><p>Настройки конфигурации, специфические для Data Proc.</p> <p>Конфигурация Hadoop, описывающая компоненты, установленные в кластере, их свойства и параметры.</p> 
clusters[].<br>config.<br>hadoop.<br>services[] | **string**<br><p>Набор компонентов, используемых в кластере (если список пуст, используется набор по умолчанию).</p> 
clusters[].<br>config.<br>hadoop.<br>properties | **object**<br><p>Свойства, установленные для всех хостов в конфигурациях ``*-site.xml``. В ключе должны быть указаны компонент и свойство.</p> <p>Например, используйте ключ 'hdfs:dfs.replication', чтобы установить свойство ``dfs.replication`` в файле ``/etc/hadoop/conf/hdfs-site.xml``.</p> 
clusters[].<br>config.<br>hadoop.<br>sshPublicKeys[] | **string**<br><p>Список публичных ключей SSH для доступа к хостам кластера.</p> 
clusters[].<br>health | **string**<br><p>Агрегированная работоспособность кластера.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно (``health`` для каждого хоста в кластере — UNKNOWN).</li> <li>ALIVE: Кластер работает нормально (``health`` для каждого хоста в кластере — ALIVE).</li> <li>DEAD: Кластер не работает (``health`` для каждого хоста в кластере — DEAD).</li> <li>DEGRADED: Кластер работает неоптимально (``health`` по крайней мере для одного хоста в кластере не ALIVE).</li> </ul> 
clusters[].<br>status | **string**<br><p>Состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно.</li> <li>CREATING: Кластер создается.</li> <li>RUNNING: Кластер работает нормально.</li> <li>ERROR: На кластере произошла ошибка, блокирующая работу.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 
clusters[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится кластер.</p> 
clusters[].<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, которым пользуется агент Data Proc для управления задачами.</p> 
clusters[].<br>bucket | **string**<br><p>Имя бакета Object Storage, который используется для задач Data Proc.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем <a href="/docs/data-proc/api-ref/Cluster/list#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/data-proc/api-ref/Cluster/list#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>У каждой последующей страницы будет собственный ``next_page_token``, чтобы можно было продолжать просматривать результаты.</p> 