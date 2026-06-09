# Исключить виртуальную машину из группы размещения

Исключите [ВМ](../../concepts/vm.md) из [группы размещения](../../concepts/placement-groups.md).

Исключенную ВМ можно [удалить насовсем](../vm-control/vm-delete.md) или [добавить обратно](add-vm.md) в группу размещения.

Работа с группами размещения со стратегией [размещения разделами](../../concepts/placement-groups.md#partition) доступна с помощью [CLI](../../../cli/quickstart.md) и [API](../../api-ref/index.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит группа размещения.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/compute/group-placement-pic.svg) **Группы размещений**.
  1. Перейдите на вкладку **Группы размещения виртуальных машин**.
  1. Выберите группу размещения, из которой вы хотите исключить ВМ.
  1. Перейдите на панель **Виртуальные машины**.
  1. В строке с нужной ВМ нажмите значок ![image](../../../_assets/options.svg) и выберите **Удалить из группы**.
  1. В открывшемся окне нажмите кнопку **Удалить из группы**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите список ВМ в группе размещения:

     ```bash
     yc compute placement-group list-instances --name my-group
     ```

     Результат:

     ```text
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     |          ID          |        NAME         |      ZONE ID      | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     | epdep2kq6dt5******** | instance-in-group-1 |   ru-central1-a   | RUNNING |             | 10.129.0.5  |
     | epdlv1pp5401******** | instance-in-group-2 |   ru-central1-a   | RUNNING |             | 10.129.0.30 |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     ```

  1. Остановите ВМ, которую необходимо исключить:

     ```bash
     yc compute instance stop instance-in-group-2
     ```

     Результат:

     ```text
     id: epdlv1pp5401********
     ...
     status: STOPPED
     ```

  1. Исключите ВМ из группы размещения. Для этого обновите ВМ, оставив имя группы размещения (`placement-group-name`) пустым:

     ```bash
     yc compute instance update --name instance-in-group-2 --placement-group-name=""
     ```

  1. Проверьте, что ВМ исключена из группы размещения:

     ```bash
     yc compute placement-group list-instances --name my-group
     ```

     Результат:

     ```text
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     |          ID          |        NAME         |      ZONE ID      | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     | epdep2kq6dt5******** | instance-in-group-1 |   ru-central1-a   | RUNNING |             | 10.129.0.5  |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы исключить ВМ, созданную с помощью Terraform, из группы размещения:
  1. Откройте конфигурационный файл ВМ и удалите параметр `placement_group_id`.

     Пример структуры конфигурационного файла ВМ:

     ```hcl
     ...
     resource "yandex_compute_instance" "vm-1" {
       name        = "my-vm"
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

     Проверить изменения можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md).

{% endlist %}