{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Посмотрите описание команды [CLI](../../../cli/) для активации сервиса:

   ```bash
   yc backup provider activate --help
   ```

1. Активируйте сервис в каталоге по умолчанию:

   ```bash
   yc backup provider activate --async
   ```

   Где `--async` — отображение информации о прогрессе операции. Необязательный параметр.

1. После выполнения команды появится предупреждение об активации `This command will activate backup provider for your folder. Do you confirm this action to be executed? [Yes/no][y/N]`. Подтвердите активацию — в терминале введите `yes` или `y`.

   {% note tip %}

   Чтобы активировать сервис без подтверждения, используйте флаг `--force`.

   {% endnote %}

   Результат:

   ```text
   id: cdgmnefxiatx********
   description: activate provider
   created_at: "2024-10-14T09:03:47.960564Z"
   created_by: ajec1gaqcmtr********
   modified_at: "2024-10-14T09:03:47.960564Z"
   done: true
   metadata:
     '@type': type.googleapis.com/yandex.cloud.backup.v1.ActivateProviderMetadata
     folder_id: b1go3el0d8fs********
   response:
     '@type': type.googleapis.com/google.protobuf.Empty
     value: {}
   ```

{% include [default-policies](../default-policies.md) %}

Если вы не хотите их создавать, используйте параметр `--skip-default-policy`.