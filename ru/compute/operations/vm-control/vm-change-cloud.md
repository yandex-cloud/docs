# Перенести виртуальную машину в другое облако

Переместить виртуальную машину в другое облако невозможно, но вы можете создать образ из ее загрузочного диска, а затем создать виртуальную машину в другом облаке из этого образа.

1. [Создайте образ](../image-create/create-from-disk.md) из загрузочного диска нужной виртуальной машины.
1. Получите идентификатор образа загрузочного диска:
   
   {% list tabs group=instructions %}

   - Консоль управления {#console}
     
     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится образ диска.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. На панели слева выберите ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.switch_images }}**.
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
     
   - API {#api}
     
     Воспользуйтесь методом REST API [list](../../api-ref/Image/list.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/List](../../api-ref/grpc/image_service.md#List).
     
   {% endlist %}

1. Получите идентификатор облака, в котором расположен каталог с образом:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) в списке слева нажмите на нужное облако.
     1. На вкладке **{{ ui-key.yacloud.iam.cloud.switch_overview }}** скопируйте значение из поля **{{ ui-key.yacloud.iam.cloud.overview.label_id }}**.

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

   - API {#api}

     Чтобы получить список облаков с идентификаторами, воспользуйтесь методом REST API [list](../../../resource-manager/api-ref/Cloud/list.md) для ресурса [Cloud](../../../resource-manager/api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/List](../../../resource-manager/api-ref/grpc/cloud_service.md#List).

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

     Воспользуйтесь методом REST API [create](../../api-ref/Image/create.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/Create](../../api-ref/grpc/image_service.md#Create). В запросе укажите идентификатор образа.

   {% endlist %}

1. [Создайте виртуальную машину](../vm-create/create-from-user-image.md) из созданного образа в целевом облаке.
