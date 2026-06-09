# Получить информацию о группе виртуальных машин

После создания [группы ВМ](../../concepts/instance-groups/index.md) вы можете получить основную информацию о группе.

Пользовательские [метаданные](../../concepts/vm-metadata.md), которые были переданы при создании или изменении группы ВМ, можно получить только с помощью [CLI](../../../cli/index.md) или API.

Чтобы получить информацию о группе ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) откройте [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная группа ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. Нажмите на имя нужной группы ВМ.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о группе ВМ:

     ```bash
     yc compute instance-group get --help
     ```

  1. Получите список групп ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute instance-group list
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------+--------+------+
     |          ID          |          NAME        | STATUS | SIZE |
     +----------------------+----------------------+--------+------+
     | cl15b3mrkk88******** | first-instance-group | ACTIVE |    3 |
     +----------------------+----------------------+--------+------+
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы ВМ, например `first-instance-group`.
  1. Получите информацию о группе ВМ:

     ```bash
     yc compute instance-group get --name first-instance-group
     ```

- Terraform

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о группе ВМ с помощью Terraform:
  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

     ```hcl
     data "yandex_compute_instance_group" "my_group" {
       instance_group_id = "<идентификатор_группы_ВМ>"
     }

     output "instancegroupvm_external_ip" {
       value = "${data.yandex_compute_instance_group.my_group.instances.*.network_interface.0.nat_ip_address}"
     }
     ```

     Где:
     * `data "yandex_compute_instance_group"` — описание источника данных для получения информации о группе ВМ:
       * `instance_group_id` — идентификатор группы ВМ.
     * `output "instancegroupvm_external_ip"` — список всех [публичных IP-адресов](../../../vpc/concepts/address.md#public-addresses) ВМ из группы, который будет выводиться в результате:
       * `value` — возвращаемое значение.

     Более подробную информацию о параметрах источника данных `yandex_compute_instance_group` см. в [документации провайдера](../../../terraform/data-sources/compute_instance_group.md).
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

     Terraform создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output instancegroupvm_external_ip
     ```

     Результат:

     ```text
     instancegroupvm_external_ip = tolist([
       "158.160.112.7",
       "158.160.2.119",
     ])
     ```

- API {#api}

  Воспользуйтесь методом REST API [get](../../instancegroup/api-ref/InstanceGroup/get.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Get](../../instancegroup/api-ref/grpc/InstanceGroup/get.md).

  Список доступных групп ВМ запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}