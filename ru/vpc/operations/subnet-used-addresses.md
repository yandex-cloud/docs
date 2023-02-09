# Посмотреть список используемых адресов в подсети

Вы можете посмотреть внутренние IP-адреса, которые назначены облачным ресурсам в вашем каталоге.

Чтобы посмотреть список используемых внутренних адресов в подсети:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где расположена подсеть.
  1. В списке сервисов выберите **{{ vpc-name }}**.
   1. Выберите вкладку **Подсети**.
   1. Нажмите на имя подсети.
   1. Перейдите на вкладку **IP-Адреса**.

- CLI

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

      ```bash
      +-----------+------------+---------------------------------------+
      |  ADDRESS  | IP VERSION |              REFERENCES               |
      +-----------+------------+---------------------------------------+
      | 10.1.2.1  | IPV4       | vpc.virtualGateway:                   |
      | 10.1.2.2  | IPV4       | vpc.virtualDns:                       |
      | 10.1.2.3  | IPV4       | compute.instance:epdf6lfsaki9p76hj7rf |
      | 10.1.2.15 | IPV4       | compute.instance:epdb2hmhj935jhjk98gd |
      | 10.1.2.28 | IPV4       | managedKubernetes.cluster:            |
      +-----------+------------+---------------------------------------+
      ```

- API

  Воспользуйтесь вызовом gRPC API [SubnetService/ListUsedAddresses](../api-ref/grpc/subnet_service.md#ListUsedAddresses).

{% endlist %}
