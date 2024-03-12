Назначьте роли сервисному аккаунту:

  {% list tabs group=instructions %}

  - CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    * Назначьте [роль `audit-trails.viewer`](../../audit-trails/security/index.md#roles-list) на облако, со всех ресурсов которого будут собираться аудитные логи:

      ```
      yc resource-manager cloud add-access-binding \
        --role audit-trails.viewer \
        --id <идентификатор_облака> \
        --service-account-id <идентификатор_сервисного_аккаунта>
      ```

      Где:

      * `--role` — назначаемая роль;
      * `--id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), с которого будут собираться аудитные логи;
      * `--service-account-id` — идентификатор сервисного аккаунта.

    * Назначьте [роль `storage.uploader`](../../storage/security/index.md#storage-uploader) на каталог, в котором будет находиться трейл:

      ```
      yc resource-manager folder add-access-binding \
        --role storage.uploader \
        --id <идентификатор_каталога> \
        --service-account-id <идентификатор_сервисного_аккаунта>
      ```

      Где:

      * `--role` — назначаемая роль;
      * `--id` — идентификатор каталога, в котором будет находиться трейл;
      * `--service-account-id` — идентификатор сервисного аккаунта.

    {% endlist %}
