# Перенести виртуальную машину в другое облако

Переместить виртуальную машину в другое облако невозможно, но вы можете создать образ из ее загрузочного диска, а затем создать виртуальную машину в другом облаке из этого образа.

1. [Создайте образ](../image-create/create-from-disk.md) из загрузочного диска нужной виртуальной машины.
1. Получите идентификатор образа загрузочного диска:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится образ диска.
      1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/layers.svg) **Образы**.
      1. Скопируйте значение из столбца **Идентификатор** нужного образа.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Получите список образов дисков в каталоге по умолчанию:

      ```bash
      yc compute image list
      ```

      Результат:

      ```text
      +----------------------+----------------+--------+-------------+--------+
      |          ID          |    NAME        | FAMILY | PRODUCT IDS | STATUS |
      +----------------------+----------------+--------+-------------+--------+
      | xc8n3spmksqm******** | original-image |        |             | READY  |
      +----------------------+----------------+--------+-------------+--------+
      ```

    - Terraform {#tf}

      [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
      
      Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
      
      Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

      1. В конфигурационном файле подготовьте переменную `output` с выходными данными:

          ```hcl
          resource "yandex_compute_snapshot" "snapshot-1" {
            name           = "<имя_образа>"
            source_disk_id = "<идентификатор_диска>"
          }
          ...
          output "snapshot_id" {
            value = yandex_compute_snapshot.snapshot-1.id
          }
          ```

          Где `value` — идентификатор образа загрузочного диска. В примере выше образ загрузочного диска описан в ресурсе `yandex_compute_snapshot` с именем `snapshot-1`.

      1. Примените изменения:

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

      1. Сохраните идентификатор образа загрузочного диска в файл `snapshot_id.txt` с помощью консольной команды:

          ```bash
          terraform output snapshot_id > snapshot_id.txt
          ```

    - API {#api}

      Воспользуйтесь методом REST API [list](../../api-ref/Image/list.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/List](../../api-ref/grpc/Image/list.md).

    {% endlist %}

1. Получите идентификатор целевого облака, в которое вы планируете перенести виртуальную машину (далее — `<идентификатор_облака_назначения>`):

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) в списке слева нажмите на нужное облако.
      1. На вкладке **Обзор** скопируйте значение из поля **Идентификатор**.

    - CLI {#cli}

      Получите список облаков с идентификаторами:

      ```bash
      yc resource-manager cloud list
      ```

      Результат:

      ```text
      +----------------------+------------+--------------------------+
      |          ID          |    NAME    |      ORGANIZATION ID     |
      +----------------------+------------+--------------------------+
      | b1g66mft1vop******** | my-cloud-1 |                          |
      | b1gd129pp9ha******** | my-cloud-2 |                          |
      +----------------------+------------+--------------------------+
      ```

    - Terraform {#tf}

      1. В конфигурационном файле подготовьте переменную `output` с выходными данными:

          ```hcl
          resource "yandex_resourcemanager_cloud" "cloud-1" {
            name            = "<имя_облака>"
            organization_id = "<идентификатор_организации>"
          }

          output "destination_cloud_id" {
            value = yandex_resourcemanager_cloud.cloud-1.id
          }
          ```

          Где `destination_cloud_id` — идентификатор целевого облака. В примере выше облако описано в ресурсе `yandex_resourcemanager_cloud` с именем `cloud-1`.

      1. Примените изменения:

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

      1. Сохраните идентификатор целевого облака `destination_cloud_id.txt` с помощью консольной команды:

          ```bash
          terraform output destination_cloud_id > destination_cloud_id.txt
          ```

    - API {#api}

      Чтобы получить список облаков с идентификаторами, воспользуйтесь методом REST API [list](../../../resource-manager/api-ref/Cloud/list.md) для ресурса [Cloud](../../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/List](../../../resource-manager/api-ref/grpc/Cloud/list.md).

    {% endlist %}

1. [Добавьте пользователя](../../../organization/operations/add-account.md) из целевого облака (куда планируете перенести виртуальную машину) в облако, где расположен каталог с исходным образом.
1. [Назначьте](../../../iam/operations/roles/grant.md) пользователю целевого облака роли `resource-manager.clouds.member` и `compute.images.user` на облако, где расположен каталог с исходным образом.
1. Создайте новый образ в целевом облаке:

    {% list tabs group=instructions %}

    - CLI {#cli}

      ```bash
      yc compute image create \
        --name <имя_нового_образа> \
        --source-image-id <идентификатор_исходного_образа> \
        --cloud-id <идентификатор_облака_назначения> \
        --folder-id <идентификатор_каталога_назначения>
      ```


    - API {#api}

      Воспользуйтесь методом REST API [create](../../api-ref/Image/create.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/Create](../../api-ref/grpc/Image/create.md). В запросе укажите идентификатор образа.

    {% endlist %}

1. [Создайте виртуальную машину](../vm-create/create-from-user-image.md) из созданного образа в целевом облаке.