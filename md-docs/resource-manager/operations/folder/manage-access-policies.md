# Управлять политиками авторизации каталога

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

[Политики авторизации](../../../iam/concepts/access-control/access-policies.md) — это механизм контроля доступа Yandex Identity and Access Management, который позволяет управлять разрешениями на выполнение определенных операций с [ресурсами Yandex Cloud](../../../overview/roles-and-resources.md). Политики авторизации создаются на основе [шаблонов](../../../iam/concepts/access-control/access-policies.md#supported-policies) и дополняют систему [ролей](../../../iam/concepts/access-control/roles.md), делая [управление доступом](../../../iam/concepts/access-control/index.md) более гибким.

Управлять политиками авторизации [каталога](../../concepts/resources-hierarchy.md#folder) может пользователь, которому назначена роль [`resource-manager.admin`](../../security/index.md#resource-manager-admin) или [`admin`](../../../iam/roles-reference.md#admin) на этот каталог.

## Создать политику авторизации для каталога {#assign}

Чтобы создать для [каталога](../../concepts/resources-hierarchy.md#folder) политику авторизации на основе [шаблона без параметров](../../../iam/concepts/access-control/access-policies.md#fixed):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Получите](../../../iam/operations/access-policies/list.md) список поддерживаемых шаблонов политик авторизации с идентификаторами.
  1. Выполните команду:

      ```bash
      yc resource-manager folder bind-access-policy \
        --name <имя_каталога> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя каталога, для которого вы хотите создать политику. Вместо имени каталога вы можете указать его [идентификатор](get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона, на основе которого вы хотите создать политику авторизации для указанного каталога.
  1. [Убедитесь](manage-access-policies.md#view-assigned), что политика была создана.

- API {#api}

  Воспользуйтесь методом REST API [bindAccessPolicy](../../api-ref/Folder/bindAccessPolicy.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/BindAccessPolicy](../../api-ref/grpc/Folder/bindAccessPolicy.md).

{% endlist %}

Созданная политика авторизации будет применяться ко всем ресурсам в заданном каталоге.

## Посмотреть список политик авторизации каталога {#view-assigned}

Чтобы посмотреть список политик авторизации, созданных для [каталога](../../concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Выполните команду, указав имя или [идентификатор](get-id.md) каталога, для которого вы хотите посмотреть созданные политики:

  ```bash
  yc resource-manager folder list-access-policy-bindings <имя_или_идентификатор_каталога>
  ```

  Результат:

  ```
  +---------------------------------------------+-------------------------------------------------+
  |          ACCESS POLICY TEMPLATE ID          |                   PARAMETERS                    |
  +---------------------------------------------+-------------------------------------------------+
  | backup.denyRemoveProtection                 |                                                 |
  | serverless.containers.restrictNetworkAccess | allowed_vpc_network_ids=[enphfcfseu9i********], |
  |                                             | allowed_src_ips=[192.168.1.12/24]               |
  +---------------------------------------------+-------------------------------------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listAccessPolicyBindings](../../api-ref/Folder/listAccessPolicyBindings.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/ListAccessPolicyBindings](../../api-ref/grpc/Folder/listAccessPolicyBindings.md).

{% endlist %}

## Удалить политику авторизации, созданную для каталога {#revoke}

Чтобы удалить политику авторизации, созданную для [каталога](../../concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Получите](manage-access-policies.md#view-assigned) список идентификаторов шаблонов политик авторизации, назначенных на каталог.
  1. Выполните команду:

      ```bash
      yc resource-manager folder unbind-access-policy \
        --name <имя_каталога> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя каталога, для которого вы хотите удалить политику. Вместо имени каталога вы можете указать его [идентификатор](get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона политики авторизации, которую вы хотите удалить для указанного каталога.
  1. [Убедитесь](manage-access-policies.md#view-assigned), что политика была удалена.

- API {#api}

  Воспользуйтесь методом REST API [unbindAccessPolicy](../../api-ref/Folder/unbindAccessPolicy.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UnbindAccessPolicy](../../api-ref/grpc/Folder/unbindAccessPolicy.md).

{% endlist %}

Указанная политика авторизации перестанет применяться к ресурсам в заданном каталоге.

#### Полезные ссылки {#see-also}

* [Политики авторизации](../../../iam/concepts/access-control/access-policies.md)