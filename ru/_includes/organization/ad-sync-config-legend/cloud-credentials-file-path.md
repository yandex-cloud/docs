* `cloud_credentials_file_path` — путь к файлу, содержащему [авторизованный ключ](../../../iam/concepts/authorization/key.md) сервисного аккаунта в {{ yandex-cloud }}. Необязательный параметр: используется только при аутентификации агента в API {{ yandex-cloud }} с помощью авторизованного ключа.

    Примеры значений:

    * `/etc/yc-identityhub-sync-agent/authorized_key.json` (для Linux);
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (для Windows).

    В параметре `cloud_credentials_file_path` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.

    {% note info %}

    Если в параметрах `cloud_credentials_file_path` и/или `logger.file.filename` заданы пути, отличные от пути, заданного в параметре `working_directory`, для выбранных сущностей будут использоваться пути, указанные в параметрах `cloud_credentials_file_path` и/или `logger.file.filename`.

    {% endnote %}