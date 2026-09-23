[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Бакеты > Создать бакет

# Создать бакет

Если у вас есть [проект](../projects/create-project.md), вы можете создать в нем [бакет](../../concepts/components/storage.md).

{% list tabs group=instructions %}

- CLI {#cli}

  1. Если проект еще не создан, создайте его:

      ```bash
      kubectl create namespace <название_проекта>
      ```

  1. Создайте файл ресурса `Bucket`:

      ```bash
      touch bucket.yaml
      ```

  1. Откройте файл и вставьте конфигурацию:

      {% list tabs %}

      - Бакет без публичного доступа

          apiVersion: storage.stackland.yandex.cloud/v1alpha1
          kind: Bucket
          metadata:
            name: app-data
          spec: {}

      - Бакет с публичным доступом

          apiVersion: storage.stackland.yandex.cloud/v1alpha1
          kind: Bucket
          metadata:
            name: app-data
          spec:
            anonymousAccessFlags:
              read: true
              list: false

          В этом случае объекты будут доступны для чтения без аутентификации по ссылке вида `https://storage.sys.<домен кластера>/<название_бакета>/<название_объекта>`.

      {% endlist %}

      Где:

      * `metadata.name` — уникальное в хранилище имя бакета длиной от 3 до 63 символов. Используйте строчные буквы латинского алфавита, цифры и дефисы; начинайте и заканчивайте имя буквой или цифрой. Имя не должно иметь вид IP-адреса.
      * `metadata.namespace` — проект, в котором создается бакет.
      * `spec.anonymousAccessFlags.read` — разрешает анонимным пользователям читать объекты.
      * `spec.anonymousAccessFlags.list` — разрешает анонимным пользователям получать список объектов.

  1. Примените манифест:

      ```bash
      kubectl apply -f bucket.yaml -n <название_проекта>
      ```

  1. Проверьте статус бакета:

      ```bash
      kubectl get bucket -n <название_проекта>
      ```

      Дождитесь, пока в колонке `PHASE` появится значение `Ready`.

      Если создание завершилось ошибкой, получите ее описание:

      ```bash
      kubectl get bucket <название_бакета> -n <название_проекта> -o yaml
      ```

      Причина указана в `status.message`. Исправьте манифест и примените его повторно.


- Консоль управления {#console}

  1. Если вы еще не открыли проект, выберите проект.
  1. В левом меню выберите **Object Storage**.
  1. Нажмите **Создать бакет**.
  1. Укажите настройки:

      * **Название бакета** — только строчные буквы, цифры и дефисы.
      * **Публичный доступ** — включите или выключите анонимный доступ к объектам.

  1. Нажмите **Создать**.

{% endlist %}

## Дополнительные настройки через CLI {#additional-settings}

В примере ниже заданы все доступные блоки настройки бакета: лимит размера, версионирование, публичный доступ, аутентификация по статическим ключам, метки, ACL, CORS, политика доступа, правила жизненного цикла и Object Lock. Выберите нужные настройки и измените их значения перед применением манифеста.

Пример создает закрытый бакет с лимитом 100 ГБ и версионированием. Для новых версий объектов включена блокировка на 7 дней в режиме `GOVERNANCE`. Отключить Object Lock после включения нельзя.

Для ACL в примере нужен сервисный аккаунт `archive-reader` в вашем проекте. Если его еще нет, создайте:

```bash
kubectl create serviceaccount archive-reader -n <название_проекта>
```

Сохраните манифест в файл `bucket.yaml`:

```yaml
apiVersion: storage.stackland.yandex.cloud/v1alpha1
kind: Bucket
metadata:
  name: app-archive
  namespace: my-project
spec:
  maxSize: 100Gi
  versioning: ENABLED
  anonymousAccessFlags:
    read: false
    list: false
    configRead: false
  disabledStaticKeyAuth: false
  tags:
    environment: production
    application: archive
  acl:
    grants:
      - permission: READ
        grantType: ACCOUNT
        grantee:
          kind: ServiceAccount
          namespace: my-project
          name: archive-reader
  cors:
    - id: archive-web-app
      allowedOrigins:
        - "https://app.example.com"
      allowedMethods:
        - GET
        - HEAD
        - PUT
        - POST
        - DELETE
      allowedHeaders:
        - "*"
      exposeHeaders:
        - ETag
        - x-amz-version-id
      maxAgeSeconds: 3600
  policy:
    Version: "2012-10-17"
    Statement:
      - Sid: AllowAuthorizedAccess
        Effect: Allow
        Principal: "*"
        Action: "s3:*"
        Resource:
          - "arn:aws:s3:::app-archive"
          - "arn:aws:s3:::app-archive/*"
  lifecycleRules:
    - id: expire-temporary-reports
      enabled: true
      filter:
        prefix: reports/
        tags:
          retention: temporary
        objectSizeGreaterThan: 1Mi
        objectSizeLessThan: 1Gi
      expiration:
        days: 90
      noncurrentExpiration:
        noncurrentDays: 30
    - id: cleanup-incomplete-uploads
      enabled: true
      filter:
        prefix: reports/
      abortIncompleteMultipartUpload:
        daysAfterExpiration: 7
    - id: cleanup-delete-markers
      enabled: true
      filter:
        prefix: reports/
      expiration:
        expiredObjectDeleteMarker: true
      noncurrentDeleteMarkers:
        noncurrentDays: 7
  objectLock:
    enabled: true
    defaultRetention:
      mode: GOVERNANCE
      days: 7
```

### Настроить параметры примера {#example-settings}

* `metadata.name` — имя бакета. При его изменении замените имя и в обеих строках `spec.policy.Statement[].Resource`: первая относится к бакету, вторая — к его объектам.
* `metadata.namespace` и `spec.acl.grants[].grantee.namespace` — имя вашего проекта. Все перечисленные ниже параметры находятся в `spec`.
* `maxSize` — максимальный объем данных в бакете. Значение `0` или отсутствие поля снимает ограничение размера бакета.
* `versioning` — `ENABLED` включает сохранение версий объектов. После включения версионирования вернуться к `DISABLED` нельзя. При включенном Object Lock приостанавливать версионирование с помощью `SUSPENDED` также нельзя.
* `anonymousAccessFlags` — разрешения для анонимных пользователей: `read` — чтение объектов, `list` — список объектов, `configRead` — чтение конфигурации бакета. В примере все три разрешения выключены.
* `disabledStaticKeyAuth` — `false` сохраняет возможность аутентификации по статическим ключам. Значение `true` запрещает такой способ аутентификации.
* `tags` — метки самого бакета. Они не назначаются объектам автоматически.
* `acl.grants` — разрешения для сервисных аккаунтов. В примере `archive-reader` получает `READ`, включая возможность прочитать ACL бакета. Для полного доступа укажите `FULL_CONTROL`. В `grantee` задайте `kind: ServiceAccount`, имя аккаунта и его проект. Для публичного доступа используйте `anonymousAccessFlags`.
* `cors` — правила запросов из браузера:
  * `id` — идентификатор правила;
  * `allowedOrigins` — непустой список адресов веб-приложений. Замените `https://app.example.com` на свой адрес;
  * `allowedMethods` — непустой список разрешенных методов. Доступны `GET`, `HEAD`, `PUT`, `POST` и `DELETE`; для составной загрузки нужен `POST`;
  * `allowedHeaders` — заголовки, которые браузер может отправлять. Значение `"*"` разрешает любые заголовки;
  * `exposeHeaders` — заголовки ответа, доступные коду веб-приложения;
  * `maxAgeSeconds` — время кеширования ответа на preflight-запрос в секундах.

  CORS не выдает права на чтение или изменение данных: приложению также нужны разрешения доступа к бакету.

* `policy` — политика доступа S3. В примере правило `Allow` пропускает операции над бакетом и его объектами, для которых пользователь уже имеет права. При изменении политики явно разрешите нужные операции: правило `Deny` само по себе не разрешает остальные действия. Общий результат также зависит от IAM, ACL и настроек публичного доступа.
* `lifecycleRules` — правила автоматической очистки. Для каждого правила задайте `id`, `enabled` и действия:
  * `filter` выбирает объекты. Все его условия должны выполняться одновременно. В `expire-temporary-reports` это префикс `reports/`, метка объекта `retention: temporary` и размер строго между `1Mi` и `1Gi`. В остальных правилах достаточно указанного префикса;
  * `expiration.days: 90` задает срок хранения текущих объектов в днях. При включенном версионировании создается маркер удаления, а версия становится нетекущей. Вместо `days` можно задать `date` в формате RFC 3339, например `"2030-01-01T00:00:00Z"`, или `expiredObjectDeleteMarker: true`. Эти три параметра нельзя использовать одновременно в одном блоке `expiration`;
  * `noncurrentExpiration.noncurrentDays: 30` удаляет версии через 30 дней после того, как они перестали быть текущими;
  * `abortIncompleteMultipartUpload.daysAfterExpiration: 7` удаляет части незавершенной составной загрузки через 7 дней после ее начала;
  * `expiration.expiredObjectDeleteMarker: true` удаляет маркер удаления, у которого не осталось версий объекта;
  * `noncurrentDeleteMarkers.noncurrentDays: 7` удаляет нетекущие маркеры удаления через 7 дней.
* `objectLock` — блокировка версий объектов. Для использования `defaultRetention` задайте `enabled: true` и `versioning: ENABLED`. В `defaultRetention` укажите `mode: GOVERNANCE` или `mode: COMPLIANCE` и срок в `days` либо `years`. В режиме `GOVERNANCE` обойти блокировку может пользователь с соответствующим разрешением; в `COMPLIANCE` удаление до истечения срока запрещено. Правила жизненного цикла не удаляют защищенную версию до окончания блокировки.

### Применить манифест {#apply-manifest}

После изменения параметров примените манифест:

```bash
kubectl apply -f bucket.yaml
```

Проверьте состояние бакета:

```bash
kubectl get bucket <название_бакета> -n <название_проекта> -o yaml
```

Дождитесь `status.phase: Ready` и совпадения `status.observedGeneration` с `metadata.generation`. Для изменения существующего бакета отредактируйте его манифест и примените повторно. Удаление необязательных настроек из манифеста сбрасывает их к значениям по умолчанию; ограничения на отключение версионирования и Object Lock сохраняются.

## Что дальше {#what-next}

* [Создайте ключ доступа](create-accesskey.md) для работы с бакетом через S3 API.
* Узнайте больше о [ресурсной модели Object Storage](../../concepts/components/storage.md#resource-model).