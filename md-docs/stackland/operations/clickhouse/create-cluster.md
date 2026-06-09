# Создать кластер {{ mch-name }}

Если у вас есть [проект](../projects/create-project.md), вы можете создать в нем кластер [{{ CH }}](../../concepts/components/clickhouse.md).

## Через CLI {#cli}

1. Если проект еще не создан, то создайте его: `kubectl create namespace <название проекта>`.
1. Создайте файл ресурса `ClickhouseCluster`. Например, с помощью команды `touch clickhousecluster.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    {% list tabs %}

    - Минимальная конфигурация

        ```yaml
        apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
        kind: ClickhouseCluster
        metadata:
          labels:
            app.kubernetes.io/name: ch-stackland-operator
            app.kubernetes.io/managed-by: kustomize
          name: ch-sample-min
        spec:
          clickhouse:
            service: ClusterIP # тип сервиса для всего кластера (None, ClusterIP или LoadBalancer). По умолчанию ClusterIP
            shards:
              - id: shard-1
                # service: None # тип сервиса для шарда (None, ClusterIP или LoadBalancer). По умолчанию None (не создается)
            storage:
              size: 1Gi
            resources:
              requests:
                cpu: "500m"
                memory: "1Gi"
              limits:
                cpu: "1"
                memory: "2Gi"
          keeper:
            storage:
              size: 1Gi
        ```

    - Конфигурация с резервным копированием (stackland-storage)

        Вариант с явным указанием типа хранилища `spec.backup.storage.type: stackland-storage` — бакет и ключи доступа создаёт оператор. Создайте только секрет суперпользователя. Подставьте при необходимости расписание в `spec.backup.schedule` ([CRON Expression Format](https://pkg.go.dev/github.com/robfig/cron#hdr-CRON_Expression_Format)) и заполните секцию `spec.backup.retention` для ограничения количества и времени хранения резервных копий в S3.

        ```yaml
        apiVersion: v1
        kind: Secret
        metadata:
          name: ch-sample-superuser
        type: Opaque
        stringData:
          password: "your_password"
          username: "your_username"
        ---
        apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
        kind: ClickhouseCluster
        metadata:
          labels:
            app.kubernetes.io/name: ch-stackland-operator
            app.kubernetes.io/managed-by: kustomize
          name: ch-sample-full
        spec:
          clickhouse:
            version: "25.3"
            service: ClusterIP # тип сервиса для всего кластера (None, ClusterIP или LoadBalancer)
            shards:
              - id: "shard-1"
                weight: 1
                service: LoadBalancer # тип сервиса для шарда (None, ClusterIP или LoadBalancer)
                settings:
                instances: 2
                storage:
        #          storageClass: "your-storage-class"
                  size: 2Gi
                resources:
                  requests:
                    cpu: "500m"
                    memory: "1Gi"
                  limits:
                    cpu: "1"
                    memory: "2Gi"
              - id: "shard-2"
                weight: 2
                service: None # эндпоинт для этого шарда не создается
                settings:
                instances: 1
                storage:
        #          storageClass: "your-storage-class"
                  size: 2Gi
                resources:
                  requests:
                    cpu: "500m"
                    memory: "1Gi"
                  limits:
                    cpu: "1"
                    memory: "2Gi"
            storage:
        #      storageClass: "your-storage-class"
              size: 2Gi
            resources:
              requests:
                cpu: "500m"
                memory: "1Gi"
              limits:
                cpu: "1"
                memory: "2Gi"
            enableSuperuserAccess: true
            superuserSecretRef:
              name: "ch-sample-superuser"
          keeper:
            instances: 3
            storage:
        #      storageClass: "your-storage-classs"
              size: 1Gi
            resources:
              requests:
                cpu: "500m"
                memory: "1Gi"
              limits:
                cpu: "1"
                memory: "2Gi"
          backup:
            storage:
              type: stackland-storage
            # schedule: "0 0 * * * *"
            retention:
              ignoreForManualBackups: true
              minBackupsToKeep: 5
              deleteBackupsAfter: 7d
        
        ```

    - Резервное копирование в S3 (type: s3)

        Вариант с явным указанием типа хранилища `spec.backup.storage.type: s3` — для произвольного S3-совместимого бакета. Создайте секрет с учётными данными доступа к бакету и секрет суперпользователя. Подставьте в пример имя бакета, endpoint и при необходимости расписание в `spec.backup.schedule` и заполните секцию `spec.backup.retention` для ограничения количества и времени хранения резервных копий в S3.

        ```yaml
        apiVersion: v1
        kind: Secret
        metadata:
          name: ch-sample-s3-credentials
        type: Opaque
        stringData:
          accessKey: "your_key"
          secret: "your_secret"
        ---
        apiVersion: v1
        kind: Secret
        metadata:
          name: ch-sample-superuser
        type: Opaque
        stringData:
          password: "your_password"
          username: "your_username"
        ---
        apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
        kind: ClickhouseCluster
        metadata:
          labels:
            app.kubernetes.io/name: ch-stackland-operator
            app.kubernetes.io/managed-by: kustomize
          name: ch-sample-full-s3
        spec:
          clickhouse:
            version: "25.3"
            service: ClusterIP # тип сервиса для всего кластера (None, ClusterIP или LoadBalancer)
            shards:
              - id: "shard-1"
                weight: 1
                service: LoadBalancer # тип сервиса для шарда (None, ClusterIP или LoadBalancer)
                settings:
                instances: 2
                storage:
        #          storageClass: "your-storage-class"
                  size: 2Gi
                resources:
                  requests:
                    cpu: "500m"
                    memory: "1Gi"
                  limits:
                    cpu: "1"
                    memory: "2Gi"
              - id: "shard-2"
                weight: 2
                service: None # эндпоинт для этого шарда не создается
                settings:
                instances: 1
                storage:
        #          storageClass: "your-storage-class"
                  size: 2Gi
                resources:
                  requests:
                    cpu: "500m"
                    memory: "1Gi"
                  limits:
                    cpu: "1"
                    memory: "2Gi"
            storage:
        #      storageClass: "your-storage-class"
              size: 2Gi
            resources:
              requests:
                cpu: "500m"
                memory: "1Gi"
              limits:
                cpu: "1"
                memory: "2Gi"
            enableSuperuserAccess: true
            superuserSecretRef:
              name: "ch-sample-superuser"
          keeper:
            instances: 3
            storage:
        #      storageClass: "your-storage-class"
              size: 1Gi
            resources:
              requests:
                cpu: "500m"
                memory: "1Gi"
              limits:
                cpu: "1"
                memory: "2Gi"
          backup:
            storage:
              s3:
                bucket: on-prem-quantum
                endpointUrl: "https://storage.yandexcloud.net"
                backupsToKeepRemote: 14
                region: "ru-central1"
                forcePathStyle: false
        #        storageClass: "STANDARD"
                credentialsSecretRef:
                  name: ch-sample-s3-credentials
                  accessKeyIdPath: accessKey
                  secretAccessKeyPath: secret
            # schedule: "0 0 * * * *"
            deltaMaxSteps: 5
        ```

    {% endlist %}

1. Примените манифест: `kubectl apply -f clickhousecluster.yaml -n <название проекта>`. При необходимости можно прописать название проекта в параметр ресурса `metadata.namespace` и не использовать в команде.

## Через консоль управления {#console}

1. Если вы еще не открыли проект, выберите проект.
1. В левом меню выберите **{{ CH }} Clusters**.
1. Нажмите **Создать**.
1. Заполните поля:

    **Основные параметры**

    * **Имя кластера** — название кластера. Только строчные буквы, цифры и дефисы.
    * **Версия** — версия {{ CH }}. Выберите из списка доступных версий.
    * **Тип сервиса кластера** — тип сервиса для доступа ко всему кластеру. Доступные значения: `ClusterIP` (доступ только внутри кластера, по умолчанию) или `LoadBalancer` (доступ извне).

    **Хранилище**

    * **Класс хранилища** — Storage Class (`stackland-nvme`, `stackland-ssd`, `stackland-hdd`, `stackland-other`). Подробнее о Storage Classes см. в разделе [Дисковая подсистема](../../concepts/components/disk-storage.md#storage-classes).
    * **Размер хранилища** — размер диска для хранения данных. После создания размер диска можно только увеличить.

    **Настройки** (раскрывающийся раздел)

    **Ресурсы**

    * **Запрошенный CPU** — гарантированное количество вычислительных ресурсов.
    * **Запрошенная память** — гарантированный объем оперативной памяти.
    * **Лимит CPU** — максимальное количество вычислительных ресурсов.
    * **Лимит памяти** — максимальный объем оперативной памяти.

    **Шарды**

    Список шардов кластера. По умолчанию создается один шард `shard-1`. Вы можете добавить дополнительные шарды, нажав **Добавить шард**.

    Для каждого шарда можно настроить:

    * **ID шарда** — идентификатор шарда.
    * **Вес шарда** — вес шарда для распределения данных.
    * **Количество реплик** — количество реплик в шарде.
    * **Тип сервиса шарда** — тип сервиса для доступа к шарду. Доступные значения: `Не создавать сервис` (эндпоинт не создается, по умолчанию), `ClusterIP` (доступ только внутри кластера) или `LoadBalancer` (доступ извне).

    **Суперпользователь**

    * **Разрешить доступ** — переключатель для включения создания суперпользователя.
    * **Имя** — имя суперпользователя для доступа к базе данных.
    * **Пароль** — пароль суперпользователя. Можно сгенерировать автоматически, нажав **Сгенерировать**.

    **{{ CH }} Keeper**

    * **Количество инстансов Keeper** — количество экземпляров {{ CH }} Keeper для обеспечения отказоустойчивости.
    * **Класс хоста Keeper** — конфигурация ресурсов для инстансов Keeper (хранилище, CPU, память).

    **Конфигурация резервного копирования**

    * **Включить автоматические бэкапы** — переключатель для включения автоматического резервного копирования в S3-бакет.

1. Нажмите **Создать**.

Готово, кластер появился в списке **{{ CH }} Clusters**.

## Подключение к кластеру {#connect}

Для подключения к кластеру используйте FQDN хоста в формате `<название_кластера>.<название_проекта>.svc.{{ cluster-domain }}`.

### clickhouse-client {#clickhouse-client}

Установите клиент:

```bash
sudo apt update && sudo apt install --yes clickhouse-client
```

Подключитесь к кластеру:

```bash
clickhouse-client --host <название_кластера>.<название_проекта>.svc.{{ cluster-domain }} \
                  --user <имя_пользователя> \
                  --database <имя_БД> \
                  --port 9000 \
                  --ask-password
```

### HTTP-интерфейс {#http}

Выполните запрос через HTTP:

```bash
curl --header "X-{{ CH }}-User: <имя_пользователя>" \
     --header "X-{{ CH }}-Key: <пароль>" \
     'http://<название_кластера>.<название_проекта>.svc.{{ cluster-domain }}:8123/?database=<имя_БД>&query=SELECT%20version()'
```

{% note info %}

Для первого подключения используйте базу данных `clickhouse` и имя суперпользователя, указанное при создании кластера.

{% endnote %}

## Получение адресов для подключения {#get-connection-addresses}

После создания кластера вы можете получить адреса (FQDN) для подключения к кластеру и отдельным шардам.

### Получение FQDN через CLI {#get-fqdn-cli}

Выполните команду:

```bash
kubectl get clickhousecluster <название_кластера> -n <название_проекта> -o jsonpath='{.status.clusterStatus.fqdns}'
```

Результат содержит:

* `cluster.internal` — внутренний FQDN для подключения ко всему кластеру из других подов в Kubernetes.
* `cluster.external` — внешний FQDN для подключения к кластеру извне (доступен только если `spec.clickhouse.service` установлен в `LoadBalancer`).
* `shards[].serviceFqdn.internal` — внутренний FQDN для подключения к конкретному шарду.
* `shards[].serviceFqdn.external` — внешний FQDN для подключения к шарду извне (доступен только если `spec.clickhouse.shards[].service` установлен в `LoadBalancer`).

Пример результата:

```json
{
  "cluster": {
    "internal": "ch-sample.my-project.svc.example.com",
    "external": "ch-sample.svc.example.com"
  },
  "shards": [
    {
      "id": "shard-1",
      "serviceFqdn": {
        "internal": "ch-sample-shard-1.my-project.svc.example.com",
        "external": "ch-sample-shard-1.svc.example.com"
      }
    }
  ]
}
```

### Получение FQDN через консоль управления {#get-fqdn-console}

1. Откройте проект.
1. В левом меню выберите **{{ CH }} Clusters**.
1. Выберите кластер.
1. На вкладке **Обзор** в разделах **Обзор кластера** и **Шард <имя шарда> отображаются адреса для подключения.

{% note info %}

Внутренние FQDN имеют формат `<название_ресурса>.<название_проекта>.svc.{{ cluster-domain }}` и доступны только внутри кластера Kubernetes.

Внешние FQDN создаются автоматически для сервисов типа `LoadBalancer` и доступны извне кластера. Подробнее о DNS см. в разделе [DNS](../../concepts/components/dns.md).

{% endnote %}