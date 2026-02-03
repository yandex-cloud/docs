[Часть сервисов](../../iam/concepts/authorization/ephemeral-keys.md#supported-services) {{ yandex-cloud }} поддерживает аутентификацию с помощью [эфемерных ключей доступа](../../iam/concepts/authorization/ephemeral-keys.md).

Эфемерные ключи доступа создаются для [аккаунтов на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративных аккаунтов](../../iam/concepts/users/accounts.md#saml-federation), [локальных пользователей](../../iam/concepts/users/accounts.md#local) и [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md).


## Создать эфемерный ключ доступа {#create}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды создания эфемерного ключа доступа:

      ```bash
      yc iam access-key issue-ephemeral --help
      ```

  1. Создайте эфемерный ключ доступа:

      ```bash
      yc iam access-key issue-ephemeral \
        --subject-id <идентификатор_аккаунта> \
        --session-name <имя_сессии> \
        --policy <путь_к_файлу> \
        --duration <срок_жизни>
      ```

      Где:

      * `--subject-id` — идентификатор сервисного аккаунта. Если параметр не указан, ключ будет создан для пользователя, отправившего запрос.
      * `--session-name` — имя сессии длиной от 1 до 64 символов. Необходимо для идентификации сессии в случае, если сервисный аккаунт [имперсонирован](../../iam/concepts/access-control/impersonation.md) для нескольких пользователей. Обязательный параметр.
      * `--policy` — путь к файлу с [политикой доступа](../../storage/concepts/policy.md) в виде [схемы данных](../../storage/s3/api-ref/policy/scheme.md) формата JSON. Если параметр не указан, ключ даст полный доступ к [бакету](../../storage/concepts/bucket.md).
      * `--duration` — срок жизни ключа от `15m` до `12h`. Если параметр не указан, срок жизни ключа будет ограничен сроком действия IAM-токена текущей сессии.

      Результат:

      ```text
      access_key_id: ajelprpohp8t********
      secret: YCOs05v-KRXqhYpUINdWArH4MINhMyJ6CGU********
      session_token: s1.9muilY********
      expires_at: "2025-12-16T06:23:51.383485065Z"
      ```

  1. Сохраните идентификатор ключа `access_key_id`, секретный ключ `secret` и токен сессии `session_token`. Повторно получить эти значения будет невозможно.

{% endlist %}


## Протестировать доступ к бакету {#test}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Убедитесь, что у аккаунта, для которого вы создали эфемерный ключ доступа, есть доступ к бакету, к которому вы хотите получить доступ с помощью ключа. Если доступа нет, [назначьте](../../iam/operations/sa/assign-role-for-sa.md) аккаунту нужную [роль](../../storage/security/index.md#roles-list), например [storage.viewer](../../storage/security/index.md#storage-viewer), на бакет.

      В качестве альтернативы можно использовать разрешения [ACL](../../storage/security/acl.md) для бакета.

  1. Добавьте новый профиль в `~/.aws/credentials`:

      ```text
      [<имя_профиля>]
      aws_access_key_id     = <идентификатор_ключа>
      aws_secret_access_key = <секретный_ключ>
      aws_session_token     = <токен_сессии>
      ```

      Укажите в профиле значения, полученные при создании эфемерного ключа доступа:

      * `aws_access_key_id` — идентификатор ключа `access_key_id`.
      * `aws_secret_access_key` — секретный ключ `secret`.
      * `aws_session_token` — токен сессии `session_token`

  1. Сохраните на клиентское устройство объект из префикса бакета, к которому был открыт доступ:

      ```bash
      aws --endpoint https://{{ s3-storage-host }} s3 cp \
        s3://<имя_бакета>/<префикс><имя_объекта> ./
      ```

      Результат:

      ```text
      download: s3://<имя_бакета>/<префикс><имя_объекта> to ./<имя_объекта>
      ```

{% endlist %}