# Создать виртуальную машину в группе размещения


Создайте [ВМ](../../concepts/vm.md) в [группе размещения](../../concepts/placement-groups.md).

Работа с группами размещения со стратегией [размещения разделами](../../concepts/placement-groups.md#partition) доступна с помощью [CLI](../../../cli/quickstart.md) и [API](../../api-ref/index.md).

{% note info %}

Чтобы создавать, изменять и редактировать [ВМ](../../concepts/vm.md), необходима _минимальная_ [роль](../../security/index.md#compute-editor) `compute.editor` на [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder). Для создания ВМ с лицензируемым образом дополнительно потребуется [роль](../../../marketplace/security/index.md#license-manager-viewer) `license-manager.viewer`.

Для создания ВМ с [публичным IP-адресом](../../../vpc/concepts/address.md#public-addresses) дополнительно потребуется [роль](../../../vpc/security/index.md#vpc-public-admin) `vpc.publicAdmin`.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для создания группы размещения:

     ```bash
     yc compute placement-group create --help
     ```

  1. Создайте группу размещения в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию с одной из стратегий размещения:

     * [Распределенное размещение](../../concepts/placement-groups.md#spread) (spread):
     
       ```bash
       yc compute placement-group create \
         --spread-strategy \
         --name <имя_группы_размещения>
       ```
     
       Где:
     
       * `--spread-strategy` — выбор стратегии распределенного размещения.
       * `--name` — имя группы размещения.
     
     * [Размещение разделами](../../concepts/placement-groups.md#partition) (partition):
     
       ```bash
       yc compute placement-group create \
         --partitions <количество_разделов> \
         --name <имя_группы_размещения>
       ```
     
       Где:
     
       * `--partitions` — выбор стратегии размещения разделами с указанием количества разделов: от `1` до `5`.
       * `--name` — имя группы размещения.

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. Создайте ВМ:

     ```bash
     yc compute instance create \
       --zone ru-central1-a \
       --name instance-in-group-1 \
       --placement-group-name my-group \
       --placement-group-partition <номер_раздела>
     ```

     Где:
     * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет размещена ВМ.
     * `--name` — имя ВМ.
     * `--placement-group-name` — имя группы размещения.
     * `--placement-group-partition` — номер раздела в группе размещения со стратегией [размещения разделами](../../concepts/placement-groups.md#partition).

       {% note info %}

       Если не указать номер раздела при создании ВМ в группе с размещением разделами, ВМ добавится в случайный раздел.

       {% endnote %}

     Результат:

     ```text
     id: epdep2kq6dt5********
     ...
     placement_policy:
       placement_group_id: fd83bv4rnsna********
     ```

  1. Проверьте, что ВМ создана и добавлена в группу размещения:

     ```bash
     yc compute placement-group list-instances --name my-group
     ```

     Где `--name` — имя группы размещения.

     Результат:

     ```text
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     |          ID          |        NAME         |      ZONE ID      | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     | epdep2kq6dt5******** | instance-in-group-1 | ru-central1-a | RUNNING |             | 10.129.0.5  |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать ВМ в группе размещения:
  1. Опишите в конфигурационном файле параметры ВМ с указанием на ресурс `yandex_compute_placement_group` в поле `placement_group_id`. Параметры ВМ описывает ресурс `yandex_compute_instance`.

     Пример структуры конфигурационного файла:

     ```hcl
     ...
     resource "yandex_compute_instance" "vm-1" {
       name        = "linux-vm"
       platform_id = "standard-v3"
       placement_policy {
         placement_group_id = "${yandex_compute_placement_group.group1.id}"
       }
     }

     resource "yandex_compute_placement_group" "group1" {
       name = "test-pg"
     }
     ...
     ```

     Где `placement_group_id` — идентификатор группы размещения.

     Более подробную информацию о параметрах ресурсов `yandex_compute_instance` и `yandex_compute_placement_group` в Terraform см. в [документации провайдера](../../../terraform/resources/compute_instance.md).
  1. В командной строке перейдите в папку, где расположен файл конфигурации Terraform.
  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```text
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

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) будут созданы все требуемые ресурсы. Проверить, что ВМ создана и добавлена в группу размещения, можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md).

{% endlist %}

## Смотрите также {#see-also}

* [Как добавить ВМ в группу размещения](add-vm.md).