# Создать группу размещения

Создайте [группу размещения](../../concepts/placement-groups.md).

Работа с группами размещения со стратегией [размещения разделами](../../concepts/placement-groups.md#partition) доступна с помощью [CLI](../../../cli/quickstart.md) и [API](../../api-ref/index.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана группа размещения.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/compute/group-placement-pic.svg) **Группы размещений**.
  1. Перейдите на вкладку **Группы размещения виртуальных машин**.
  1. В правом верхнем углу нажмите кнопку **Создать** и выберите **Группу размещения виртуальных машин**.
  1. Введите имя группы размещения. Требования к имени:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. (Опционально) Добавьте описание группы размещения.
  1. Нажмите кнопку **Создать**.

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

  1. Проверьте, что группа размещения добавлена:

     ```bash
     yc compute placement-group list
     ```

     Результат:

     ```text
     +----------------------+----------+----------+
     |          ID          |   NAME   | STRATEGY |
     +----------------------+----------+----------+
     | fd83bv4rnsna******** | my-group | SPREAD   |
     +----------------------+----------+----------+
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры группы размещения:
     * `name` — имя группы размещения. Формат имени:

       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * `folder_id` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается группа размещения.
     * `description` — описание группы размещения.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_compute_placement_group" "group1" {
       name        = "<имя_группы_размещения>"
       folder_id   = "<идентификатор_каталога>"
       description = "<описание_группы_размещения>"
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_compute_placement_group` в Terraform читайте в [документации провайдера](../../../terraform/resources/compute_placement_group.md).
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

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc compute placement-group list
     ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/PlacementGroup/create.md) для ресурса [PlacementGroup](../../api-ref/PlacementGroup/index.md) или вызовом gRPC API [PlacementGroupService/Create](../../api-ref/grpc/PlacementGroup/create.md).

{% endlist %}

## Смотрите также {#see-also}

* [Как добавить виртуальную машину в группу размещения](add-vm.md).
* [Как создать ВМ в группе размещения](create-vm-in-pg.md).