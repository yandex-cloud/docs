[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > Концепции > [Компоненты](overview.md) > Managed Service for Trino

# Managed Service for Trino

Managed Service for Trino — это управляемый сервис для работы с распределенным SQL-движком Trino. Сервис упрощает развертывание и обновление кластеров Trino, обеспечивает декларативное управление каталогами источников данных и интеграцию с Identity and Access Management.

С помощью Managed Service for Trino можно:

* создавать кластеры с помощью кастомного ресурса `TrinoCluster`;
* подключать к кластеру источники данных с помощью кастомного ресурса `TrinoCatalog`;
* настраивать правила доступа к каталогам, схемам, таблицам, функциям, процедурам и запросам;
* управлять версиями образов Trino с помощью кастомного ресурса `TrinoImageCatalog`.

## Архитектура кластера {#architecture}

Кластер Trino состоит из двух типов узлов:

* **Координатор** — единственный узел, который принимает SQL-запросы, планирует их выполнение и распределяет задачи между воркерами. Координатор также отдает Trino UI и API.
* **Воркеры** — узлы, которые выполняют части SQL-запросов и возвращают результаты координатору. Количество воркеров можно изменять вручную через параметр `spec.worker.replicas`.

Изменение части параметров приводит к пересозданию кластера и прерыванию активных запросов. Подробнее см. в разделе [Обновление кластера](#cluster-update).

## Создание кластера {#configuration}

Пример минимальной конфигурации кластера:

```yaml
apiVersion: trino.stackland.yandex.cloud/v1alpha1
kind: TrinoCluster
metadata:
  name: trino-min
spec:
  version: "483"
  coordinator:
    resources:
      requests:
        cpu: 500m
        memory: 1Gi
      limits:
        cpu: "1"
        memory: 2Gi
  worker:
    replicas: 1
    resources:
      requests:
        cpu: 500m
        memory: 1Gi
      limits:
        cpu: "1"
        memory: 2Gi
```

Где:

* `version` — версия Trino. Допустимые значения берутся из ресурса `TrinoImageCatalog`, установленного оператором.
* `coordinator.resources` — запросы и лимиты CPU и памяти для пода координатора.
* `worker.replicas` — количество воркеров в кластере (минимум `1`).
* `worker.resources` — запросы и лимиты CPU и памяти для пода воркера.

Дополнительно в `spec` можно задать:

* `config` — дополнительные настройки Trino в формате «ключ–значение». Набор допустимых ключей и значений задаётся валидационной схемой для версии Trino кластера; оператор публикует схемы в ConfigMap `trino-omdb-operator-<версия>` в своём пространстве имён, где можно посмотреть актуальный список. Например, ключ `io.trino` задаёт уровень логирования (значения `DEBUG`, `INFO`, `WARN`, `ERROR`). Ключ или значение вне схемы валидация отклонит при создании или обновлении кластера.
* `accessControl` — правила доступа к ресурсам Trino. См. раздел [Управление доступом](#access-control).
* `deletionProtection` — защита кластера от случайного удаления. См. раздел [Защита от удаления](#deletion-protection).

## Обновление кластера {#cluster-update}

При изменении части параметров Managed Service for Trino пересоздает кластер: на время применения новой конфигурации кластер переходит в состояние `Updating`, а активные запросы прерываются.

Пересоздание кластера происходит при изменении следующих параметров ресурса `TrinoCluster`:

* `spec.version`;
* `spec.coordinator.resources`;
* `spec.worker.resources`;
* `spec.config`;
* любых параметров связанных ресурсов `TrinoCatalog`.

Без пересоздания кластера применяются изменения следующих параметров:

* `spec.worker.replicas`;
* `spec.accessControl`.

## Каталоги {#catalogs}

Каталог в Trino — это конфигурация подключения к источнику данных. Managed Service for Trino управляет каталогами через кастомный ресурс `TrinoCatalog`. Один ресурс описывает один каталог и привязан к конкретному кластеру через поле `spec.cluster`.

Поддерживаемые типы коннекторов:

* PostgreSQL — параметры подключения задаются в `spec.postgres`.
* ClickHouse® — параметры подключения задаются в `spec.clickhouse`.
* Apache Iceberg™ — подключение к [Iceberg REST Catalog](rest-catalog.md) в Stackland задается в `spec.stacklandRestCatalog`.

В манифесте укажите один блок с настройками коннектора. Отдельный параметр `spec.type` не используется.

Для PostgreSQL и ClickHouse® учетные данные и сертификаты хранятся в Kubernetes Secrets, на которые ссылаются поля `credentialsSecretRef` и `certificateSecretRef`.

Для Apache Iceberg™ укажите имя существующего ресурса `StacklandRestCatalog` в параметре `spec.stacklandRestCatalog.catalogRef`. Каталог должен находиться в том же пространстве имен, что и `TrinoCatalog` и кластер Trino. Параметры подключения и доступа к хранилищу настраиваются автоматически. Пример приведен в инструкции [Создать каталог Managed Service for Trino](../../operations/trino/create-catalog.md).

При изменении любого каталога Managed Service for Trino пересоздает кластер. На время применения новой конфигурации кластер переходит в состояние `Updating`, активные запросы прерываются. Подробнее см. в разделе [Обновление кластера](#cluster-update).

### Хранилище данных для Iceberg {#iceberg-storage}

Файлы данных Apache Iceberg™ хранятся в [Object Storage](storage.md). Бакет создается автоматически вместе с каталогом Iceberg REST Catalog. При подключении каталога к Trino указывать бакет, адрес хранилища и ключи доступа не требуется.

### Аутентификация в REST Catalog {#iceberg-auth}

При работе с каталогом используются права пользователя или сервисного аккаунта, от имени которого выполняются запросы в Trino. [Назначьте ему роль](../../operations/rest-catalog/create-principal.md) на каталог или нужные ресурсы каталога. Также должны быть разрешены соответствующие операции в [правилах доступа Trino](#access-control).

Токен IAM передается в Trino через auth-proxy в дополнительном параметре `iam-token` и используется при обращении к REST Catalog. Создавать отдельного пользователя каталога и указывать учетные данные OAuth2 в `TrinoCatalog` не требуется.

Для сервисного аккаунта в `spec.accessControl` указывайте имя ресурса `ServiceAccount` в Kubernetes, а не идентификатор субъекта IAM.

### Дополнительные настройки Iceberg {#iceberg-settings}

В блоке `spec.stacklandRestCatalog.additionalProperties` ресурса `TrinoCatalog` можно настроить хранение данных и выполнение запросов для каталога Apache Iceberg™. Все параметры этого блока необязательны.

#|
|| Задача | Параметры ||
|| Выбрать формат и сжатие данных | `iceberg.file-format` — формат файлов по умолчанию для новых таблиц: `PARQUET`, `ORC` или `AVRO`. `iceberg.compression-codec` — способ сжатия по умолчанию при записи: `NONE`, `SNAPPY`, `LZ4`, `ZSTD` или `GZIP`. ||
|| Настроить размер файлов | `iceberg.target-max-file-size` — целевой максимальный размер записываемых файлов, например `512MB`. Фактический размер может быть больше. ||
|| Требовать фильтр по партициям | `iceberg.query-partition-filter-required: true` требует фильтр по ключам партиционирования в запросах к партиционированным таблицам. В `iceberg.query-partition-filter-required-schemas` укажите SQL-схемы, для которых действует требование, одной строкой через запятую, например `reports,events`. ||
|| Использовать статистику таблиц | `iceberg.table-statistics-enabled` — использование статистики для выбора плана запроса. `iceberg.extended-statistics.collect-on-write` — сбор расширенной статистики при записи данных. ||
|| Кешировать метаданные | `iceberg.metadata-cache.enabled` — кеширование метаданных таблиц, которое сокращает количество повторных обращений к хранилищу. ||
|| Ограничить очистку таблиц | `iceberg.expire-snapshots.min-retention` и `iceberg.remove-orphan-files.min-retention` — минимально допустимые значения `retention_threshold` для команд `expire_snapshots` и `remove_orphan_files` соответственно, например `7d`. Команды удаляют старые снимки таблиц и неиспользуемые файлы. Очистку нужно запускать отдельно. ||
|| Ограничить число соединений с хранилищем | `s3.max-connections` — максимальное число соединений с Object Storage, целое число не меньше `1`. ||
|| Настроить тайм-ауты хранилища | `s3.socket-connect-timeout` — время ожидания установки соединения; `s3.socket-timeout` — время ожидания операции чтения или записи. Например, `10s` и `30s` соответственно. ||
|| Настроить повторные попытки | `s3.max-error-retries` — максимальное число повторных попыток при ошибках обращения к хранилищу, целое число не меньше `1`. ||
|| Работать с представлениями | `iceberg.rest-catalog.view-endpoints-enabled: true` включает в REST Catalog поддержку создания и чтения представлений Iceberg. Без этого параметра создание представлений завершится ошибкой. Подробнее — в разделе [Представления Iceberg](#iceberg-views). ||
|#

### Представления Iceberg {#iceberg-views}

Для создания и чтения представлений Iceberg через Iceberg REST Catalog выполните два условия:

1. В `spec.stacklandRestCatalog.additionalProperties` укажите `iceberg.rest-catalog.view-endpoints-enabled: true`.
1. В команде `CREATE VIEW` добавьте `SECURITY INVOKER`.

При работе с Iceberg REST Catalog права проверяются для пользователя или сервисного аккаунта, от имени которого выполняется запрос. С `SECURITY INVOKER` при чтении представления Trino обращается к базовым таблицам с IAM-токеном вызывающего пользователя. Если `SECURITY INVOKER` не указан, используется режим `SECURITY DEFINER`: проверка прав выполняется от имени владельца представления, что несовместимо с моделью доступа Iceberg REST Catalog.

Пример:

```sql
CREATE VIEW analytics.events_summary
SECURITY INVOKER
AS
SELECT id, name FROM analytics.events;
```

Поведение параметров описано в документации Trino: [настройки Iceberg](https://trino.io/docs/current/connector/iceberg.html#general-configuration) и [работа с S3](https://trino.io/docs/current/object-storage/file-system-s3.html#general-configuration).

Указывайте имена параметров целиком, включая точки. Логические значения `true` и `false` и числа записывайте без кавычек. Размеры и интервалы времени задавайте строками с единицей измерения: например, `"512MB"`, `"30s"` или `"7d"`.

Названия параметров и допустимые значения проверяются для выбранной версии Trino. Если параметр не поддерживается или значение имеет неверный тип, создать или изменить каталог не получится.

Пример манифеста с дополнительными настройками приведен в инструкции [Создать каталог Managed Service for Trino](../../operations/trino/create-catalog.md#cli).

## Управление доступом {#access-control}

Параметр `spec.accessControl` ресурса `TrinoCluster` задает правила доступа к ресурсам Trino. Правила разделены по типу ресурса:

* `catalogs` — доступ к каталогам. Привилегии: `all`, `read-only`, `none`.
* `schemas` — доступ к схемам. Поле `owner` определяет, является ли пользователь владельцем схемы.
* `tables` — доступ к таблицам и отдельным столбцам. Привилегии: `SELECT`, `INSERT`, `DELETE`, `UPDATE`, `OWNERSHIP`, `GRANT_SELECT`. Можно задать фильтр по строкам и маски для столбцов.
* `functions` — доступ к функциям. Привилегии: `EXECUTE`, `GRANT_EXECUTE`, `OWNERSHIP`.
* `procedures` — доступ к процедурам. Привилегии: `EXECUTE`, `GRANT_EXECUTE`.
* `queries` — управление запросами. Привилегии: `execute`, `view`, `kill`. Если задано поле `queryOwner`, привилегию `execute` использовать нельзя.

Поля сопоставления (`user`, `catalog`, `schema`, `table`, `function`, `procedure`, `queryOwner`) задаются как регулярные выражения. Если поле не задано, Trino подставляет `.*` (правило распространяется на все значения).

Для запросов от сервисного аккаунта в поле `user` указывайте имя ресурса `ServiceAccount` в Kubernetes, а не идентификатор субъекта IAM.

## Сетевой доступ к кластеру {#network-access}

После создания кластера адреса для подключения доступны в поле `status.fqdn` ресурса `TrinoCluster`:

```bash
kubectl get trinocluster <имя_кластера> -n <пространство_имен> -o jsonpath='{.status.fqdn}'
```

Структура ответа:

* `external` — FQDN координатора для подключения через клиенты Trino (CLI, JDBC).
* `webUI` — FQDN для доступа к Trino UI.

## Версии образов {#image-catalog}

Список доступных версий Trino определяется ресурсом `TrinoImageCatalog`. Оператор создает его автоматически при установке компонента. Версия, заданная в `spec.version` ресурса `TrinoCluster`, должна присутствовать в `TrinoImageCatalog` — иначе валидация отклонит создание или обновление кластера.

## Защита от удаления {#deletion-protection}

Параметр `spec.deletionProtection` в ресурсе `TrinoCluster` предотвращает случайное удаление кластера через API Kubernetes. При включенной защите (`spec.deletionProtection: true`) оператор отклоняет удаление ресурса; команда `kubectl delete` и удаление через консоль управления не выполнятся, пока защита не будет отключена.

* По умолчанию: `false` (защита выключена).
* Включение и отключение: задается в `spec.deletionProtection` при создании или при [редактировании кластера](../../operations/trino/edit-cluster.md).
* Ограничение: защита распространяется только на ресурс `TrinoCluster`. Созданные оператором ресурсы (Pod, Service, ConfigMap, Secret) защитой не охватываются.

## Состояния кластера {#states}

Текущее состояние кластера отображается в поле `status.phase` ресурса `TrinoCluster`. Допустимые значения:

* `Running` — кластер работает, все узлы готовы.
* `Updating` — оператор применяет новую конфигурацию (изменены воркеры, координатор или каталоги).
* `Warning` — кластер работает, но есть некритичные ошибки. Подробности — в `status.conditions`.
* `Failed` — кластер не запустился или потерял работоспособность. Причина — в `status.conditions` с `reason: NodesFailed`.
* `Deleting` — кластер удаляется.

Полный список условий реконсиляции доступен в `status.conditions`.