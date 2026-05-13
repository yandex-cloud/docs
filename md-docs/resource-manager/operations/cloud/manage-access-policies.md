# Управлять политиками авторизации облака

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

[Политики авторизации](../../../iam/concepts/access-control/access-policies.md) — это механизм контроля доступа Yandex Identity and Access Management, который позволяет управлять разрешениями на выполнение определенных операций с [ресурсами Yandex Cloud](../../../overview/roles-and-resources.md). Политики авторизации создаются на основе [шаблонов](../../../iam/concepts/access-control/access-policies.md#supported-policies) и дополняют систему [ролей](../../../iam/concepts/access-control/roles.md), делая [управление доступом](../../../iam/concepts/access-control/index.md) более гибким.

Управлять политиками авторизации [облака](../../concepts/resources-hierarchy.md#cloud) может пользователь, которому назначена роль [`resource-manager.admin`](../../security/index.md#resource-manager-admin) или [`admin`](../../../iam/roles-reference.md#admin) на это облако.

## Создать политику авторизации для облака {#assign}

Чтобы создать для [облака](../../concepts/resources-hierarchy.md#cloud) политику авторизации на основе [шаблона без дополнительных параметров](../../../iam/concepts/access-control/access-policies.md#fixed):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Получите](../../../iam/operations/access-policies/list.md) список поддерживаемых шаблонов политик авторизации с идентификаторами.
  1. Выполните команду:

      ```bash
      yc resource-manager cloud bind-access-policy \
        --name <имя_облака> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя облака, для которого вы хотите создать политику. Вместо имени облака вы можете указать его [идентификатор](get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона, на основе которого вы хотите создать политику авторизации для указанного облака.
  1. [Убедитесь](manage-access-policies.md#view-assigned), что политика была создана.

- API {#api}

  Воспользуйтесь методом REST API [bindAccessPolicy](../../api-ref/Cloud/bindAccessPolicy.md) для ресурса [Cloud](../../api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/BindAccessPolicy](../../api-ref/grpc/Cloud/bindAccessPolicy.md).

{% endlist %}

Созданная политика авторизации будет применяться к ресурсам внутри всех каталогов в пределах заданного облака.

## Посмотреть список политик авторизации облака {#view-assigned}

Чтобы посмотреть список политик авторизации, созданных для [облака](../../concepts/resources-hierarchy.md#cloud):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Выполните команду, указав имя или [идентификатор](get-id.md) облака, для которого вы хотите посмотреть созданные политики:

  ```bash
  yc resource-manager cloud list-access-policy-bindings <имя_или_идентификатор_облака>
  ```

  Результат:

  ```
  +---------------------------------------+
  |      ACCESS POLICY TEMPLATE ID        |
  +---------------------------------------+
  | iam.denyServiceAccountApiKeysCreation |
  +---------------------------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listAccessPolicyBindings](../../api-ref/Cloud/listAccessPolicyBindings.md) для ресурса [Cloud](../../api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/ListAccessPolicyBindings](../../api-ref/grpc/Cloud/listAccessPolicyBindings.md).

{% endlist %}

## Удалить политику авторизации, созданную для облака {#revoke}

Чтобы удалить политику авторизации, созданную для [облака](../../concepts/resources-hierarchy.md#cloud):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Получите](manage-access-policies.md#view-assigned) список идентификаторов шаблонов политик авторизации, назначенных на облако.
  1. Выполните команду:

      ```bash
      yc resource-manager cloud unbind-access-policy \
        --name <имя_облака> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя облака, для которого вы хотите удалить политику. Вместо имени облака вы можете указать его [идентификатор](get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона политики авторизации, которую вы хотите удалить у указанного облака.
  1. [Убедитесь](manage-access-policies.md#view-assigned), что политика была удалена.

- API {#api}

  Воспользуйтесь методом REST API [unbindAccessPolicy](../../api-ref/Cloud/unbindAccessPolicy.md) для ресурса [Cloud](../../api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/UnbindAccessPolicy](../../api-ref/grpc/Cloud/unbindAccessPolicy.md).

{% endlist %}

Указанная политика авторизации перестанет применяться к ресурсам внутри всех каталогов в пределах заданного облака.

#### См. также {#see-also}

* [Политики авторизации](../../../iam/concepts/access-control/access-policies.md)