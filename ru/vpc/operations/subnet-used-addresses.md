# Посмотреть список используемых адресов в подсети

Вы можете посмотреть внутренние IP-адреса, которые назначены облачным ресурсам в вашем каталоге.

Чтобы посмотреть список используемых внутренних адресов в подсети:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где расположена подсеть.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. Нажмите на имя подсети.
  1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.subnetworks.switch_ip-addresses }}**.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

   Воспользуйтесь методом REST API [listUsedAddresses](../api-ref/Subnet/listUsedAddresses) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/ListUsedAddresses](../api-ref/grpc/subnet_service.md#ListUsedAddresses) и передайте в запросе идентификатор изменяемой подсети в параметре `subnetId`.

   {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

   {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}
