# Поля ресурса YCStorageBucket

Ресурс `YCStorageBucket` содержит параметры бакета {{ objstorage-name }} для настройки бэкенда в ресурсе `HTTPRoute`.

## YCStorageBucket {#yc-storage-bucket}

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: YCStorageBucket
metadata:
  name: <string>
  namespace: <string>
spec: <YCStorageBucketSpec>
```

Где:

* `apiVersion`: `gwin.yandex.cloud/v1`
* `kind`: `YCStorageBucket`
* `metadata` (`ObjectMeta`, обязательное)

  Метаданные ресурса.

  * `name` (`string`, обязательное)

    Имя ресурса. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

  * `namespace` (`string`)

    [Пространство имен](../../../managed-kubernetes/concepts/index.md#namespace), к которому относится ресурс. Значение по умолчанию — `default`.

* `spec` (`YCStorageBucketSpec`, обязательное)

  Спецификация ресурса. Подробнее см. [ниже](#spec).

## YCStorageBucketSpec {#spec}

```yaml
bucketRef:
  bucketName: <string>
```

Где:

* `bucketRef` (обязательное)

  Параметры бакета {{ objstorage-name }}.

  * `bucketName` (`string`)
  
    Имя бакета.
