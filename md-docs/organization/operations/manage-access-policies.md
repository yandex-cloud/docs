# Управлять политиками авторизации организации

{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

[Политики авторизации](../../iam/concepts/access-control/access-policies.md) — это механизм контроля доступа {{ iam-full-name }}, который позволяет управлять разрешениями на выполнение определенных операций с [ресурсами {{ yandex-cloud }}](../../overview/roles-and-resources.md). Политики авторизации создаются на основе [шаблонов](../../iam/concepts/access-control/access-policies.md#supported-policies) и дополняют систему [ролей](../../iam/concepts/access-control/roles.md), делая [управление доступом](../../iam/concepts/access-control/index.md) более гибким.

Управлять политиками авторизации [организации](../concepts/organization.md) может пользователь, которому назначена роль [`organization-manager.admin`](../security/index.md#organization-manager-admin) или [`admin`](../../iam/roles-reference.md#admin) на эту организацию.

## Создать политику авторизации для организации {#assign}

Чтобы создать для [организации](../concepts/organization.md) политику авторизации на основе [шаблона без параметров](../../iam/concepts/access-control/access-policies.md#fixed):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  1. [Получите](../../iam/operations/access-policies/list.md) список поддерживаемых шаблонов политик авторизации с идентификаторами.
  1. Выполните команду:

      ```bash
      yc organization-manager organization bind-access-policy \
        --name <имя_организации> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя организации, для которой вы хотите создать политику. Вместо имени организации вы можете указать ее [идентификатор](organization-get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона, на основе которого вы хотите создать политику авторизации для указанной организации.
  1. [Убедитесь](manage-access-policies.md#view-assigned), что политика была создана.

- API {#api}

  Воспользуйтесь методом REST API [bindAccessPolicy](../api-ref/Organization/bindAccessPolicy.md) для ресурса [Organization](../api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/BindAccessPolicy](../api-ref/grpc/Organization/bindAccessPolicy.md).

{% endlist %}

Созданная политика авторизации будет применяться к ресурсам внутри всех облаков в пределах заданной организации.

## Посмотреть список политик авторизации организации {#view-assigned}

Чтобы посмотреть список политик авторизации, созданных для [организации](../concepts/organization.md):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  Выполните команду, указав имя или [идентификатор](organization-get-id.md) организации, для которой вы хотите посмотреть созданные политики:

  ```bash
  yc organization-manager organization list-access-policy-bindings <имя_или_идентификатор_организации>
  ```

  Результат:

  ```
  +------------------------------+
  |  ACCESS POLICY TEMPLATE ID   |
  +------------------------------+
  | organization.denyUserListing |
  +------------------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listAccessPolicyBindings](../api-ref/Organization/listAccessPolicyBindings.md) для ресурса [Organization](../api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/ListAccessPolicyBindings](../api-ref/grpc/Organization/listAccessPolicyBindings.md).

{% endlist %}

## Удалить политику авторизации, созданную для организации {#revoke}

Чтобы удалить политику авторизации, созданную для [организации](../concepts/organization.md):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  1. [Получите](manage-access-policies.md#view-assigned) список идентификаторов шаблонов политик авторизации, назначенных на организацию.
  1. Выполните команду:

      ```bash
      yc organization-manager organization unbind-access-policy \
        --name <имя_организации> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя организации, для которой вы хотите удалить политику. Вместо имени организации вы можете указать ее [идентификатор](organization-get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона политики авторизации, которую вы хотите удалить у указанной организации.
  1. [Убедитесь](manage-access-policies.md#view-assigned), что политика была удалена.

- API {#api}

  Воспользуйтесь методом REST API [unbindAccessPolicy](../api-ref/Organization/unbindAccessPolicy.md) для ресурса [Organization](../api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UnbindAccessPolicy](../api-ref/grpc/Organization/unbindAccessPolicy.md).

{% endlist %}

Указанная политика авторизации перестанет применяться к ресурсам внутри всех облаков в пределах заданной организации.

#### См. также {#see-also}

* [{#T}](../../iam/concepts/access-control/access-policies.md)