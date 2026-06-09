# Посмотреть список используемых адресов в подсети

Вы можете посмотреть [внутренние IP-адреса](../concepts/address.md#internal-addresses), которые назначены облачным ресурсам в вашем каталоге.

Чтобы посмотреть список используемых внутренних адресов в подсети:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где расположена подсеть.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. Нажмите на имя подсети.
  1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.subnetworks.switch_ip-addresses }}**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   1. Просмотрите описание команды CLI для получения списка используемых адресов:

      ```bash
      yc vpc subnet list-used-addresses --help
      ```

   1. Получите список адресов в выбранной подсети:

      ```bash
      yc vpc subnet list-used-addresses --name <имя_подсети>
      ```

      Результат:

      ```text
      +-----------+------------+---------------------------------------+
      |  ADDRESS  | IP VERSION |              REFERENCES               |
      +-----------+------------+---------------------------------------+
      | 10.1.2.1  | IPV4       | vpc.virtualGateway:                   |
      | 10.1.2.2  | IPV4       | vpc.virtualDns:                       |
      | 10.1.2.3  | IPV4       | compute.instance:epdf6lfsaki9******** |
      | 10.1.2.15 | IPV4       | compute.instance:epdb2hmhj935******** |
      | 10.1.2.28 | IPV4       | managedKubernetes.cluster:            |
      +-----------+------------+---------------------------------------+
      ```

- API {#api}

   Воспользуйтесь методом REST API [listUsedAddresses](../api-ref/Subnet/listUsedAddresses.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/ListUsedAddresses](../api-ref/grpc/Subnet/listUsedAddresses.md) и передайте в запросе идентификатор изменяемой подсети в параметре `subnetId`.

   Чтобы узнать идентификатор подсети, воспользуйтесь методом REST API [list](../api-ref/Subnet/list.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/List](../api-ref/grpc/Subnet/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

   О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

{% endlist %}