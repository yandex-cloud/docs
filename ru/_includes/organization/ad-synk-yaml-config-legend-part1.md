* `userpool_id` — идентификатор [пула пользователей](../../organization/concepts/user-pools.md) в {{ org-full-name }}.
* `working_directory` — путь к директории, в которой сохраняются файлы, необходимые агенту для работы. Необязательный параметр.

    Если параметр не задан, в качестве рабочей директории используется директория, в которой расположен исполняемый файл агента. По умолчанию исполняемый файл агента располагается в следующих директориях:

    * `/etc/yc-identityhub-sync-agent/` (для Linux);
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\` (для Windows).

* `cloud_credentials_file_path` — путь к файлу, содержащему [авторизованный ключ](../../iam/concepts/authorization/key.md) сервисного аккаунта в {{ yandex-cloud }}. Необязательный параметр: используется только при аутентификации агента в API {{ yandex-cloud }} с помощью авторизованного ключа.

    Примеры значений:

    * `/etc/yc-identityhub-sync-agent/authorized_key.json` (для Linux);
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (для Windows).

    В параметре `cloud_credentials_file_path` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.

    {% note info %}

    Если в параметрах `cloud_credentials_file_path` и/или `logger.file.filename` заданы пути, отличные от пути, заданного в параметре `working_directory`, для выбранных сущностей будут использоваться пути, указанные в параметрах `cloud_credentials_file_path` и/или `logger.file.filename`.

    {% endnote %}

* `use_metadata_service` — параметр, управляющий аутентификацией агента в API {{ yandex-cloud }} с помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md) и позволяющий агенту получать IAM-токены через [сервис метаданных](../../compute/concepts/vm-metadata.md) ВМ.

    Возможные значения:

    * `true` — агент синхронизации будет получать IAM-токены сервисного аккаунта через сервис метаданных виртуальной машины и использовать их для аутентификации в API {{ yandex-cloud }}. Значение параметра `cloud_credentials_file_path` при этом будет игнорироваться.

        Чтобы агент мог получать IAM-токены, он должен быть установлен на виртуальной машине {{ compute-full-name }}, к которой подключен сервисный аккаунт с [необходимыми](../../organization/concepts/ad-sync.md#yc-setup) правами доступа.
    * `false` — агент синхронизации не будет получать IAM-токены, а аутентификация в API {{ yandex-cloud }} будет выполняться с помощью авторизованного ключа, заданного в параметре `cloud_credentials_file_path`.
* `enable_password_writeback` — параметр, управляющий [обратной записью паролей](../../organization/concepts/ad-sync.md#password-writeback) пользователей в {{ microsoft-idp.ad-short }}.

    {% include [pw-writeback-preview-notice](./pw-writeback-preview-notice.md) %}

    Возможные значения:

    * `true` — при попытке изменить пароль синхронизированного пользователя на стороне {{ org-full-name }} ([изменение пароля](../../organization/operations/manage-account.md#edit-password) самим пользователем или [сброс пароля](../../organization/operations/user-pools/reset-user-password.md#reset) администратором) агент сначала попытается изменить пароль соответствующего пользователя в {{ microsoft-idp.ad-short }}, и только в случае успеха этой операции пароль будет изменен в {{ org-full-name }}.
    * `false` — при изменении пароля синхронизированного пользователя на стороне {{ org-full-name }} пароль этого пользователя не будет изменен в {{ microsoft-idp.ad-short }}. Если после изменения пароля выполнить [полную синхронизацию](../../organization/concepts/ad-sync.md#full-sync), агент заменит обновленный пароль в {{ org-full-name }} паролем, взятым из {{ microsoft-idp.ad-short }}. Это также поведение по умолчанию, если функциональность обратной записи не активирована.
* `dry_run` — настройки [тестового запуска](../../organization/concepts/ad-sync.md#dry-run) агента (dry run):

    * `enabled: true` — активирован режим dry run. Агент не вносит изменения в данные пользователей и групп {{ org-full-name }}. Вместо этого он тестирует выполнение всех предусмотренных конфигурацией агента операций и сохраняет результаты этих тестов в [логах](../../organization/concepts/ad-sync.md#logging) его работы.
    * `enabled: false` — агент функционирует в рабочем режиме, необходимые изменения вносятся в данные пользователей и групп {{ org-full-name }}.
