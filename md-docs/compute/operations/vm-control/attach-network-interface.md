# Добавить дополнительный сетевой интерфейс на виртуальную машину


У виртуальной машины может быть один или несколько [сетевых интерфейсов](../../concepts/network.md). Подробнее о максимальном количестве сетевых интерфейсов на ВМ в разделе [Квоты и лимиты в Compute Cloud](../../concepts/limits.md). 

Добавить сетевые интерфейсы можно как на [запущенные](#add-to-running), так и на [остановленные](#add-to-stopped) ВМ. Для сохранения [сетевой связности](../../../vpc/concepts/routing.md#rt-vm) рекомендуется добавлять сетевые интерфейсы на остановленные ВМ.

{% note tip %}

Если вы хотите привязать к ВМ публичный IP-адрес, то воспользуйтесь [инструкцией](vm-attach-public-ip.md).

{% endnote %}

## Добавление сетевого интерфейса на остановленную ВМ {#add-to-stopped}

Чтобы добавить дополнительный интерфейс на виртуальную машину:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. Выберите ВМ, которой необходимо добавить дополнительный сетевой интерфейс.
  1. На вкладке **Обзор** в блоке **Сетевые настройки** нажмите кнопку **Добавить сетевой интерфейс**.
  1. В открывшемся окне укажите параметры сетевого интерфейса:

     * **Номер сетевого интерфейса** — отвечает за порядок подключения сетевых интерфейсов. Каждый сетевой интерфейс ВМ должен иметь уникальный номер.
     * **Подсеть** — укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../../vpc/concepts/network.md#network) из списка. Если подсети нет, нажмите **Создать подсеть** и [создайте](../../../vpc/operations/subnet-create.md) ее.
     * В поле **Публичный IP-адрес** выберите способ назначения адреса:

       * `Автоматически` — назначить случайный IP-адрес из пула адресов Yandex Cloud. В этом случае можно включить [защиту от DDoS-атак](../../../vpc/ddos-protection/index.md) при помощи соответствующей опции.
       * `Список` — выбрать публичный IP-адрес из списка зарезервированных заранее статических адресов. Подробнее читайте в разделе [Сделать динамический публичный IP-адрес статическим](../../../vpc/operations/set-static-ip.md).
       * `Без адреса` — не назначать публичный IP-адрес.

     * **Группы безопасности** — выберите [группы безопасности](../../../vpc/concepts/security-groups.md). Если оставить поле пустым, виртуальной машине будет назначена группа безопасности по умолчанию.
     * Разверните блок **Дополнительно** и в поле **Внутренний IPv4 адрес** выберите способ назначения внутренних адресов:

       * `Автоматически` — чтобы назначить случайный IP-адрес из пула адресов, доступных в выбранной подсети.
       * `Вручную` — чтобы задать внутренний IP-адрес ВМ вручную.
       * При необходимости включите опцию **Защита от DDoS-атак**. Опция доступна, если ранее в настройках публичного адреса вы выбрали автоматический способ назначения адреса.

     * (Опционально) Создайте записи для ВМ в [зоне DNS](../../../dns/concepts/dns-zone.md):
     
       * Разверните блок **Настройки DNS для внутренних адресов** и нажмите **Добавить запись**.
       * Укажите зону, FQDN и время жизни записи. При указании FQDN для зоны доступна опция `Определять автоматически`.
       
         Вы можете добавить несколько записей во [внутренние зоны](../../../dns/concepts/dns-zone.md) DNS. Подробнее см. [Интеграция Cloud DNS с Compute Cloud](../../../dns/concepts/compute-integration.md).

       * Чтобы создать еще одну запись, нажмите кнопку **Добавить запись**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для добавления сетевого интерфейса на виртуальную машину:

      ```bash
      yc compute instance attach-network-interface --help
      ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      ```bash
      yc compute instance list
      ```
      
      Результат:
      ```text
      +----------------------+-----------------+---------------+---------+----------------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
      +----------------------+-----------------+---------------+---------+----------------------+
      | fhm0b28lgfp4******** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7g******** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
      +----------------------+-----------------+---------------+---------+----------------------+
      ```

      Сохраните идентификатор ВМ, на которую вы хотите добавить дополнительный сетевой интерфейс.

  1. Остановите выбранную ВМ, указав ее идентификатор:

      ```bash
      yc compute instance stop <идентификатор_ВМ>
      ```

  1. Получите список всех [подсетей](../../../vpc/concepts/network.md#subnet) в каталоге по умолчанию:

      ```bash
      yc vpc subnet list
      ```
      
      Результат:
      
      ```bash
      +----------------------+-----------------------+----------------------+----------------+---------------+-------------------+
      |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |       RANGE       |
      +----------------------+-----------------------+----------------------+----------------+---------------+-------------------+
      | bucqps2lt75g******** | subnet-ru-central1-a1 | c64pv6m0aqq6******** |                | ru-central1-a | [192.168.1.0/24]  |
      | e2lrucutusnd******** | subnet-ru-central1-a2 | c64pv6m0aqq6******** |                | ru-central1-a | [192.168.2.0/24]  |
      | e2lv9c6aek1d******** | subnet-ru-central1-a3 | c64pv6m0aqq6******** |                | ru-central1-a | [192.168.4.0/24]  |
      | bltign9kcffv******** | default-ru-central1-b | c64pv6m0aqq6******** |                | ru-central1-b | [192.168.3.0/24]  |
      +----------------------+-----------------------+----------------------+----------------+---------------+-------------------+
      ```

      Сохраните идентификатор подсети, которую вы хотите привязать к добавляемому сетевому интерфейсу ВМ. Подсеть должна находиться в той же [зоне доступности](../../../overview/concepts/geo-scope.md), что и виртуальная машина.

  1. Получите список всех [групп безопасности](../../../vpc/concepts/security-groups.md) в каталоге по умолчанию:

      ```bash
      yc vpc sg list
      ```
      
      Результат:
      
      ```bash
      +----------------------+---------------------------------+--------------------------------+----------------------+
      |          ID          |              NAME               |          DESCRIPTION           |      NETWORK-ID      |
      +----------------------+---------------------------------+--------------------------------+----------------------+
      | c646ev94tb6k******** | my-sg-group                     |                                | c64pv6m0aqq6******** |
      | c64r84tbt32j******** | default-sg-c64pv6m0aqq6******** | Default security group for     | c64pv6m0aqq6******** |
      |                      |                                 | network                        |                      |
      +----------------------+---------------------------------+--------------------------------+----------------------+
      ```

      Сохраните идентификаторы групп безопасности, которые вы хотите привязать к добавляемому сетевому интерфейсу ВМ. Группы безопасности должны находиться в той же [облачной сети](../../../vpc/concepts/network.md#network), что и привязываемая подсеть.

  1. Получите список занятых номеров сетевых интерфейсов выбранной ВМ, указав ее идентификатор:

      ```bash
      yc compute instance get <идентификатор_ВМ>
      ```

      Результат:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:b8:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.7
            one_to_one_nat:
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:ad:b8:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address: {}
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

      В приведенном примере сетевые интерфейсы с номерами `0` и `1` (значения полей `index`) заняты.

  1. Добавьте на выбранную ВМ новый сетевой интерфейс:

      ```bash
      yc compute instance attach-network-interface \
        --id <идентификатор_ВМ> \
        --subnet-id <идентификатор_подсети> \
        --network-interface-index <номер_сетевого_интерфейса> \
        --security-group-id <идентификатор_группы_безопасности> \
        --ipv4-address <внутренний_IP-адрес> \
        --nat-ip-version ipv4 \
        --nat-address <публичный_IP-адрес>
      ```
      
      Где:
      * `--id` — идентификатор выбранной виртуальной машины. Вместо идентификатора вы можете использовать параметр `--name`, чтобы указать имя ВМ.
      * `--subnet-id` — идентификатор подсети, которая будет подключена к добавляемому сетевому интерфейсу. Вместо идентификатора вы можете использовать параметр `--subnet-name`, чтобы указать имя подсети.
      * `--network-interface-index` — номер создаваемого сетевого интерфейса ВМ: число в диапазоне от `0` до `15`, за исключением уже занятых номеров.
      * `--security-group-id` — идентификатор группы безопасности, которая будет привязана к создаваемому сетевому интерфейсу. К одному сетевому интерфейсу вы можете привязать одновременно до пяти групп безопасности, для этого перечислите их идентификаторы через запятую.
      * `--ipv4-address` — внутренний IP-адрес, который будет назначен сетевому интерфейсу. Адрес должен относиться к диапазону адресов, входящих в подключаемую к интерфейсу подсеть. Укажите значение `auto`, чтобы внутренний IP-адрес был назначен автоматически из пула адресов, доступных в подсети.
      * `--nat-ip-version ipv4` — задайте этот параметр, если к создаваемому сетевому интерфейсу требуется привязать [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Если параметр `--nat-address` не задан, к сетевому интерфейсу будет привязан динамический публичный IP-адрес из пула доступных адресов Yandex Cloud.
      
          Если создаваемому интерфейсу не нужен публичный IP-адрес, исключите параметр `--nat-ip-version`.
      
      * `--nat-address` — заранее [зарезервированный](../../../vpc/operations/get-static-ip.md) статический публичный IP-адрес. Параметр можно задать только в том случае, если задан параметр `--nat-ip-version`. Указываемый IP-адрес должен быть зарезервирован в той же [зоне доступности](../../../overview/concepts/geo-scope.md), в которой расположена ВМ.

      Результат:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:b8:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.7
            one_to_one_nat:
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:ad:b8:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.4.20
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
        - index: "2"
          mac_address: d0:2d:b8:**:**:**
          subnet_id: e2lv9c6aek1d********
          primary_v4_address: {}
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

  1. Для того чтобы новому интерфейсу были назначены IP-адреса, запустите ВМ, указав ее идентификатор:

      ```bash
      yc compute instance start <идентификатор_ВМ>
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле в описании ресурса `yandex_compute_instance` добавьте новый блок `network_interface` и параметр `allow_stopping_for_update`:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {
        ...
        network_interface {
          index     = <номер_интерфейса>
          subnet_id = "<идентификатор_подсети>"
        }

        allow_stopping_for_update = true
        ...
      }
      ```

      Где:

      * `index` — номер сетевого интерфейса: число в диапазоне от `0` до `15`, исключая уже занятые номера. По умолчанию первому сетевому интерфейсу присваивается номер `0`.
      * `subnet_id` — идентификатор [подсети](../../../vpc/concepts/network.md#subnet).
      * `allow_stopping_for_update` — параметр для разрешения остановки ВМ на время обновления.

      Более подробную информацию о параметрах ресурса `yandex_compute_instance` читайте в [документации провайдера](../../../terraform/resources/compute_instance.md).

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

      Terraform создаст и обновит все требуемые ресурсы. Проверить изменения можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Воспользуйтесь методом REST API [attachNetworkInterface](../../api-ref/Instance/attachNetworkInterface.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/AttachNetworkInterface](../../api-ref/grpc/Instance/attachNetworkInterface.md).

{% endlist %}

У виртуальной машины появился новый сетевой интерфейс. [Убедитесь](#test), что он работает.


## Добавление сетевого интерфейса на работающую ВМ  {#add-to-running}

{% note info %}

Функциональность по добавлению и удалению сетевых интерфейсов на работающих ВМ находится на [стадии Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ к функциональности, [обратитесь](https://center.yandex.cloud/support) в техническую поддержку.

{% endnote %}

Чтобы добавить дополнительный интерфейс на виртуальную машину:

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для добавления сетевого интерфейса на виртуальную машину:

      ```bash
      yc compute instance attach-network-interface --help
      ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      ```bash
      yc compute instance list
      ```
      
      Результат:
      ```text
      +----------------------+-----------------+---------------+---------+----------------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
      +----------------------+-----------------+---------------+---------+----------------------+
      | fhm0b28lgfp4******** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7g******** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
      +----------------------+-----------------+---------------+---------+----------------------+
      ```

      Сохраните идентификатор ВМ, на которую вы хотите добавить дополнительный сетевой интерфейс.

  1. Получите список всех [подсетей](../../../vpc/concepts/network.md#subnet) в каталоге по умолчанию:

      ```bash
      yc vpc subnet list
      ```
      
      Результат:
      
      ```bash
      +----------------------+-----------------------+----------------------+----------------+---------------+-------------------+
      |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |       RANGE       |
      +----------------------+-----------------------+----------------------+----------------+---------------+-------------------+
      | bucqps2lt75g******** | subnet-ru-central1-a1 | c64pv6m0aqq6******** |                | ru-central1-a | [192.168.1.0/24]  |
      | e2lrucutusnd******** | subnet-ru-central1-a2 | c64pv6m0aqq6******** |                | ru-central1-a | [192.168.2.0/24]  |
      | e2lv9c6aek1d******** | subnet-ru-central1-a3 | c64pv6m0aqq6******** |                | ru-central1-a | [192.168.4.0/24]  |
      | bltign9kcffv******** | default-ru-central1-b | c64pv6m0aqq6******** |                | ru-central1-b | [192.168.3.0/24]  |
      +----------------------+-----------------------+----------------------+----------------+---------------+-------------------+
      ```

      Сохраните идентификатор подсети, которую вы хотите привязать к добавляемому сетевому интерфейсу ВМ. Подсеть должна находиться в той же [зоне доступности](../../../overview/concepts/geo-scope.md), что и виртуальная машина.

  1. Получите список всех [групп безопасности](../../../vpc/concepts/security-groups.md) в каталоге по умолчанию:

      ```bash
      yc vpc sg list
      ```
      
      Результат:
      
      ```bash
      +----------------------+---------------------------------+--------------------------------+----------------------+
      |          ID          |              NAME               |          DESCRIPTION           |      NETWORK-ID      |
      +----------------------+---------------------------------+--------------------------------+----------------------+
      | c646ev94tb6k******** | my-sg-group                     |                                | c64pv6m0aqq6******** |
      | c64r84tbt32j******** | default-sg-c64pv6m0aqq6******** | Default security group for     | c64pv6m0aqq6******** |
      |                      |                                 | network                        |                      |
      +----------------------+---------------------------------+--------------------------------+----------------------+
      ```

      Сохраните идентификаторы групп безопасности, которые вы хотите привязать к добавляемому сетевому интерфейсу ВМ. Группы безопасности должны находиться в той же [облачной сети](../../../vpc/concepts/network.md#network), что и привязываемая подсеть.

  1. Получите список занятых номеров сетевых интерфейсов выбранной ВМ, указав ее идентификатор:

      ```bash
      yc compute instance get <идентификатор_ВМ>
      ```

      Результат:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1a:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.20
            one_to_one_nat:
              address: 158.***.**.***
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:1d:1a:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.3
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

      В приведенном примере сетевые интерфейсы с номерами `0` и `1` (значения полей `index`) заняты.

  1. Добавьте на выбранную ВМ новый сетевой интерфейс:

      ```bash
      yc compute instance attach-network-interface \
        --id <идентификатор_ВМ> \
        --subnet-id <идентификатор_подсети> \
        --network-interface-index <номер_сетевого_интерфейса> \
        --security-group-id <идентификатор_группы_безопасности> \
        --ipv4-address <внутренний_IP-адрес> \
        --nat-ip-version ipv4 \
        --nat-address <публичный_IP-адрес>
      ```
      
      Где:
      * `--id` — идентификатор выбранной виртуальной машины. Вместо идентификатора вы можете использовать параметр `--name`, чтобы указать имя ВМ.
      * `--subnet-id` — идентификатор подсети, которая будет подключена к добавляемому сетевому интерфейсу. Вместо идентификатора вы можете использовать параметр `--subnet-name`, чтобы указать имя подсети.
      * `--network-interface-index` — номер создаваемого сетевого интерфейса ВМ: число в диапазоне от `0` до `15`, за исключением уже занятых номеров.
      * `--security-group-id` — идентификатор группы безопасности, которая будет привязана к создаваемому сетевому интерфейсу. К одному сетевому интерфейсу вы можете привязать одновременно до пяти групп безопасности, для этого перечислите их идентификаторы через запятую.
      * `--ipv4-address` — внутренний IP-адрес, который будет назначен сетевому интерфейсу. Адрес должен относиться к диапазону адресов, входящих в подключаемую к интерфейсу подсеть. Укажите значение `auto`, чтобы внутренний IP-адрес был назначен автоматически из пула адресов, доступных в подсети.
      * `--nat-ip-version ipv4` — задайте этот параметр, если к создаваемому сетевому интерфейсу требуется привязать [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Если параметр `--nat-address` не задан, к сетевому интерфейсу будет привязан динамический публичный IP-адрес из пула доступных адресов Yandex Cloud.
      
          Если создаваемому интерфейсу не нужен публичный IP-адрес, исключите параметр `--nat-ip-version`.
      
      * `--nat-address` — заранее [зарезервированный](../../../vpc/operations/get-static-ip.md) статический публичный IP-адрес. Параметр можно задать только в том случае, если задан параметр `--nat-ip-version`. Указываемый IP-адрес должен быть зарезервирован в той же [зоне доступности](../../../overview/concepts/geo-scope.md), в которой расположена ВМ.

      Результат:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1a:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.20
            one_to_one_nat:
              address: 158.***.**.***
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:1d:1a:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.3
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
        - index: "2"
          mac_address: d0:2d:1a:**:**:**
          subnet_id: e2lv9c6aek1d********
          primary_v4_address:
            address: 192.168.4.17
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

- API {#api}

  Воспользуйтесь методом REST API [attachNetworkInterface](../../api-ref/Instance/attachNetworkInterface.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/AttachNetworkInterface](../../api-ref/grpc/Instance/attachNetworkInterface.md).

{% endlist %}

У виртуальной машины появился новый сетевой интерфейс. При этом подключенный интерфейс находится в неактивном состоянии, потому что он был добавлен на работающую ВМ. Чтобы убедиться в этом:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Подключитесь](../vm-connect/ssh.md#vm-connect) к ВМ по SSH.
  1. Выполните команду, чтобы получить информацию о состоянии сетевых интерфейсов ВМ:

      ```bash
      ip a
      ```

      Результат:

      ```txt
      1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
          link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
          inet 127.0.0.1/8 scope host lo
             valid_lft forever preferred_lft forever
          inet6 ::1/128 scope host
             valid_lft forever preferred_lft forever
      ...
      4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
          link/ether d0:2d:1a:f4:20:ef brd ff:ff:ff:ff:ff:ff
          altname enp140s0
          altname ens10
      ```

      Состояние `state DOWN` для интерфейса с именем `eth2` означает, что сетевой интерфейс неактивен.

- Windows {#windows}

  1. [Подключитесь](../vm-connect/rdp.md) к ВМ по RDP.
  1. Запустите **Диспетчер устройств**, выполнив команду в PowerShell:

      ```powershell
      devmgmt.msc
      ```

  1. В открывшемся окне **Диспетчера устройств** раскройте секцию **Сетевые адаптеры** (**Network adapters**). Добавленный сетевой интерфейс помечен восклицательным знаком и неактивен.

{% endlist %}

Для того чтобы активировать добавленный сетевой интерфейс, [перезапустите](vm-stop-and-start.md#restart) ВМ. Для ОС Windows перезапуск ВМ — это единственный способ активировать интерфейс.

Если ваша ВМ под управлением ОС Linux и у вас нет возможности перезапустить ее, вы можете активировать сетевой интерфейс без перезапуска ВМ. При этом, чтобы избежать потери сетевой связности, выполнять настройки необходимо из [серийной консоли](../../concepts/serial-console.md):

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Включите](../serial-console/index.md#enable) на ВМ доступ к серийной консоли.

      При создании пользователя для аутентификации на ВМ через серийную консоль добавьте этого пользователя в группу `sudo` с помощью команды `sudo usermod -a -G sudo <имя_пользователя>`.

  1. [Подключитесь](../serial-console/connect-ssh.md) к серийной консоли ВМ с помощью Yandex Cloud CLI или по SSH.

  1. Активируйте добавленный сетевой интерфейс:

      ```bash
      sudo ip link set <имя_интерфейса> up
      ```

      Где `<имя_интерфейса>` — имя неактивного интерфейса в ОС Linux. Например: `eth2`. Посмотреть имена сетевых интерфейсов можно в терминале Linux с помощью команды `ip a`.

  1. Получите настройки DHCP для нового интерфейса:

      ```bash
      sudo dhclient <имя_интерфейса>
      ```

  1. Удалите из [таблицы маршрутизации ВМ](../../../vpc/concepts/routing.md#rt-vm) маршрут по умолчанию для нового сетевого интерфейса:

      ```bash
      sudo ip route del default dev <имя_интерфейса>
      ```

  1. [Отключите](../serial-console/index.md#disable) доступ к серийной консоли ВМ, если он вам больше не нужен.

{% endlist %}

Теперь подключенный сетевой интерфейс активен.


## Убедитесь в работоспособности нового сетевого интерфейса {#test}

Чтобы убедиться в работоспособности добавленного сетевого интерфейса:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Подключитесь](../vm-connect/ssh.md#vm-connect) к ВМ по SSH.
  1. Выполните команду, чтобы получить информацию о состоянии сетевых интерфейсов ВМ:

      ```bash
      ip a
      ```

      Результат:

      ```txt
      1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
          link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
          inet 127.0.0.1/8 scope host lo
             valid_lft forever preferred_lft forever
          inet6 ::1/128 scope host
             valid_lft forever preferred_lft forever
      2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
          link/ether d0:0d:b8:99:4f:fa brd ff:ff:ff:ff:ff:ff
          altname enp138s0
          altname ens8
          inet 192.168.2.7/24 metric 100 brd 192.168.2.255 scope global eth0
             valid_lft forever preferred_lft forever
          inet6 fe80::d20d:b8ff:fe99:4ffa/64 scope link
             valid_lft forever preferred_lft forever
      3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
          link/ether d0:2d:b8:99:4f:fa brd ff:ff:ff:ff:ff:ff
          altname enp139s0
          altname ens9
          inet 192.168.4.20/24 metric 200 brd 192.168.4.255 scope global eth1
             valid_lft forever preferred_lft forever
          inet6 fe80::d22d:b8ff:fe99:4ffa/64 scope link
             valid_lft forever preferred_lft forever
      4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
          link/ether d0:ad:b8:99:4f:fa brd ff:ff:ff:ff:ff:ff
          altname enp140s0
          altname ens10
          inet 192.168.1.28/24 metric 300 brd 192.168.1.255 scope global eth2
             valid_lft forever preferred_lft forever
          inet6 fe80::d2ad:b8ff:fe99:4ffa/64 scope link
             valid_lft forever preferred_lft forever
      ```

      Состояние `state UP` для интерфейсов `eth0`, `eth1` и `eth2` означает, что сетевые интерфейсы запущены и активны.

  1. Выполните команду, чтобы посмотреть [таблицу маршрутизации ВМ](../../../vpc/concepts/routing.md#rt-vm):

      ```bash
      ip r
      ```

      Результат:

      ```txt
      default via 192.168.2.1 dev eth0 proto dhcp src 192.168.2.7 metric 100
      default via 192.168.4.1 dev eth1 proto dhcp src 192.168.4.20 metric 200
      default via 192.168.1.1 dev eth2 proto dhcp src 192.168.1.28 metric 300
      192.168.1.0/24 dev eth2 proto kernel scope link src 192.168.1.28 metric 300
      192.168.1.1 dev eth2 proto dhcp scope link src 192.168.1.28 metric 300
      192.168.1.2 dev eth2 proto dhcp scope link src 192.168.1.28 metric 300
      192.168.2.0/24 dev eth0 proto kernel scope link src 192.168.2.7 metric 100
      192.168.2.1 dev eth0 proto dhcp scope link src 192.168.2.7 metric 100
      192.168.2.2 dev eth0 proto dhcp scope link src 192.168.2.7 metric 100
      192.168.4.0/24 dev eth1 proto kernel scope link src 192.168.4.20 metric 200
      192.168.4.1 dev eth1 proto dhcp scope link src 192.168.4.20 metric 200
      192.168.4.2 dev eth1 proto dhcp scope link src 192.168.4.20 metric 200
      ```

      Маршруты для всех сетевых интерфейсов настроены.

      {% note info %}

      Если добавленные сетевые интерфейсы неактивны или у вас пропала возможность [подключаться](../vm-connect/ssh.md) к ВМ, см. раздел [Решение проблем](../../qa/troubleshooting.md).

      {% endnote %}


- Windows {#windows}

  1. [Подключитесь](../vm-connect/rdp.md) к ВМ по RDP.
  1. В PowerShell выполните команду, чтобы получить информацию о состоянии сетевых интерфейсов ВМ:

      ```powershell
      ipconfig /all
      ```

      Результат:

      ```txt
      Windows IP Configuration

         Host Name . . . . . . . . . . . . : windows-vm
         Primary Dns Suffix  . . . . . . . :
         Node Type . . . . . . . . . . . . : Hybrid
         IP Routing Enabled. . . . . . . . : No
         WINS Proxy Enabled. . . . . . . . : No
         DNS Suffix Search List. . . . . . : ru-central1.internal
                                             auto.internal

      Ethernet adapter Ethernet:

         Connection-specific DNS Suffix  . : ru-central1.internal
         Description . . . . . . . . . . . : Red Hat VirtIO Ethernet Adapter
         Physical Address. . . . . . . . . : D0-2D-7E-E7-46-C5
         DHCP Enabled. . . . . . . . . . . : Yes
         Autoconfiguration Enabled . . . . : Yes
         Link-local IPv6 Address . . . . . : fe80::788f:1f20:e4e4:2f17%10(Preferred)
         IPv4 Address. . . . . . . . . . . : 192.168.4.23(Preferred)
         Subnet Mask . . . . . . . . . . . : 255.255.255.0
         Lease Obtained. . . . . . . . . . : Sunday, May 5, 2024 8:33:25 AM
         Lease Expires . . . . . . . . . . : Wednesday, June 11, 2160 3:05:02 PM
         Default Gateway . . . . . . . . . : 192.168.4.1
         DHCP Server . . . . . . . . . . . : 192.168.4.2
         DHCPv6 IAID . . . . . . . . . . . : 181415294
         DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-2D-C8-FA-25-D0-0D-7E-E7-46-C5
         DNS Servers . . . . . . . . . . . : 192.168.4.2
         NetBIOS over Tcpip. . . . . . . . : Enabled
         Connection-specific DNS Suffix Search List :
                                             ru-central1.internal
                                             auto.internal

      Ethernet adapter eth0:

         Connection-specific DNS Suffix  . : ru-central1.internal
         Description . . . . . . . . . . . : Red Hat VirtIO Ethernet Adapter #2
         Physical Address. . . . . . . . . : D0-0D-7E-E7-46-C5
         DHCP Enabled. . . . . . . . . . . : Yes
         Autoconfiguration Enabled . . . . : Yes
         Link-local IPv6 Address . . . . . : fe80::5e90:6d59:693:3d74%5(Preferred)
         IPv4 Address. . . . . . . . . . . : 192.168.1.27(Preferred)
         Subnet Mask . . . . . . . . . . . : 255.255.255.0
         Lease Obtained. . . . . . . . . . : Sunday, May 5, 2024 8:33:23 AM
         Lease Expires . . . . . . . . . . : Wednesday, June 11, 2160 3:05:02 PM
         Default Gateway . . . . . . . . . : 192.168.1.1
         DHCP Server . . . . . . . . . . . : 192.168.1.2
         DHCPv6 IAID . . . . . . . . . . . : 131075350
         DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-2D-C8-FA-25-D0-0D-7E-E7-46-C5
         DNS Servers . . . . . . . . . . . : 192.168.1.2
         NetBIOS over Tcpip. . . . . . . . : Enabled
         Connection-specific DNS Suffix Search List :
                                             ru-central1.internal
                                             auto.internal

      Ethernet adapter Ethernet 2:

         Connection-specific DNS Suffix  . : ru-central1.internal
         Description . . . . . . . . . . . : Red Hat VirtIO Ethernet Adapter #3
         Physical Address. . . . . . . . . : D0-1D-7E-E7-46-C5
         DHCP Enabled. . . . . . . . . . . : Yes
         Autoconfiguration Enabled . . . . : Yes
         Link-local IPv6 Address . . . . . : fe80::851a:86ae:28fd:90ce%11(Preferred)
         IPv4 Address. . . . . . . . . . . : 192.168.2.15(Preferred)
         Subnet Mask . . . . . . . . . . . : 255.255.255.0
         Lease Obtained. . . . . . . . . . : Sunday, May 5, 2024 8:33:25 AM
         Lease Expires . . . . . . . . . . : Wednesday, June 11, 2160 3:05:02 PM
         Default Gateway . . . . . . . . . : 192.168.2.1
         DHCP Server . . . . . . . . . . . : 192.168.2.2
         DHCPv6 IAID . . . . . . . . . . . : 198188414
         DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-2D-C8-FA-25-D0-0D-7E-E7-46-C5
         DNS Servers . . . . . . . . . . . : 192.168.2.2
         NetBIOS over Tcpip. . . . . . . . : Enabled
         Connection-specific DNS Suffix Search List :
                                             ru-central1.internal
                                             auto.internal
      ```

      Все сетевые интерфейсы запущены и активны.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Привязать к виртуальной машине публичный IP-адрес](vm-attach-public-ip.md)
* [Сделать публичный IP-адрес виртуальной машины статическим](vm-set-static-ip.md)
* [Сделать динамический публичный IP-адрес статическим](../../../vpc/operations/set-static-ip.md)