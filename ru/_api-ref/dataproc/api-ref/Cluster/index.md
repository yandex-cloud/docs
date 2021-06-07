---
editable: false
---

# Cluster
Набор методов для управления кластерами Data Proc.
## JSON-представление {#representation}
```json 
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
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор кластера. Генерируется во время создания.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя кластера. Имя уникально в рамках каталога.</p> <p>Длина строки в символах должна быть от 1 до 63.</p> 
description | **string**<br><p>Описание кластера.</p> <p>Длина строки в символах должна быть от 0 до 256.</p> 
labels | **object**<br><p>Метки кластера как пары ``key:value``.</p> <p>Не более 64 на ресурс.</p> 
monitoring[] | **object**<br><p>Метаданные системы мониторинга для кластера Data Proc.</p> 
monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
monitoring[].<br>link | **string**<br><p>Ссылка на систему мониторинга.</p> 
config | **object**<br><p>Конфигурация кластера.</p> 
config.<br>versionId | **string**<br><p>Версия образа, которая используется при подготовке кластера. Все доступные версии перечислены в <a href="/docs/managed-hadoop/concepts/image-versions">документации</a>.</p> 
config.<br>hadoop | **object**<br><p>Настройки конфигурации, специфические для Data Proc.</p> <p>Конфигурация Hadoop, описывающая компоненты, установленные в кластере, их свойства и параметры.</p> 
config.<br>hadoop.<br>services[] | **string**<br><p>Набор компонентов, используемых в кластере (если список пуст, используется набор по умолчанию).</p> 
config.<br>hadoop.<br>properties | **object**<br><p>Свойства, установленные для всех хостов в конфигурациях ``*-site.xml``. В ключе должны быть указаны компонент и свойство.</p> <p>Например, используйте ключ 'hdfs:dfs.replication', чтобы установить свойство ``dfs.replication`` в файле ``/etc/hadoop/conf/hdfs-site.xml``.</p> 
config.<br>hadoop.<br>sshPublicKeys[] | **string**<br><p>Список публичных ключей SSH для доступа к хостам кластера.</p> 
health | **string**<br><p>Агрегированная работоспособность кластера.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно (``health`` для каждого хоста в кластере — UNKNOWN).</li> <li>ALIVE: Кластер работает нормально (``health`` для каждого хоста в кластере — ALIVE).</li> <li>DEAD: Кластер не работает (``health`` для каждого хоста в кластере — DEAD).</li> <li>DEGRADED: Кластер работает неоптимально (``health`` по крайней мере для одного хоста в кластере не ALIVE).</li> </ul> 
status | **string**<br><p>Состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно.</li> <li>CREATING: Кластер создается.</li> <li>RUNNING: Кластер работает нормально.</li> <li>ERROR: На кластере произошла ошибка, блокирующая работу.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 
zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится кластер.</p> 
serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, которым пользуется агент Data Proc для управления задачами.</p> 
bucket | **string**<br><p>Имя бакета Object Storage, который используется для задач Data Proc.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает кластер в указанном каталоге.
[delete](delete.md) | Удаляет указанный кластер.
[get](get.md) | Возвращает указанный кластер Data Proc.
[list](list.md) | Возвращает список кластеров в указанном каталоге.
[listHosts](listHosts.md) | Получает список хостов для указанного кластера.
[listOperations](listOperations.md) | Список операций для указанного кластера.
[start](start.md) | Запускает указанный кластер.
[stop](stop.md) | Останавливает указанный кластер.
[update](update.md) | Обновляет конфигурацию указанного кластера.