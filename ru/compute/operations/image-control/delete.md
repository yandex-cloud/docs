# Удалить образ диска

{% note warning %}

Удаление образа диска — неотменяемая и необратимая операция, восстановить удаленный образ невозможно.

{% endnote %}

Удаление образа не приводит к удалению виртуальных машин и дисков, созданных из этого образа. Их нужно удалять отдельно.

Чтобы удалить образ:

{% list tabs %}

- Консоль управления

  1. В консоли управления выберите каталог, которому принадлежит образ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/image-pic.svg) **{{ ui-key.yacloud.compute.switch_images }}**.
  1. В строке с нужным образом нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.images.button_action-delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.images.popup-confirm_button_delete }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд CLI для удаления образов:

     ```bash
     yc compute image delete --help
     ```

  1. Получите список образов в каталоге по умолчанию:

     {% include [compute-image-list](../../../_includes/compute/image-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного образа.
  1. Удалите образ:

     ```bash
     yc compute image delete \
       --name first-image
     ```

- API

  Воспользуйтесь методом REST API [delete](../../api-ref/Image/delete.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/Delete](../../api-ref/grpc/image_service.md#Delete).

- {{ TF }}

  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Если вы создавали образ с помощью {{ TF }}, вы можете удалить его:
  1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.
  1. Удалите ресурсы с помощью команды:

     ```bash
     terraform destroy
     ```

     {% note alert %}

     {{ TF }} удалит все ресурсы, созданные в текущей конфигурации: кластеры, сети, подсети, ВМ и т. д.

     {% endnote %}

  1. Введите слово `yes` и нажмите **Enter**.

{% endlist %}