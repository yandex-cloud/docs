# Привязать к виртуальной машине публичный IP-адрес

Если вы создали [ВМ](../../concepts/vm.md) без [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses), вы можете привязать к ней адрес, [зарезервированный вами](../../../vpc/operations/get-static-ip.md) в [{{ vpc-full-name }}](../../../vpc/index.md) или выбранный {{ compute-name }} автоматически из свободных адресов. Зарезервированный IP-адрес и ВМ должны находиться в одной [зоне доступности](../../../overview/concepts/geo-scope.md).

Если у ВМ несколько [сетевых интерфейсов](../../concepts/network.md), вы можете привязать публичные IP-адреса к каждому из них.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Выберите нужную ВМ.
  1. В открывшемся окне в секции **{{ ui-key.yacloud.compute.instance.overview.section_network }}** в правом верхнем углу блока нужного сетевого интерфейса нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**. В открывшемся окне:
      * В поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** выберите `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}`, чтобы автоматически получить IP-адрес, или `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}`, чтобы выбрать зарезервированный адрес из списка.
      * (Опционально) Если в поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** вы выбрали `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}`, включите опцию **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_ddos-protection-provider }}**. Подробнее см. в разделе [{#T}](../../../vpc/ddos-protection/index.md).
      * Если в поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** вы выбрали `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}`, выберите IP-адрес, который хотите привязать к ВМ. IP-адрес и ВМ должны находиться в одной зоне доступности.
      * Нажмите кнопку **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы привязать к ВМ публичный IP-адрес выполните команду [CLI](../../../cli/index.md):

  ```bash
  yc compute instance add-one-to-one-nat \
    --id=<идентификатор_ВМ> \
    --network-interface-index=<номер_сетевого_интерфейса_ВМ> \
    --nat-address=<IP-адрес>
  ```

  Где:
  * `--id` — идентификатор ВМ. Получите список идентификаторов ВМ, доступных в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), с помощью [команды CLI](../../../cli/cli-ref/compute/cli-ref/instance/list.md) `yc compute instance list`.
  * `--network-interface-index` — номер сетевого интерфейса ВМ. По умолчанию — `0`. Чтобы получить список сетевых интерфейсов ВМ и их номера, выполните команду `yc compute instance get <идентификатор_ВМ>`.
  * `--nat-address` — публичный IP-адрес, который нужно присвоить ВМ. Необязательный параметр. Если параметр `--nat-address` не задан, публичный IP-адрес будет присвоен ВМ автоматически.

    Получите список зарезервированных публичных IP-адресов, доступных в каталоге, с помощью [команды CLI](../../../cli/cli-ref/vpc/cli-ref/address/list.md) `yc vpc address list`. IP-адрес и ВМ должны находиться в одной зоне доступности.

  Пример использования:

  ```bash
  yc compute instance add-one-to-one-nat \
    --id=fhmsbag62taf******** \
    --network-interface-index=0 \
    --nat-address=51.250.*.***
  ```

  Результат:

  ```text
  id: fhmsbag62taf********
  folder_id: b1gv87ssvu49********
  created_at: "2022-05-06T10:41:56Z"
  ...
  network_settings:
    type: STANDARD
  placement_policy: {}
  ```

  Подробнее о команде `yc compute instance add-one-to-one-nat` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/add-one-to-one-nat.md).

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Чтобы создать публичный IP-адрес и привязать его к сетевому интерфейсу ВМ, используйте ресурс `yandex_vpc_address` и укажите полученный адрес в поле `nat_ip_address` блока `network_interface` нужного сетевого интерфейса в конфигурации ресурса `yandex_compute_instance`:

     ```hcl
     # Создание статического IP-адреса.

     resource "yandex_vpc_address" "addr" {
       name = "vm-adress"
       external_ipv4_address {
         zone_id = "<зона_доступности>"
       }
     }

     # Создание ВМ.

     resource "yandex_compute_instance" "vm-1" {
       name        = "<имя_ВМ>"
       platform_id = "standard-v3"
       resources {
         core_fraction = 20
         cores         = 2
         memory        = 1
       }
       ...

       ## Назначение сетевому интерфейсу ВМ подсети и IP-адреса в блоке network_interface.

       network_interface {
         subnet_id      = "<идентификатор_подсети_ВМ>"
         nat            = true
         nat_ip_address = yandex_vpc_address.addr.external_ipv4_address[0].address
       }
       ...

     }
     ```

     Где `nat_ip_address` — публичный IP-адрес, который будет привязан к сетевому интерфейсу ВМ. Ресурс `yandex_vpc_address` содержит в себе список элементов, где `[0]` — первый элемент списка, содержащий в себе IP-адрес. Если у вас уже есть зарезервированный публичный IP-адрес, который вы хотите привязать в ВМ, укажите его в поле `nat_ip_address`:

     ```hcl
     nat_ip_address = "<IP-адрес>"
     ```

     IP-адрес и ВМ должны находиться в одной зоне доступности.

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

  Чтобы привязать публичный IP-адрес к сетевому интерфейсу ВМ, воспользуйтесь методом REST API [addOneToOneNat](../../api-ref/Instance/addOneToOneNat.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/AddOneToOneNat](../../api-ref/grpc/Instance/addOneToOneNat.md).

{% endlist %}

К сетевому интерфейсу ВМ будет привязан публичный IP-адрес. Вы сможете использовать этот IP-адрес, чтобы [подключиться](../vm-connect/ssh.md#vm-connect) к ВМ по [SSH](../../../glossary/ssh-keygen.md).

#### См. также {#see-also}

* [{#T}](vm-set-static-ip.md)
* [{#T}](../../../vpc/operations/set-static-ip.md)
* [{#T}](attach-network-interface.md)