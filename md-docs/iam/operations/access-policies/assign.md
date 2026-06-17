# Создание политики авторизации для ресурса

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

[Политики авторизации](../../concepts/access-control/access-policies.md) — это механизм контроля доступа Yandex Identity and Access Management, который позволяет управлять разрешениями на выполнение определенных операций с [ресурсами Yandex Cloud](../../../overview/roles-and-resources.md). Политики авторизации создаются на основе [шаблонов](../../concepts/access-control/access-policies.md#supported-policies) и дополняют систему [ролей](../../concepts/access-control/roles.md), делая [управление доступом](../../concepts/access-control/index.md) более гибким.

Вы можете создать политику авторизации для [каталога](#folder), [облака](#cloud) или [организации](#organization).

{% note info %}

Управлять политиками авторизации может пользователь, которому назначена одна из следующих ролей:

* [`resource-manager.admin`](../../../resource-manager/security/index.md#resource-manager-admin) или [`admin`](../../roles-reference.md#admin) на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) или [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud), чтобы управлять политиками авторизации соответственно на уровне каталога или облака;
* [`organization-manager.admin`](../../../organization/security/index.md#organization-manager-admin) или [`admin`](../../roles-reference.md#admin) на [организацию](../../../organization/concepts/organization.md), чтобы управлять политиками авторизации на уровне организации.

{% endnote %}

## Создать политику авторизации для каталога {#folder}

Чтобы создать для [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) политику авторизации на основе [шаблона без параметров](../../concepts/access-control/access-policies.md#fixed):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Получите](list.md) список поддерживаемых шаблонов политик авторизации с идентификаторами.
  1. Выполните команду:

      ```bash
      yc resource-manager folder bind-access-policy \
        --name <имя_каталога> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя каталога, для которого вы хотите создать политику. Вместо имени каталога вы можете указать его [идентификатор](../../../resource-manager/operations/folder/get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона, на основе которого вы хотите создать политику авторизации для указанного каталога.
  1. [Убедитесь](../../../resource-manager/operations/folder/manage-access-policies.md#view-assigned), что политика была создана.

- API {#api}

  Воспользуйтесь методом REST API [bindAccessPolicy](../../../resource-manager/api-ref/Folder/bindAccessPolicy.md) для ресурса [Folder](../../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/BindAccessPolicy](../../../resource-manager/api-ref/grpc/Folder/bindAccessPolicy.md).

{% endlist %}

Созданная политика авторизации будет применяться ко всем ресурсам в заданном каталоге.

## Создать политику авторизации для облака {#cloud}

Чтобы создать для [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) политику авторизации на основе [шаблона без параметров](../../concepts/access-control/access-policies.md#fixed):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Получите](list.md) список поддерживаемых шаблонов политик авторизации с идентификаторами.
  1. Выполните команду:

      ```bash
      yc resource-manager cloud bind-access-policy \
        --name <имя_облака> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя облака, для которого вы хотите создать политику. Вместо имени облака вы можете указать его [идентификатор](../../../resource-manager/operations/cloud/get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона, на основе которого вы хотите создать политику авторизации для указанного облака.
  1. [Убедитесь](../../../resource-manager/operations/cloud/manage-access-policies.md#view-assigned), что политика была создана.

- API {#api}

  Воспользуйтесь методом REST API [bindAccessPolicy](../../../resource-manager/api-ref/Cloud/bindAccessPolicy.md) для ресурса [Cloud](../../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/BindAccessPolicy](../../../resource-manager/api-ref/grpc/Cloud/bindAccessPolicy.md).

{% endlist %}

Созданная политика авторизации будет применяться к ресурсам внутри всех каталогов в пределах заданного облака.

## Создать политику авторизации для организации {#organization}

Чтобы создать для [организации](../../../organization/concepts/organization.md) политику авторизации на основе [шаблона без параметров](../../concepts/access-control/access-policies.md#fixed):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Получите](list.md) список поддерживаемых шаблонов политик авторизации с идентификаторами.
  1. Выполните команду:

      ```bash
      yc organization-manager organization bind-access-policy \
        --name <имя_организации> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя организации, для которой вы хотите создать политику. Вместо имени организации вы можете указать ее [идентификатор](../../../organization/operations/organization-get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона, на основе которого вы хотите создать политику авторизации для указанной организации.
  1. [Убедитесь](../../../organization/operations/manage-access-policies.md#view-assigned), что политика была создана.

- API {#api}

  Воспользуйтесь методом REST API [bindAccessPolicy](../../../organization/api-ref/Organization/bindAccessPolicy.md) для ресурса [Organization](../../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/BindAccessPolicy](../../../organization/api-ref/grpc/Organization/bindAccessPolicy.md).

{% endlist %}

Созданная политика авторизации будет применяться к ресурсам внутри всех облаков в пределах заданной организации.

Все шаблоны политик авторизации [без параметров](../../concepts/access-control/access-policies.md#fixed) назначаются на ресурсы одинаково. О том, как назначить на ресурс шаблон политики [с параметрами](../../concepts/access-control/access-policies.md#customizable), читайте в разделе [Примеры](#examples).

## Примеры {#examples}

### Создать политику авторизации для каталога на основе шаблона serverless.containers.restrictNetworkAccess {#serverless-containers-restrictNetworkAccess}

[Политика](../../concepts/access-control/access-policies.md#serverless-containers-restrictNetworkAccess) `serverless.containers.restrictNetworkAccess` запрещает вызов [контейнеров](../../../serverless-containers/concepts/container.md) Yandex Serverless Containers и управление ими с любых адресов, за исключением заданных явно IP-адресов или [облачных сетей](../../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud.

Чтобы назначить шаблон политики `serverless.containers.restrictNetworkAccess` на каталог:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc resource-manager folder bind-access-policy \
    --name my-folder \
    --access-policy-template-id=serverless.containers.restrictNetworkAccess \
    --parameters '"allowed_src_ips=[<диапазон_адресов_1>,<диапазон_адресов_2>,<диапазон_адресов_3>]","allowed_vpc_network_ids=[<идентификатор_сети_1>,<идентификатор_сети_2>,<идентификатор_сети_3>]"'
  ```

  Где:
  
  * `--parameters` — параметры политики авторизации:

      {% note alert %}

      Ограничения, задаваемые в параметрах, применяются с логикой `ИЛИ`. 

      {% endnote %}

      * `allowed_src_ips` — список IP-адресов или диапазонов IP-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), с которых будет разрешен вызов контейнеров и управление ими.

          Если вы не хотите задавать список IP-адресов или диапазонов IP-адресов, передайте в параметре пустой список: `"allowed_src_ips=[]"`.
      * `allowed_vpc_network_ids` — список идентификаторов [облачных сетей](../../../vpc/concepts/network.md#network), в которых разрешен вызов контейнеров и управление ими через настроенное [сервисное подключение](../../../vpc/concepts/private-endpoint.md).

          Если вы не хотите задавать список идентификаторов облачных сетей, передайте в параметре пустой список: `"allowed_vpc_network_ids=[]"`.

{% endlist %}


#### Полезные ссылки {#see-also}

* [Политики авторизации](../../concepts/access-control/access-policies.md)
* [Получение списка поддерживаемых шаблонов политик авторизации](list.md)
* [Просмотр политик авторизации, созданных для ресурса](view-assigned.md)
* [Удаление политики авторизации](revoke.md)