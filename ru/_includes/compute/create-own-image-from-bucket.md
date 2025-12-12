Создайте новый образ по ссылке, полученной в {{ objstorage-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать образ.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.images_e7RdQ }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.images.button_upload }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud.common.name }}** задайте имя образа. Требования к имени:

          {% include [name-format](../name-format.md) %}

      1. (Опционально) В поле **{{ ui-key.yacloud.common.description }}** добавьте произвольное описание создаваемого образа.
      1. В поле **{{ ui-key.yacloud.compute.images.popup-upload_field_url }}** вставьте ссылку на файл с образом, полученную ранее в {{ objstorage-name }}.
      1. В поле **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** выберите поколение оборудования, на котором будут работать виртуальные машины, создаваемые из вашего образа. Подробнее о доступных вариантах читайте в разделе [{#T}](../../compute/concepts/hardware-generations.md).

          {% note alert %}

          Если вы выбираете поколение `Gen 2`, убедитесь, что загрузчик операционной системы создаваемого образа поддерживает режим загрузки [UEFI](https://ru.wikipedia.org/wiki/Extensible_Firmware_Interface) и таблицу разделов [GPT](https://ru.wikipedia.org/wiki/Таблица_разделов_GUID). В противном случае, виртуальные машины не смогут запустить операционную систему.

          {% endnote %}

      1. Чтобы включить [оптимизацию](../../compute/concepts/image.md#images-optimized-for-deployment) образа для развертывания, включите опцию **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.button_upload }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Чтобы создать новый образ по ссылке, выполните команду:

  ```bash
  yc compute image create \
    --name <имя_образа> \
    --source-uri <URL_образа> \
    --pooled
  ```

  Где:
  * `--name` — имя, которое будет присвоено образу. Требования к имени образа:

      {% include [name-format](../name-format.md) %}
  
  * `--source-uri` — ссылка на образ, полученная в {{ objstorage-name }}.
  * `--pooled` — параметр, позволяющий включить [оптимизацию](../../compute/concepts/image.md#images-optimized-for-deployment) образа для развертывания. Необязательный параметр. По умолчанию оптимизация отключена.

  Если необходимо, добавьте описание и укажите [семейство](../../compute/concepts/image.md#family), к которому относится этот образ:

  ```bash
  yc compute image create \
    --name ubuntu-cosmic \
    --description "Ubuntu Server 18.10 (Cosmic Cuttlefish)" \
    --family ubuntu \
    --source-uri "https://{{ s3-storage-host }}/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  Если вы знаете минимальные требования к размеру [диска](../../compute/concepts/disk.md), который будет создан из этого образа, укажите размер в ГБ:

  ```bash
  yc compute image create \
    --name big-image \
    --min-disk-size 20 \
    --source-uri "https://{{ s3-storage-host }}/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  {% include [min-disk-size](../../compute/_includes_service/min-disk-size.md) %}

  Если вы хотите создать образ с закрепленным [поколением](../../compute/concepts/hardware-generations.md) оборудования виртуальной машины `Gen 1.2`:

  ```bash
  yc compute image create \
    --name gen12-image \
    --description "Ubuntu Server Hardware Generation Gen 1.2" \
    --hardware-generation-id legacy \
    --hardware-features pci_topology=v2 \
    --source-uri "https://{{ s3-storage-host }}/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  Если вы хотите создать образ с закрепленным поколением оборудования виртуальной машины `Gen 2`:

  ```bash
  yc compute image create \
    --name gen2-image \
    --description "Ubuntu Server Hardware Generation Gen 2" \
    --hardware-generation-id generation2 \
    --source-uri "https://{{ s3-storage-host }}/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  Подробнее о команде `yc compute image create` читайте в [справочнике CLI](../../cli/cli-ref/compute/cli-ref/image/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать образ:
  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_image`.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_compute_image" "image-1" {
        name                 = "<имя_образа>"
        os_type              = "LINUX"
        source_url           = "<ссылка_на_образ>"
        pooled               = "false"

        hardware_generation {
          generation2_features {}
          legacy_features {
            pci_topology = "PCI_TOPOLOGY_V1|PCI_TOPOLOGY_V2"
          }
        }
      }
      ```

      Где:
      * `name` — имя, которое будет присвоено образу. Требования к имени образа:
      
          {% include [name-format](../name-format.md) %}

      * `source_url` — ссылка на образ в {{ objstorage-name }}.
      * `pooled` — параметр, позволяющий включить [оптимизацию](../../compute/concepts/image.md#images-optimized-for-deployment) образа для развертывания. Возможные значения:
      
          * `true` — оптимизация включена.
          * `false` — оптимизация выключена.
          
          Необязательный параметр. По умолчанию оптимизация выключена.
      * `hardware_generation` — настройка [поколения оборудования](../../compute/concepts/hardware-generations.md) виртуальной машины:

          * `generation2_features` — параметр, привязывающий к создаваемому образу поколение оборудования `Gen 2`. Необязательный параметр. Использование этого параметра делает невозможным использование параметра `legacy_features`.
          * `legacy_features` — параметр, позволяющий привязать к создаваемому образу поколение оборудования `Gen 1.2`. Использование этого параметра делает невозможным использование параметра `generation2_features`.

              * `pci_topology` — настройка топологии PCI. Возможные значения:

                  * `PCI_TOPOLOGY_V1` — топология `PCI_TOPOLOGY_V1` соответствует поколению оборудования `Gen 1.1`.
                  * `PCI_TOPOLOGY_V2` — топология `PCI_TOPOLOGY_V2` соответствует поколению оборудования `Gen 1.2`.
          Блок параметров `hardware_generation` — необязательный. Если не задан, к создаваемому образу будет привязано поколение оборудования `Gen 1.1`.
      Подробную информацию о параметрах ресурса `yandex_compute_image` см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/compute_image).
  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

      ```bash
      yc compute image list
      ```

- API {#api}

  Создайте новый образ с помощью метода REST API [create](../../compute/api-ref/Image/create.md) для ресурса [Image](../../compute/api-ref/Image/index.md) или вызова gRPC API [ImageService/Create](../../compute/api-ref/grpc/Image/create.md). В запросе укажите ссылку на образ, полученную в {{ objstorage-name }}.

  По умолчанию создается образ с привязанным [поколением оборудования](../../compute/concepts/hardware-generations.md) `Gen 1.1`.

  Чтобы создать образ с привязанным поколением оборудования `Gen 1.2`, передайте в теле запроса следующий объект:

  ```json
  ...
  "hardwareGeneration": {
    "legacyFeatures": {
      "pciTopology": "PCI_TOPOLOGY_V2"
    }
  }
  ...
  ```

  Чтобы создать образ с привязанным поколением оборудования `Gen 2`, передайте в теле запроса следующий объект:

  ```json
  ...
  "hardwareGeneration": {
    "generation2Features": {}
  }
  ...
  ```

{% endlist %}

После создания образ перейдет в статус `CREATING`. Дождитесь, когда образ перейдет в статус `READY`, прежде чем его использовать.