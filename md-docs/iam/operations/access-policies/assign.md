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

Чтобы создать для [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) политику авторизации на основе [шаблона без дополнительных параметров](../../concepts/access-control/access-policies.md#fixed):

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

Чтобы создать для [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) политику авторизации на основе [шаблона без дополнительных параметров](../../concepts/access-control/access-policies.md#fixed):

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

Чтобы создать для [организации](../../../organization/concepts/organization.md) политику авторизации на основе [шаблона без дополнительных параметров](../../concepts/access-control/access-policies.md#fixed):

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

Все шаблоны политик авторизации [без дополнительных параметров](../../concepts/access-control/access-policies.md#fixed) назначаются на ресурсы одинаково. О том, как назначить на ресурс шаблон политики [с дополнительными параметрами](../../concepts/access-control/access-policies.md#customizable), читайте в разделе [Примеры](#examples).

## Примеры {#examples}

### Создать политику serverless.restrictPrivateNetworkInvocation для каталога {#serverless-restrictPrivateNetworkInvocation}

[Политика](../../concepts/access-control/access-policies.md#serverless-restrictPrivateNetworkInvocation) `serverless.restrictPrivateNetworkInvocation` ограничивает возможность вызова [функций](../../../functions/concepts/function.md) и [контейнеров](../../../serverless-containers/concepts/container.md) с [внутренних IP-адресов](../../../vpc/concepts/address.md#internal-addresses) Yandex Virtual Private Cloud заданными явно [облачными сетями](../../../vpc/concepts/network.md#network) или определенными IP-адресами в них.

{% note info %}

Политика `serverless.restrictPrivateNetworkInvocation` работает только при настроенном [сервисном подключении](../../../vpc/concepts/private-endpoint.md) из [Yandex Cloud Functions](../../../functions/index.md) и [Yandex Serverless Containers](../../../serverless-containers/index.md) в [Yandex Virtual Private Cloud](../../../vpc/index.md).

{% endnote %}

Чтобы назначить шаблон политики `serverless.restrictPrivateNetworkInvocation` на каталог:

{% list tabs group=instructions %}

- CLI {#cli}

  **Без ограничения по IP-адресам**

  ```bash
  yc resource-manager folder bind-access-policy \
    --name "my-folder" \
    --access-policy-template-id=serverless.restrictPrivateNetworkInvocation \
    --parameters '"allowed_vpc_network_ids=[<идентификатор_сети_1>,<идентификатор_сети_2>,<идентификатор_сети_3>]","src_ip_restricted_network_ids=[]","allowed_src_ips=[]"'
  ```

  Где `allowed_vpc_network_ids` — список идентификаторов облачных сетей, из которых разрешен вызов функций и контейнеров. Вызов функций и контейнеров будет разрешен с любых IP-адресов в [подсетях](../../../vpc/concepts/network.md#subnet), входящих в указанные облачные сети. При этом к функции/контейнеру должна быть привязана облачная сеть, входящая в указанный список.

  Для параметра можно передать нулевое значение — в этом случае необходимо задать ограничение по IP-адресам в параметрах `src_ip_restricted_network_ids` и `allowed_src_ips`.

  В результате применения политики в каталоге `my-folder` с внутренних IP-адресов можно будет вызывать только те функции/контейнеры, к которым привязаны облачные сети с идентификаторами `<идентификатор_сети_1>`, `<идентификатор_сети_2>` и `<идентификатор_сети_3>`, и только с IP-адресов подсетей, относящихся к этим облачным сетям.

  **С ограничением по IP-адресам**

  ```bash
  yc resource-manager folder bind-access-policy \
    --name "my-folder" \
    --access-policy-template-id=serverless.restrictPrivateNetworkInvocation \
    --parameters '"allowed_vpc_network_ids=[]","src_ip_restricted_network_ids=[<идентификатор_сети_1>,<идентификатор_сети_2>,<идентификатор_сети_3>]","allowed_src_ips=[10.1.2.0/24,172.16.17.0/28,192.168.1.2/32]"'
  ```

  Где:

  * `src_ip_restricted_network_ids` — список идентификаторов облачных сетей, из которых возможен вызов функций и контейнеров, с дополнительным ограничением разрешенных IP-адресов. Вызов функций и контейнеров будет разрешен с конкретных IP-адресов, входящих в указанные облачные сети и явно заданных в параметре `allowed_src_ips`. При этом к функции/контейнеру должна быть привязана облачная сеть, входящая в указанный список.
  * `allowed_src_ips` — список внутренних IP-адресов или диапазонов IP-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), с которых разрешен вызов функций и контейнеров.

      Указанные IP-адреса должны принадлежать облачным сетям, заданным в параметре `src_ip_restricted_network_ids`.

  В результате применения политики в каталоге `my-folder` с внутренних IP-адресов можно будет вызывать только те функции/контейнеры, к которым привязаны облачные сети с идентификаторами `<идентификатор_сети_1>`, `<идентификатор_сети_2>` и `<идентификатор_сети_3>`, и только с IP-адресов, относящихся одновременно к этим облачным сетям и к диапазонам `10.1.2.0/24`, `172.16.17.0/28` и `192.168.1.2/32`.

{% endlist %}

{% note info %}

Если параметр `allowed_vpc_network_ids` имеет ненулевое значение, то список IP-адресов, заданный параметрами `src_ip_restricted_network_ids` и `allowed_src_ips`, будет проигнорирован.

{% endnote %}

### Создать политику serverless.restrictPublicInvocation для каталога {#serverless-restrictPublicInvocation}

[Политика](../../concepts/access-control/access-policies.md#serverless-restrictPublicInvocation) `serverless.restrictPublicInvocation` ограничивает возможность вызова [функций](../../../functions/concepts/function.md) и [контейнеров](../../../serverless-containers/concepts/container.md) с [публичных IP-адресов](../../../vpc/concepts/address.md#internal-addresses).

Чтобы назначить шаблон политики `serverless.restrictPublicInvocation` на каталог:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc resource-manager folder bind-access-policy \
    --name "my-folder" \
    --access-policy-template-id=serverless.restrictPublicInvocation \
    --parameters '"allowed_src_ips=[198.51.100.104/29,192.0.2.4/30]"'
  ```

  Где `allowed_src_ip` — список публичных IP-адресов или диапазонов IP-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), с которых разрешен вызов функций и контейнеров.

  В результате применения политики в каталоге `my-folder` с использованием публичных IP-адресов функции/контейнеры можно будет вызывать только с IP-адресов, относящихся к диапазонам `198.51.100.104/29` и `192.0.2.4/30`.

{% endlist %}

#### См. также {#see-also}

* [Политики авторизации](../../concepts/access-control/access-policies.md)
* [Получение списка поддерживаемых шаблонов политик авторизации](list.md)
* [Просмотр политик авторизации, созданных для ресурса](view-assigned.md)
* [Удаление политики авторизации](revoke.md)