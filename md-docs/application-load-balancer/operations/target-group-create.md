# Создать целевую группу Application Load Balancer

Создайте [виртуальные машины](../../compute/concepts/vm.md) в рабочем [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) по [инструкции](../../compute/operations/index.md#vm-create).

Чтобы создать [целевую группу](../concepts/target-group.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создаваться целевая группа.
  1. Перейдите в сервис **Application Load Balancer**.
  1. На панели слева выберите ![image](../../_assets/console-icons/target.svg) **Целевые группы**.
  1. Нажмите кнопку **Создать целевую группу**.
  1. Введите имя и описание целевой группы.
  1. В блоке **Целевые ресурсы** выберите ВМ из списка или добавьте целевой ресурс вручную:
     1. В поле **IP-адрес** укажите адрес ресурса и выберите [подсеть](../../vpc/concepts/network.md#subnet).
     1. (Опционально) Если [IP-адрес](../../vpc/concepts/address.md) ресурса находится вне [Yandex Virtual Private Cloud](../../vpc/index.md), выберите опцию **Не из VPC**.

        Например, укажите частный IPv4-адрес из вашего ЦОД, подключенного к Yandex Cloud через [Yandex Cloud Interconnect](../../interconnect/index.md). Адрес должен входить в [частные диапазоны из RFC 1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3). Подробнее в разделе [Подсети](../../vpc/concepts/network.md#subnet).


     1. Нажмите **Добавить целевой ресурс**.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/index.md) для создания целевой группы:

     ```bash
     yc alb target-group create --help
     ```

  1. Выполните команду, указав в параметрах имя целевой группы, имя [подсети](../../vpc/concepts/network.md#subnet) и [внутренние IP-адреса](../../vpc/concepts/address.md#internal-addresses) ВМ:

     ```bash
     yc alb target-group create \
       --name <имя_целевой_группы> \
       --target subnet-name=<имя_подсети>,ip-address=<внутренний_IP-адрес_ВМ_1> \
       --target subnet-name=<имя_подсети>,ip-address=<внутренний_IP-адрес_ВМ_2> \
       --target subnet-name=<имя_подсети>,ip-address=<внутренний_IP-адрес_ВМ_3>
     ```

     Результат:

      ```text
      id: a5d751meibht********
      name: <имя_целевой_группы>
      folder_id: aoerb349v3h4********
      targets:
      - ip_address: <внутренний_IP-адрес_ВМ_1>
        subnet_id: fo2tgfikh3he********
      - ip_address: <внутренний_IP-адрес_ВМ_2>
        subnet_id: fo2tgfikh3he********
      - ip_address: <внутренний_IP-адрес_ВМ_3>
        subnet_id: fo2tgfikh3he********
      created_at: "2021-02-11T11:16:27.770674538Z
      ```

      Также вы можете создать целевую группу с ресурсами, которые размещены вне [Yandex Virtual Private Cloud](../../vpc/index.md), например в вашем ЦОД, подключенном к Yandex Cloud через [Yandex Cloud Interconnect](../../interconnect/index.md). Адреса ресурсов должны входить в [частные диапазоны из RFC 1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3). Подробнее в разделе [Подсети](../../vpc/concepts/network.md#subnet).


      Выполните команду, указав в параметрах имя целевой группы и частные IPv4-адреса ресурсов:

      ```bash
      yc alb target-group create \
        --name <имя_целевой_группы> \
        --target private-ip-address=true,ip-address=<частный_IPv4-адрес_ресурса_1> \
        --target private-ip-address=true,ip-address=<частный_IPv4-адрес_ресурса_2> \
        --target private-ip-address=true,ip-address=<частный_IPv4-адрес_ресурса_3>
      ```

      Результат:

      ```text
      id: ds7s2dld2usr********
      name: <имя_целевой_группы>
      folder_id: aoerb349v3h4********
      targets:
        - ip_address: <частный_IPv4-адрес_ресурса_1>
          private_ipv4_address: true
        - ip_address: <частный_IPv4-адрес_ресурса_2>
          private_ipv4_address: true
        - ip_address: <частный_IPv4-адрес_ресурса_3>
          private_ipv4_address: true
      created_at: "2023-07-25T08:55:14.172526884Z"
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле Terraform параметры ресурса, который необходимо создать:

     ```hcl
     resource "yandex_alb_target_group" "foo" {
       name           = "<имя_целевой_группы>"

       target {
         subnet_id    = "<идентификатор_подсети>"
         ip_address   = "<внутренний_IP-адрес_ВМ_1>"
       }

       target {
         subnet_id    = "<идентификатор_подсети>"
         ip_address   = "<внутренний_IP-адрес_ВМ_2>"
       }

       target {
         subnet_id    = "<идентификатор_подсети>"
         ip_address   = "<внутренний_IP-адрес_ВМ_3>"
       }
     }
     ```

     Где `yandex_alb_target_group` — параметры целевой группы:
     * `name` — имя целевой группы.
     * `target` — параметры целевого ресурса:
       * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet), в которой размещена ВМ. Получить список доступных подсетей можно с помощью команды [CLI](../../cli/index.md): `yc vpc subnet list`.
       * `ip_address` — внутренний IP-адрес ВМ. Получить список [внутренних IP-адресов](../../vpc/concepts/address.md#internal-addresses) можно с помощью команды CLI: `yc vpc subnet list-used-addresses --id <идентификатор_подсети>`.

     Также вы можете создать целевую группу с ресурсами, которые размещены вне [Yandex Virtual Private Cloud](../../vpc/index.md), например в вашем ЦОД, подключенном к Yandex Cloud через [Yandex Cloud Interconnect](../../interconnect/index.md):

     ```hcl
     resource "yandex_alb_target_group" "foo" {
       name                   = "<имя_целевой_группы>"

       target {
         private_ipv4_address = true
         ip_address           = "<частный_IPv4-адрес_ресурса_1>"
       }

       target {
         private_ipv4_address = true
         ip_address           = "<частный_IPv4-адрес_ресурса_2>"
       }

       target {
         private_ipv4_address = true
         ip_address           = "<частный_IPv4-адрес_ресурса_3>"
       }
     }
     ```


     Где `yandex_alb_target_group` — параметры целевой группы:
     * `name` — имя целевой группы.
     * `target` — параметры целевого ресурса:
       * `private_ipv4_address` — параметр, который означает, что IP-адрес находится вне Virtual Private Cloud.
       * `ip_address` — частный IPv4-адрес ресурса. Адреса должны входить в [частные диапазоны из RFC 1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3). Подробнее в разделе [Подсети](../../vpc/concepts/network.md#subnet).

     Подробнее о параметрах ресурса `yandex_alb_target_group` в [документации провайдера](../../terraform/resources/alb_target_group.md).
  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc alb target-group list
     ```

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на выполнение операций с целевыми группами Application Load Balancer 10 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию целевой группы блок `timeouts`, например:
     
     ```hcl
     resource "yandex_alb_target_group" "<имя_целевой_группы>" {
       ...
       timeouts {
         create = "60m"
         update = "60m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/TargetGroup/create.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/Create](../api-ref/grpc/TargetGroup/create.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Отказоустойчивый сайт с балансировкой нагрузки через Yandex Application Load Balancer](../tutorials/application-load-balancer-website/index.md)
* [Запись логов балансировщика в PostgreSQL](../tutorials/logging.md)
* [Создание L7-балансировщика с защитой от DDoS с помощью консоли управления или CLI](../tutorials/alb-with-ddos-protection/console.md)