# Изменить внутренний IP-адрес виртуальной машины

После создания [ВМ](../../concepts/vm.md) вы можете изменить [внутренние IP-адреса](../../../vpc/concepts/address.md#internal-addresses) ее [сетевых интерфейсов](../../concepts/network.md).

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для обновления внутреннего IP-адреса сетевого интерфейса ВМ:

     ```bash
     yc compute instance update-network-interface --help
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
     | fhm0b28lgfp4******** | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
     | fhm9gk85nj7g******** | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
     +----------------------+-----------------+---------------+---------+----------------------+
     ```

  1. Выберите идентификатор (`ID`) нужной ВМ.

  1. [Остановите](vm-stop-and-start.md#stop) выбранную ВМ.

  1. Получите список сетевых интерфейсов выбранной ВМ, указав ее идентификатор:

     ```bash
     yc compute instance get <идентификатор_ВМ>
     ```

     Результат:

     ```yml
     ...
     network_interfaces:
       - index: "0"
         mac_address: d0:0d:24:**:**:**
         subnet_id: e2lpp96bvvgp********
         primary_v4_address:
           address: 192.168.2.23
           one_to_one_nat:
             address: 158.160.**.***
             ip_version: IPV4
       - index: "1"
         mac_address: d0:1d:24:**:**:**
         subnet_id: e2lrucutusnd********
         primary_v4_address:
           address: 192.168.1.32
       - index: "2"
         mac_address: d0:2d:24:**:**:**
         subnet_id: e2lv9c6aek1d********
         primary_v4_address:
           address: 192.168.4.26
     ...
     ```

     Сохраните значение поля `index` — номер сетевого интерфейса, для которого требуется изменить внутренний IP-адрес.

  1. Измените внутренний IP-адрес выбранного сетевого интерфейса ВМ:

     ```bash
     yc compute instance update-network-interface \
       --id <идентификатор_ВМ> \
       --ipv4-address <внутренний_IP-адрес> \
       --network-interface-index <номер_сетевого_интерфейса>
     ```

     Где:
     * `--id` — идентификатор виртуальной машины.
     * `--ipv4-address` — внутренний IP-адрес. Задайте новый IP-адрес или введите `auto`, чтобы присвоить новый адрес автоматически.
     * `--network-interface-index` — сохраненный ранее номер сетевого интерфейса ВМ.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Чтобы изменить внутренний IP-адрес сетевого интерфейса ВМ, добавьте параметр `ip_address` в блок `network_interface` нужного сетевого интерфейса в конфигурации ресурса `yandex_compute_instance`:

     ```hcl
     resource "yandex_compute_instance" "vm-1" {
       ...
       network_interface {
         ...
         ip_address = "<внутренний_IP-адрес>"
       }
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance).
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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы изменить внутренний IP-адрес сетевого интерфейса ВМ, воспользуйтесь методом REST API [updateNetworkInterface](../../api-ref/Instance/updateNetworkInterface.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/PrimaryAddress](../../api-ref/grpc/Instance/get.md#yandex.cloud.compute.v1.PrimaryAddress).

{% endlist %}