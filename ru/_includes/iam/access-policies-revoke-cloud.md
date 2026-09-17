Чтобы удалить политику авторизации, созданную для [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Получите](../../resource-manager/operations/cloud/manage-access-policies.md#view-assigned) список идентификаторов шаблонов политик авторизации, назначенных на облако.
  1. Выполните команду:

      ```bash
      yc resource-manager cloud unbind-access-policy \
        --name <имя_облака> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя облака, для которого вы хотите удалить политику. Вместо имени облака вы можете указать его [идентификатор](../../resource-manager/operations/cloud/get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона политики авторизации, которую вы хотите удалить у указанного облака.
  1. [Убедитесь](../../resource-manager/operations/cloud/manage-access-policies.md#view-assigned), что политика была удалена.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../terraform-install.md) %}

  1. В конфигурации найдите ресурс `yandex_resource_manager_cloud_iam_policy_binding` с идентификаторами нужного шаблона политики в `access_policy_template_id` и облака в `cloud_id`.
  1. Удалите блок этого ресурса. Сам ресурс облака удалять не нужно.
  1. Примените конфигурацию:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Убедитесь, что план удаляет только нужную привязку политики. Эти инструкции применимы к привязке, которой управляет текущая конфигурация { TF }.

- API {#api}

  Воспользуйтесь методом REST API [unbindAccessPolicy](../../resource-manager/api-ref/Cloud/unbindAccessPolicy.md) для ресурса [Cloud](../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/UnbindAccessPolicy](../../resource-manager/api-ref/grpc/Cloud/unbindAccessPolicy.md).

{% endlist %}

Указанная политика авторизации перестанет применяться к ресурсам внутри всех каталогов в пределах заданного облака.