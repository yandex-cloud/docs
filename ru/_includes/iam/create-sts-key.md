# Создать временный ключ доступа с помощью {{ sts-name }}

{% include [sts-preview](sts-preview.md) %}

С помощью [{{ sts-name }}](../../iam/concepts/authorization/sts.md) вы можете получить временные ключи для ограниченного доступа в [бакеты](../../storage/concepts/bucket.md) {{ objstorage-full-name }}.

Временные ключи доступа в качестве способа аутентификации поддерживаются только в сервисе [{{ objstorage-name }}](../../storage/).

У вас должны быть следующие _минимальные_ роли:
* для создания сервисного аккаунта и получения на него ключей доступа — [iam.serviceAccounts.admin](../../iam/roles-reference.md#iam-serviceAccounts-admin) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Если вы хотите использовать существующий сервисный аккаунт, достаточно роли `iam.serviceAccounts.admin` на этот сервисный аккаунт.
* для назначения сервисному аккаунту нужной роли — [storage.admin](../../storage/security/index.md#storage-admin) на бакет или каталог. Альтернативно можно использовать разрешение `FULL_CONTROL` в [ACL](../../storage/security/acl.md) бакета.

Если у вас примитивная роль [admin](../../iam/roles-reference.md#admin) на каталог, назначать дополнительно роли не требуется.

Чтобы получить временный ключ доступа:
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт. Вы также можете использовать существующий сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../storage/security/index.md#roles-list), например [storage.viewer](../../storage/security/index.md#storage-viewer) на бакет, к которому вы хотите получить доступ с помощью временного ключа, или каталог.

    {% note info %}
    
    Назначайте роль на каталог, если хотите с помощью сервисного аккаунта иметь доступ ко всем бакетам в каталоге.
    
    {% endnote %}

    Выбранная роль должна включать в себя все разрешения, которые вы хотите предоставлять с помощью временных ключей.

    В качестве альтернативы можно использовать разрешения [ACL](../../storage/security/acl.md) для бакета.
1. [Создайте](../../iam/operations/sa/create-access-key.md) статический ключ доступа для сервисного аккаунта.
1. [Установите и сконфигурируйте](../../storage/tools/aws-cli.md) AWS Command Line Interface (AWS CLI).
1. Опишите конфигурацию [политики доступа](../../storage/concepts/policy.md) в виде [схемы данных](../../storage/s3/api-ref/policy/scheme.md) формата JSON.

    {% include [sts-sa-scope-note](sts-sa-scope-note.md) %}

    {% cut "Пример политики" %}

    Эта политика позволяет пользователю с временным ключом получать объекты из указанного [префикса](../../storage/concepts/object.md#folder) бакета.

    ```json
    {
      "Version": "2012-10-17",
      "Statement": {
        "Sid": "all",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<имя_бакета>/<префикс>"
      }
    }
    ```

    Где:
    * `Version` — (опционально) версия описания политик доступа, например `2012-10-17`.
    * `Statement` — правила политики доступа:
      * `Sid` — (опционально) пользовательский идентификатор правила, например: `all`, `Statement Allow`, `Statement Deny`.
      * `Effect` — запрет или разрешение запрошенного действия, возможные значения: `Allow`, `Deny`.
      * `Principal` — возможное значение: `*`. Параметр нужен для совместимости с [AWS S3 API](../../storage/s3/index.md).
      * `Action` — [действие](../../storage/s3/api-ref/policy/actions.md), которое выполнится при срабатывании политики, например: `s3:GetObject`, `s3:PutObject`, `*`.
      * `Resource` — ресурс, с которым будет произведено действие, возможные значения: 
        * `arn:aws:s3:::<имя_бакета>` — бакет.
        * `arn:aws:s3:::<имя_бакета>/<ключ_объекта>` — объект в бакете.
        * `arn:aws:s3:::<имя_бакета>/<префикс>*` — все объекты в бакете, ключи которых начинаются с префикса, например `arn:aws:s3:::samplebucket/some/path/*`. Префикс может быть пустым: `arn:aws:s3:::samplebucket/*` — тогда правило будет относиться ко всем объектам в бакете.
    
          Ресурс бакета не включает в себя ресурсы всех его объектов. Чтобы правило в политике доступа относилось к бакету и всем объектам, их нужно указать как отдельные ресурсы, например `arn:aws:s3:::samplebucket` и `arn:aws:s3:::samplebucket/*`.

      Если при создании временных ключей доступа применить политику доступа без правил, то доступ по временному ключу будет запрещен.

    {% endcut %}

    Сохраните готовую конфигурацию в файле `policy.json`.

    {% include [sts-object-acl-note](sts-object-acl-note.md) %}

1. Получите временный ключ доступа:

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      Выполните команду:

      ```bash
      aws --endpoint https://{{ sts-host }}/ sts assume-role \
        --role-arn <произвольное_описание> \
        --role-session-name <имя_ключа> \
        --duration-seconds <время_жизни_ключа> \
        --policy file://policy.json
      ```

      Где:
      * `--endpoint` — эндпоинт {{ sts-name }}.
      * `--role-arn` — произвольное описание длиной не менее 20 символов. Поддерживаются буквы латинского алфавита, цифры, символы `_` и `-`.
      * `--role-session-name` — уникальное имя ключа. Поддерживаются буквы латинского алфавита, цифры, символы `_` и `-`.
      * `--duration-seconds` — время жизни ключа в секундах, не более `43200`.
      * `--policy file://` — путь к файлу с политикой доступа.

      Подробнее о команде `aws sts assume-role` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sts/assume-role.html).

      Результат:

      ```json
      {
          "Credentials": {
              "AccessKeyId": "YCAJEkNuezZyt4b**********",
              "SecretAccessKey": "YCMUWwxFAnZ**********...",
              "SessionToken": "s1.9euelZqPjcj**********...",
              "Expiration": "2024-02-29T23:30:53+00:00"
          },
          "AssumedRoleUser": {
              "Arn": "a1234567891234567890/test-2"
          },
          "PackedPolicySize": 0,
          "SourceIdentity": ""
      }
      ```

      Где:
      * `AccessKeyId` — идентификатор ключа (совпадает с идентификатором статического ключа).
      * `SecretAccessKey` — секретный ключ.
      * `SessionToken` — токен сессии.

      Сохраните эти параметры.

    {% endlist %}

1. Добавьте полученные параметры временного ключа доступа в переменные окружения для пользователя, которому вы хотите выдать права доступа к бакету:

    ```bash
    export AWS_ACCESS_KEY_ID=<идентификатор_ключа>
    export AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    export AWS_SESSION_TOKEN=<токен_сессии>
    ```

1. Чтобы протестировать доступ к бакету, сохраните на клиентское устройство объект из префикса бакета, к которому был открыт доступ:

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      ```bash
      aws --endpoint https://storage.yandexcloud.net s3 cp \
        s3://<имя_бакета>/<префикс><имя_объекта> ./
      ```

      Результат:

      ```text
      download: s3://<имя_бакета>/<префикс><имя_объекта> to ./<имя_объекта>
      ```

    {% endlist %}

### См. также {#see-also}

* [{#T}](../../storage/security/overview.md)