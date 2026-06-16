# Переключить компонент на другой класс хранилища

При развёртывании {{ stackland-name }} назначает класс хранилища по умолчанию — тот, который указан в `StacklandClusterConfig.spec.storage.defaultStorageClass`. Этот класс получает аннотацию `storageclass.kubernetes.io/is-default-class: "true"` и используется для всех PVC, в которых класс хранилища не задан явно.

Для баз данных обычно предпочтительнее SSD или NVMe, а для объектного хранилища — HDD. Если компоненту нужен класс хранилища, отличный от указанного при установке, пропишите его явно в конфигурации этого компонента.

{% note warning %}

Данные при смене класса хранилища не переносятся автоматически.

Смена класса хранилища приводит к пересозданию PVC и потере данных. Выполняйте операцию до записи пользовательских данных — в идеале при первоначальном развёртывании.

{% endnote %}

## Перед началом работы {#before-you-begin}

1. Убедитесь, что нужный класс хранилища существует в кластере:

   ```bash
   kubectl get storageclasses
   ```

1. Убедитесь, что на узлах есть диски соответствующего типа:

   ```bash
   kubectl get volumegroups -A -o wide
   ```

Подробнее о доступных классах хранилища в разделе [Дисковая подсистема](../../concepts/components/disk-storage.md#storage-classes).

## Смена класса хранилища по умолчанию {#change-default}

Вы можете указать класс хранилища по умолчанию как всем, так и отдельным компонентам.

### Смена класса хранилища для всех компонентов {#change-all}

Класс хранилища по умолчанию определяется аннотацией `storageclass.kubernetes.io/is-default-class: "true"` у ресурса `StorageClass`. Вы можете переместить эту аннотацию на другой класс хранилища. После этого все новые PVC, в которых класс хранилища не указан явно, будут использовать новый класс по умолчанию.

Чтобы сменить класс хранилища по умолчанию:

1. Снимите аннотацию с текущего класса по умолчанию:

   ```bash
   kubectl annotate storageclass <текущий_класс> storageclass.kubernetes.io/is-default-class-
   ```

1. Установите аннотацию на новый класс:

   ```bash
   kubectl annotate storageclass <новый_класс> storageclass.kubernetes.io/is-default-class=true
   ```

{% note warning %}

Смена класса по умолчанию влияет только на новые PVC. Существующие PVC сохраняют прежний класс хранилища.

{% endnote %}

### Смена класса хранилища для отдельного компонента {#change-component}

Чтобы изменить класс хранилища для конкретного платформенного компонента, укажите соответствующее поле в конфигурации компонента.

#### Управляемые БД {#postgresql-platform}

{{ PG }}, {{ CH }} и {{ KF }} не требуют настройки класса хранилища на уровне компонента. Кластеры используют класс хранилища по умолчанию. Чтобы задать класс хранилища, отличный от класса по умолчанию, укажите его в манифесте при создании кластера.

#### {{ objstorage-name }} {#object-storage-platform}

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: StorageConfig
metadata:
  name: main
spec:
  enabled: false
  settings:
    storage:
      diskType: HDD
      servers: 3
      size: 154Gi
      storageClass: "stackland-hdd"
```

## Смена класса хранилища для пользовательских кластеров БД {#user-clusters}

Кластеры баз данных используют класс хранилища по умолчанию, если атрибут `storageClass` не указан в спецификации кластера. Чтобы задать класс хранилища для конкретного кластера, укажите его в манифесте при создании.

Для уже созданных кластеров {{ PG }}, {{ CH }} и {{ KF }} нельзя сменить класс хранилища.

### {{ PG }} {#postgresql}

Укажите поле `spec.storage.storageClass` в ресурсе `PostgresqlCluster`:

```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlCluster
metadata:
  name: <имя_кластера>
spec:
  storage:
    size: 10Gi
    storageClass: "stackland-ssd"
  # ...
```

Подробнее о создании кластера в разделе [Создать кластер PostgreSQL](../postgresql/create-cluster.md).

### {{ CH }} {#clickhouse}

Укажите поля `spec.clickhouse.storage.storageClass` и `spec.keeper.storage.storageClass` в ресурсе `ClickhouseCluster`:

```yaml
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseCluster
metadata:
  name: <имя_кластера>
spec:
  clickhouse:
    storage:
      size: 10Gi
      storageClass: "stackland-ssd"
    # ...
  keeper:
    storage:
      size: 5Gi
      storageClass: "stackland-ssd"
```

Подробнее о создании кластера в разделе [Создать кластер {{ mch-name }}](../clickhouse/create-cluster.md).

### {{ KF }} {#kafka}

Укажите поля `spec.controller.storage.storageClass` и `spec.broker.storage.storageClass` в ресурсе `KafkaCluster`:

```yaml
apiVersion: kafka.stackland.yandex.cloud/v1alpha1
kind: KafkaCluster
metadata:
  name: <имя_кластера>
spec:
  controller:
    storage:
      size: 5Gi
      storageClass: "stackland-ssd"
  broker:
    storage:
      size: 20Gi
      storageClass: "stackland-ssd"
  # ...
```

Подробнее о создании кластера в разделе [Создать кластер](../kafka/create-cluster.md).

## Переключение класса хранилища для системных компонентов {#system-components}

Для системных компонентов укажите нужный класс хранилища в конфигурационном файле компонента. Если компонент уже запущен, следуйте процедуре из раздела [Смена класса хранилища для существующего компонента с данными](#existing-component).

### Logging (Loki) {#logging}

Укажите поле `spec.settings.logStorage.storage.storageClass` в ресурсе `LoggingConfig`:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: LoggingConfig
metadata:
  name: main
spec:
  enabled: true
  settings:
    logStorage:
      storage:
        enabled: true
        storageClass: "stackland-hdd"
        size: 50Gi
```

### Secrets Store (OpenBao) {#secrets-store}

Укажите поле `spec.settings.server.dataStorage.storageClass` в ресурсе `SecretsStoreConfig`:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: SecretsStoreConfig
metadata:
  name: main
spec:
  enabled: true
  settings:
    server:
      dataStorage:
        size: 2Gi
        storageClass: "stackland-ssd"
```

### {{ datalens-name }} {#datalens}

Укажите поле `spec.settings.database.storageClass` в ресурсе `DataLensConfig`:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: DataLensConfig
metadata:
  name: main
spec:
  enabled: true
  settings:
    database:
      storageSize: "2Gi"
      storageClass: "stackland-ssd"
```

#### {{ objstorage-name }} {#object-storage-platform}

Укажите поле `spec.settings.storage.storageClass` в ресурсе `StorageConfig`:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: StorageConfig
metadata:
  name: main
spec:
  enabled: false
  settings:
    storage:
      diskType: HDD
      servers: 3
      size: 154Gi
      storageClass: "stackland-hdd"
```

## Смена класса хранилища для существующего компонента с данными {#existing-component}

Смена класса хранилища требует отключения и повторной активации компонента.

{% note alert %}

Операция приводит к полной потере данных на затронутых PVC. Убедитесь, что у вас есть резервная копия, из которой можно восстановить данные.

{% endnote %}

Чтобы сменить класс хранилища для уже запущенного компонента:

1. Создайте резервную копию данных.

1. Отключите компонент. Для системных компонентов установите `spec.enabled: false` и примените манифест:

   ```bash
   kubectl apply -f <файл_конфигурации>.yaml
   ```

   Для пользовательских кластеров БД удалите ресурс кластера:

   ```bash
   kubectl delete <тип_ресурса> <имя_кластера> -n <название_проекта>
   ```

1. Удалите PVC компонента:

   ```bash
   kubectl delete pvc <имя_pvc> -n <namespace>
   ```

   Чтобы получить список PVC компонента:

   ```bash
   kubectl get pvc -n <namespace>
   ```

1. В манифесте укажите новый класс хранилища и включите компонент обратно (`spec.enabled: true`).

1. Примените манифест:

   ```bash
   kubectl apply -f <файл_конфигурации>.yaml
   ```

1. Восстановите данные из резервной копии.
