# Создать ключ доступа

Для работы с {{ objstorage-name }} через S3 API необходим ключ доступа. Ключи доступа создаются через {{ iam-name }} с использованием сервисных аккаунтов. Можно использовать статический ключ или выпустить на его основе [временный ключ](#create-sts-key) с ограниченными правами и сроком действия.

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
      kind: AccessKey
      metadata:
        name: <имя_сервисного_аккаунта>-s3-key
        namespace: <название_проекта>
      spec:
        serviceAccountRef: <имя_сервисного_аккаунта>
      ```

      Сохраните манифест в файл `access-key.yaml` и примените его:

      ```bash
      kubectl apply -f access-key.yaml
      ```

  1. Проверьте готовность ключа:

      ```bash
      kubectl get accesskey <имя_сервисного_аккаунта>-s3-key -n <название_проекта>
      ```

      Дождитесь значения `True` в колонке `READY`. Имя созданного секрета отображается в колонке `SECRET` и поле `status.secretName`.

  1. Получите идентификатор и секретную часть ключа из секрета:

      ```bash
      S3_SECRET_NAME=$(kubectl get accesskey <имя_сервисного_аккаунта>-s3-key -n <название_проекта> -o jsonpath='{.status.secretName}')
      export AWS_ACCESS_KEY_ID=$(kubectl get secret -n <название_проекта> "$S3_SECRET_NAME" -o jsonpath='{.data.access-key-id}' | base64 -d)
      export AWS_SECRET_ACCESS_KEY=$(kubectl get secret -n <название_проекта> "$S3_SECRET_NAME" -o jsonpath='{.data.access-key-secret}' | base64 -d)
      export AWS_DEFAULT_REGION=ru-central1
      unset AWS_SESSION_TOKEN
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

## Создать временный ключ доступа {#create-sts-key}

[STS](../../concepts/components/storage.md#sts) включается автоматически вместе с {{ objstorage-name }}. Для получения ключа используйте AWS CLI и эндпоинт `https://sts.sys.{{ cluster-domain }}`.

1. Создайте сервисный аккаунт, назначьте ему необходимые права на бакет и получите статический ключ по инструкции выше. Настройте AWS CLI на использование этого ключа. Права сервисного аккаунта должны разрешать операции, которые вы хотите предоставить приложению.

1. Сохраните политику временного доступа в файл `policy.json`. Например, разрешите читать объекты только с префиксом `reports/` в бакете `app-data`:

    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::app-data/reports/*"
        }
      ]
    }
    ```

    Замените имя бакета и префикс на свои. В одной политике STS задавайте доступ к одному бакету. Подробнее о формате политики читайте в [документации STS](https://yandex.cloud/ru/docs/iam/operations/sa/create-sts-key).

1. Запросите временный ключ на один час:

    ```bash
    aws --endpoint-url=https://sts.sys.<домен_кластера> --region ru-central1 sts assume-role \
      --role-arn stackland-storage-session \
      --role-session-name reports-reader \
      --policy file://policy.json \
      --duration-seconds 3600
    ```

    В `--role-arn` передается произвольное описание длиной от 20 символов, а в `--role-session-name` — имя сессии. Для них используйте латинские буквы, цифры, `_` и `-`. Параметр `--duration-seconds` задает срок действия в секундах, максимум — `43200` (12 часов).

1. Из блока `Credentials` в ответе передайте приложению `AccessKeyId`, `SecretAccessKey` и `SessionToken`. Для AWS CLI задайте их в отдельной сессии терминала:

    ```bash
    export AWS_ACCESS_KEY_ID='<AccessKeyId>'
    export AWS_SECRET_ACCESS_KEY='<SecretAccessKey>'
    export AWS_SESSION_TOKEN='<SessionToken>'
    ```

    При работе с временным ключом токен сессии обязателен. В поле `Expiration` указан момент окончания действия ключа.

1. Проверьте чтение существующего объекта из разрешенного префикса:

    ```bash
    aws --endpoint-url=https://storage.sys.<домен_кластера> --region ru-central1 s3 cp \
      s3://app-data/reports/<имя_объекта> ./
    ```

    Замените путь на путь к своему объекту. Для получения следующего временного ключа снова используйте исходный статический ключ.

## Доступные роли {#roles}

* `storage.viewer` — позволяет читать объекты и получать список бакетов.
* `storage.editor` — позволяет читать, создавать, изменять и удалять объекты.
* `storage.admin` — полный доступ к {{ objstorage-name }}, включая управление настройками бакетов.

## Что дальше {#what-next}

* Узнайте больше об [управлении доступом](../../concepts/components/storage.md#access-management) в {{ objstorage-name }}.
* Ознакомьтесь с документацией [{{ iam-name }}](../../concepts/components/iam.md).
