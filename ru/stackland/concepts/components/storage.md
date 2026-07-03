# Object Storage

{{ objstorage-name }} — S3-совместимое объектное хранилище на базе {{ objstorage-full-name }}. Хранилище можно использовать для данных любого формата. Взаимодействовать с ним можно с помощью инструментов, поддерживающих S3 API.

## Основные возможности {#features}

* Хранение неструктурированных данных любого объема.
* Совместимость с S3 API — работа с любыми инструментами и SDK, поддерживающими протокол S3.
* Управление бакетами через Kubernetes CRD `Bucket`.
* Гибкая настройка публичного доступа к объектам.
* Поддержка CORS для веб-приложений.
* Интеграция с {{ iam-name }} для управления доступом.

## Ресурсная модель {#resource-model}

### Bucket {#bucket}

Бакет — контейнер для хранения объектов. Создавайте бакеты с помощью инструкции [Создать бакет](../../operations/storage/create-bucket.md).

Пример манифеста:

```yaml
apiVersion: storage.stackland.yandex.cloud/v1alpha1
kind: Bucket
metadata:
  name: my-bucket
  namespace: my-project
spec:
  anonymousAccessFlags:
    read: true
    list: false
  cors:
    - allowedOrigins:
        - "https://example.com"
      allowedMethods:
        - "GET"
        - "PUT"
      allowedHeaders:
        - "*"
      maxAgeSeconds: 3600
```

Где:

* `metadata.name` — имя бакета. Должно быть уникальным в рамках всего хранилища. Допускаются строчные буквы латинского алфавита, цифры и дефисы.
* `metadata.namespace` — проект, в котором создается бакет.
* `spec.anonymousAccessFlags` — настройки публичного доступа к бакету:
  * `read` — разрешает анонимным пользователям читать объекты в бакете.
  * `list` — разрешает анонимным пользователям получать список объектов в бакете.
  * `configRead` — разрешает анонимным пользователям читать конфигурацию бакета (CORS, lifecycle, website).
* `spec.cors` — правила CORS для кросс-доменных запросов:
  * `allowedOrigins` — список разрешенных источников запросов.
  * `allowedMethods` — список разрешенных HTTP-методов.
  * `allowedHeaders` — список разрешенных заголовков в preflight-запросах.
  * `exposeHeaders` — список заголовков, доступных браузеру в ответе.
  * `maxAgeSeconds` — время кэширования preflight-ответа в секундах.

### Статус бакета {#bucket-status}

После создания бакета его статус отображается в поле `status.phase`:

* `Pending` — бакет ожидает создания.
* `Creating` — бакет создается.
* `Ready` — бакет готов к использованию.
* `Updating` — бакет обновляется.
* `Deleting` — бакет удаляется.
* `Failed` — произошла ошибка.

## Управление доступом {#access-management}

Доступ к {{ objstorage-name }} управляется через {{ iam-name }}. Для работы с бакетами приложениям необходимы:

1. Сервисный аккаунт — создайте ServiceAccount в проекте.
1. Роль — назначьте сервисному аккаунту роль `storage.editor` или `storage.viewer` с помощью ресурса `AccessBinding`.
1. Статический ключ — получите ключ доступа для работы с S3 API.

Подробнее о создании ключей доступа см. в инструкции [Создать ключ доступа](../../operations/storage/create-accesskey.md).

### Пример назначения роли {#access-example}

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: AccessBinding
metadata:
  name: app-storage-access
  namespace: my-project
spec:
  roleID: storage.editor
  subject:
    kind: ServiceAccount
    name: my-app-sa
    namespace: my-project
```

## Подключение к хранилищу {#connection}

Для подключения к {{ objstorage-name }} используйте следующие параметры:

* Endpoint: `storage.sys.{{ cluster-domain }}`.
* Access Key ID: получите из секрета сервисного аккаунта.
* Secret Access Key: получите из секрета сервисного аккаунта.

Пример настройки AWS CLI:

```bash
aws configure set aws_access_key_id <access-key-id>
aws configure set aws_secret_access_key <secret-access-key>
aws configure set default.region ru-central1
aws --endpoint-url=https://storage.sys.<cluster-domain> s3 ls
```
