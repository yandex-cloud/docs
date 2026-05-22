# Создать ключ доступа

Для работы с {{ objstorage-name }} через S3 API необходим ключ доступа. Ключи доступа создаются через {{ iam-name }} с использованием сервисных аккаунтов.

## Перед началом работы {#before-you-begin}

1. Убедитесь, что у вас есть [проект](../projects/create-project.md).
1. Убедитесь, что в проекте создан [бакет](create-bucket.md).

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте сервисный аккаунт в проекте:

      ```bash
      kubectl create serviceaccount <имя_сервисного_аккаунта> -n <название_проекта>
      ```

  1. Назначьте сервисному аккаунту роль `storage.editor` для доступа к бакетам:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: AccessBinding
      metadata:
        name: <имя_сервисного_аккаунта>-storage-access
        namespace: <название_проекта>
      spec:
        roleID: storage.editor
        subject:
          kind: ServiceAccount
          name: <имя_сервисного_аккаунта>
          namespace: <название_проекта>
      ```

      Сохраните манифест в файл `access-binding.yaml` и примените его:

      ```bash
      kubectl apply -f access-binding.yaml
      ```

  1. Создайте статический ключ доступа для сервисного аккаунта:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: APIKey
      metadata:
        name: <имя_сервисного_аккаунта>-s3-key
        namespace: <название_проекта>
      spec:
        serviceAccountRef:
          name: <имя_сервисного_аккаунта>
        secretName: <имя_сервисного_аккаунта>-s3-credentials
      ```

      Сохраните манифест в файл `api-key.yaml` и примените его:

      ```bash
      kubectl apply -f api-key.yaml
      ```

  1. Получите ключ доступа и секретный ключ из созданного секрета:

      ```bash
      export AWS_ACCESS_KEY_ID=$(kubectl get secret -n <название_проекта> <имя_сервисного_аккаунта>-s3-credentials -o jsonpath='{.data.accessKeyId}' | base64 -d)
      export AWS_SECRET_ACCESS_KEY=$(kubectl get secret -n <название_проекта> <имя_сервисного_аккаунта>-s3-credentials -o jsonpath='{.data.secretAccessKey}' | base64 -d)
      ```

  1. Проверьте подключение к {{ objstorage-name }}:

      ```bash
      export CLUSTER_DOMAIN=$(kubectl get platformenvironments main -o jsonpath='{.status.clusterDomain}')
      aws --endpoint-url=https://storage.sys.$CLUSTER_DOMAIN s3 ls
      ```


- Консоль управления {#console}

  1. Если вы еще не открыли проект, выберите проект.
  1. В левом меню выберите **Сервисные аккаунты**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. Укажите имя сервисного аккаунта и нажмите **Создать**.
  1. Выберите созданный сервисный аккаунт.
  1. Перейдите на вкладку **Ключи доступа**.
  1. Нажмите **Создать ключ**.
  1. Сохраните **Access Key ID** и **Secret Access Key**.

      {% note warning %}

      Секретный ключ отображается только один раз. Сохраните его в надежном месте.

      {% endnote %}

  1. Назначьте сервисному аккаунту роль `storage.editor`:
      1. Перейдите в раздел **Права доступа** проекта.
      1. Нажмите **Назначить роль**.
      1. Выберите роль `storage.editor`.
      1. В качестве субъекта выберите созданный сервисный аккаунт.
      1. Нажмите **Назначить**.

{% endlist %}

## Доступные роли {#roles}

* `storage.viewer` — позволяет читать объекты и получать список бакетов.
* `storage.editor` — позволяет читать, создавать, изменять и удалять объекты.
* `storage.admin` — полный доступ к {{ objstorage-name }}, включая управление настройками бакетов.

## Что дальше {#what-next}

* Узнайте больше об [управлении доступом](../../concepts/components/storage.md#access-management) в {{ objstorage-name }}.
* Ознакомьтесь с документацией [{{ iam-name }}](../../concepts/components/iam.md).
