Чтобы удалить политику авторизации, созданную для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Получите](../../resource-manager/operations/folder/manage-access-policies.md#view-assigned) список идентификаторов шаблонов политик авторизации, назначенных на каталог.
  1. Выполните команду:

      ```bash
      yc resource-manager folder unbind-access-policy \
        --name <имя_каталога> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя каталога, для которого вы хотите удалить политику. Вместо имени каталога вы можете указать его [идентификатор](../../resource-manager/operations/folder/get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона политики авторизации, которую вы хотите удалить для указанного каталога.
  1. [Убедитесь](../../resource-manager/operations/folder/manage-access-policies.md#view-assigned), что политика была удалена.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../terraform-install.md) %}

  1. В конфигурации найдите ресурс `yandex_resource_manager_folder_iam_policy_binding` с идентификаторами нужного шаблона политики в `access_policy_template_id` и каталога в `folder_id`.
  1. Удалите блок этого ресурса. Сам ресурс каталога удалять не нужно.
  1. Примените конфигурацию:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Убедитесь, что план удаляет только нужную привязку политики. Эти инструкции применимы к привязке, которой управляет текущая конфигурация { TF }.

- API {#api}

  Воспользуйтесь методом REST API [unbindAccessPolicy](../../resource-manager/api-ref/Folder/unbindAccessPolicy.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UnbindAccessPolicy](../../resource-manager/api-ref/grpc/Folder/unbindAccessPolicy.md).

{% endlist %}

Указанная политика авторизации перестанет применяться к ресурсам в заданном каталоге.