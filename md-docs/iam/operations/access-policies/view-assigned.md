[Документация Yandex Cloud](../../../index.md) > [Yandex Identity and Access Management](../../index.md) > [Пошаговые инструкции](../index.md) > Политики авторизации > Просмотр политик, созданных для ресурса

# Просмотр политик авторизации, созданных для ресурса

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

[Политики авторизации](../../concepts/access-control/access-policies.md) — это механизм контроля доступа Yandex Identity and Access Management, который позволяет управлять разрешениями на выполнение определенных операций с [ресурсами Yandex Cloud](../../../overview/roles-and-resources.md). Политики авторизации создаются на основе [шаблонов](../../concepts/access-control/access-policies.md#supported-policies) и дополняют систему [ролей](../../concepts/access-control/roles.md), делая [управление доступом](../../concepts/access-control/index.md) более гибким.

Политики авторизации могут быть созданы для [каталога](#folder), [облака](#cloud) или [организации](#organization).

{% note info %}

Управлять политиками авторизации может пользователь, которому назначена одна из следующих ролей:

* [`resource-manager.admin`](../../../resource-manager/security/index.md#resource-manager-admin) или [`admin`](../../roles-reference.md#admin) на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) или [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud), чтобы управлять политиками авторизации соответственно на уровне каталога или облака;
* [`organization-manager.admin`](../../../organization/security/index.md#organization-manager-admin) или [`admin`](../../roles-reference.md#admin) на [организацию](../../../organization/concepts/organization.md), чтобы управлять политиками авторизации на уровне организации.

{% endnote %}

## Просмотр политик авторизации, созданных для каталога {#folder}

Чтобы посмотреть список политик авторизации, созданных для [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Выполните команду, указав имя или [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, для которого вы хотите посмотреть созданные политики:

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

  Воспользуйтесь методом REST API [listAccessPolicyBindings](../../../resource-manager/api-ref/Folder/listAccessPolicyBindings.md) для ресурса [Folder](../../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/ListAccessPolicyBindings](../../../resource-manager/api-ref/grpc/Folder/listAccessPolicyBindings.md).

{% endlist %}

## Просмотр политик авторизации, созданных для облака {#cloud}

Чтобы посмотреть список политик авторизации, созданных для [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Выполните команду, указав имя или [идентификатор](../../../resource-manager/operations/cloud/get-id.md) облака, для которого вы хотите посмотреть созданные политики:

  ```bash
  yc resource-manager cloud list-access-policy-bindings <имя_или_идентификатор_облака>
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

  Воспользуйтесь методом REST API [listAccessPolicyBindings](../../../resource-manager/api-ref/Cloud/listAccessPolicyBindings.md) для ресурса [Cloud](../../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/ListAccessPolicyBindings](../../../resource-manager/api-ref/grpc/Cloud/listAccessPolicyBindings.md).

{% endlist %}

## Просмотр политик авторизации, созданных для организации {#organization}

Чтобы посмотреть список политик авторизации, созданных для [организации](../../../organization/concepts/organization.md):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Выполните команду, указав имя или [идентификатор](../../../organization/operations/organization-get-id.md) организации, для которой вы хотите посмотреть созданные политики:

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

  Воспользуйтесь методом REST API [listAccessPolicyBindings](../../../organization/api-ref/Organization/listAccessPolicyBindings.md) для ресурса [Organization](../../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/ListAccessPolicyBindings](../../../organization/api-ref/grpc/Organization/listAccessPolicyBindings.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Политики авторизации](../../concepts/access-control/access-policies.md)
* [Получение списка поддерживаемых шаблонов политик авторизации](list.md)
* [Создание политики авторизации для ресурса](assign.md)
* [Удаление политики авторизации](revoke.md)