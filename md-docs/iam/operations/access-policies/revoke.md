# Удаление политики авторизации

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

[Политики авторизации](../../concepts/access-control/access-policies.md) — это механизм контроля доступа Yandex Identity and Access Management, который позволяет управлять разрешениями на выполнение определенных операций с [ресурсами Yandex Cloud](../../../overview/roles-and-resources.md). Политики авторизации создаются на основе [шаблонов](../../concepts/access-control/access-policies.md#supported-policies) и дополняют систему [ролей](../../concepts/access-control/roles.md), делая [управление доступом](../../concepts/access-control/index.md) более гибким.

Вы можете удалить политику авторизации, созданную для [каталога](#folder), [облака](#cloud) или [организации](#organization).

{% note info %}

Управлять политиками авторизации может пользователь, которому назначена одна из следующих ролей:

* [`resource-manager.admin`](../../../resource-manager/security/index.md#resource-manager-admin) или [`admin`](../../roles-reference.md#admin) на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) или [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud), чтобы управлять политиками авторизации соответственно на уровне каталога или облака;
* [`organization-manager.admin`](../../../organization/security/index.md#organization-manager-admin) или [`admin`](../../roles-reference.md#admin) на [организацию](../../../organization/concepts/organization.md), чтобы управлять политиками авторизации на уровне организации.

{% endnote %}

## Удалить политику авторизации, созданную для каталога {#folder}

Чтобы удалить политику авторизации, созданную для [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Получите](../../../resource-manager/operations/folder/manage-access-policies.md#view-assigned) список идентификаторов шаблонов политик авторизации, назначенных на каталог.
  1. Выполните команду:

      ```bash
      yc resource-manager folder unbind-access-policy \
        --name <имя_каталога> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя каталога, для которого вы хотите удалить политику. Вместо имени каталога вы можете указать его [идентификатор](../../../resource-manager/operations/folder/get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона политики авторизации, которую вы хотите удалить для указанного каталога.
  1. [Убедитесь](../../../resource-manager/operations/folder/manage-access-policies.md#view-assigned), что политика была удалена.

- API {#api}

  Воспользуйтесь методом REST API [unbindAccessPolicy](../../../resource-manager/api-ref/Folder/unbindAccessPolicy.md) для ресурса [Folder](../../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UnbindAccessPolicy](../../../resource-manager/api-ref/grpc/Folder/unbindAccessPolicy.md).

{% endlist %}

Указанная политика авторизации перестанет применяться к ресурсам в заданном каталоге.

## Удалить политику авторизации, созданную для облака {#cloud}

Чтобы удалить политику авторизации, созданную для [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Получите](../../../resource-manager/operations/cloud/manage-access-policies.md#view-assigned) список идентификаторов шаблонов политик авторизации, назначенных на облако.
  1. Выполните команду:

      ```bash
      yc resource-manager cloud unbind-access-policy \
        --name <имя_облака> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя облака, для которого вы хотите удалить политику. Вместо имени облака вы можете указать его [идентификатор](../../../resource-manager/operations/cloud/get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона политики авторизации, которую вы хотите удалить у указанного облака.
  1. [Убедитесь](../../../resource-manager/operations/cloud/manage-access-policies.md#view-assigned), что политика была удалена.

- API {#api}

  Воспользуйтесь методом REST API [unbindAccessPolicy](../../../resource-manager/api-ref/Cloud/unbindAccessPolicy.md) для ресурса [Cloud](../../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/UnbindAccessPolicy](../../../resource-manager/api-ref/grpc/Cloud/unbindAccessPolicy.md).

{% endlist %}

Указанная политика авторизации перестанет применяться к ресурсам внутри всех каталогов в пределах заданного облака.

## Удалить политику авторизации, созданную для организации {#organization}

Чтобы удалить политику авторизации, созданную для [организации](../../../organization/concepts/organization.md):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Получите](../../../organization/operations/manage-access-policies.md#view-assigned) список идентификаторов шаблонов политик авторизации, назначенных на организацию.
  1. Выполните команду:

      ```bash
      yc organization-manager organization unbind-access-policy \
        --name <имя_организации> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя организации, для которой вы хотите удалить политику. Вместо имени организации вы можете указать ее [идентификатор](../../../organization/operations/organization-get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона политики авторизации, которую вы хотите удалить у указанной организации.
  1. [Убедитесь](../../../organization/operations/manage-access-policies.md#view-assigned), что политика была удалена.

- API {#api}

  Воспользуйтесь методом REST API [unbindAccessPolicy](../../../organization/api-ref/Organization/unbindAccessPolicy.md) для ресурса [Organization](../../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UnbindAccessPolicy](../../../organization/api-ref/grpc/Organization/unbindAccessPolicy.md).

{% endlist %}

Указанная политика авторизации перестанет применяться к ресурсам внутри всех облаков в пределах заданной организации.

#### См. также {#see-also}

* [Политики авторизации](../../concepts/access-control/access-policies.md)
* [Получение списка поддерживаемых шаблонов политик авторизации](list.md)
* [Создание политики авторизации для ресурса](assign.md)
* [Просмотр политик авторизации, созданных для ресурса](view-assigned.md)