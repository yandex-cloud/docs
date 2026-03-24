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

          {% include notitle [YAML-файл](../../_includes/yamls/operations/storage/create-bucket-without.md) %}

      - Бакет с публичным доступом

          {% include notitle [YAML-файл](../../_includes/yamls/operations/storage/create-bucket.md) %}

          В этом случае объекты будут доступны для чтения без аутентификации по ссылке вида `https://storage.sys.{{ cluster-domain }}/<название_бакета>/<название_объекта>`.

      {% endlist %}

      Где:

      * `metadata.name` — имя бакета. Допускаются строчные буквы латинского алфавита, цифры и дефисы.
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


- Консоль управления {#console}

  1. Если вы еще не открыли проект, выберите проект.
  1. В левом меню выберите **Object Storage**.
  1. Нажмите **Создать бакет**.
  1. Укажите настройки:

      * **Название бакета** — только строчные буквы, цифры и дефисы.
      * **Публичный доступ** — включите или выключите анонимный доступ к объектам.

  1. Нажмите **Создать**.

{% endlist %}

## Что дальше {#what-next}

* [Создайте ключ доступа](create-accesskey.md) для работы с бакетом через S3 API.
* Узнайте больше о [ресурсной модели {{ objstorage-name }}](../../concepts/components/storage.md#resource-model).
