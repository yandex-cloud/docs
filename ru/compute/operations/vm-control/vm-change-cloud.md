---
title: Перенести виртуальную машину в другое облако
description: Следуя данной инструкции, вы сможете перенести виртуальную машину в другое облако.
---

# Перенести виртуальную машину в другое облако

Переместить виртуальную машину в другое облако невозможно, но вы можете создать образ из ее загрузочного диска, а затем создать виртуальную машину в другом облаке из этого образа.

1. [Создайте образ](../image-create/create-from-disk.md) из загрузочного диска нужной виртуальной машины.
1. Получите идентификатор образа загрузочного диска:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится образ диска.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.images_e7RdQ }}**.
      1. Скопируйте значение из столбца **{{ ui-key.yacloud.common.id }}** нужного образа.

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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

    - {{ TF }} {#tf}

      {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

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

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

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

      1. В [консоли управления]({{ link-console-main }}) в списке слева нажмите на нужное облако.
      1. На вкладке **{{ ui-key.yacloud.iam.cloud.switch_overview }}** скопируйте значение из поля **{{ ui-key.yacloud.common.id }}**.

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

    - {{ TF }} {#tf}

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

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      1. Сохраните идентификатор целевого облака `destination_cloud_id.txt` с помощью консольной команды:

          ```bash
          terraform output destination_cloud_id > destination_cloud_id.txt
          ```

    - API {#api}

      Чтобы получить список облаков с идентификаторами, воспользуйтесь методом REST API [list](../../../resource-manager/api-ref/Cloud/list.md) для ресурса [Cloud](../../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/List](../../../resource-manager/api-ref/grpc/Cloud/list.md).

    {% endlist %}

1. [Добавьте пользователя](../../../iam/operations/users/create.md) из целевого облака (куда планируете перенести виртуальную машину) в облако, где расположен каталог с исходным образом.
1. [Назначьте](../../../iam/operations/roles/grant.md) пользователю целевого облака роли `{{ roles-cloud-member }}` и `{{ roles-image-user }}` на облако, где расположен каталог с исходным образом.
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
