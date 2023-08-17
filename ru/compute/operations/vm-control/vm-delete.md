# Удалить виртуальную машину

{% note warning %}

Удаление ВМ — неотменяемая и необратимая операция, восстановить удаленную ВМ невозможно.

{% endnote %}

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

Если к ВМ подключены ранее созданные диски, то при удалении ВМ диски будут отключены. Данные на дисках сохранятся и в дальнейшем эти диски можно будет подключить к другой ВМ.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. В строке с нужной ВМ нажмите значок ![image](../../../_assets/options.svg) → **{{ ui-key.yacloud.common.delete }}**.

     Чтобы удалить несколько виртуальных машин, выделите нужные ВМ в списке и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_gr-action-delete }}** в нижней части экрана.

  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_delete }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления ВМ:

     ```bash
     yc compute instance delete --help
     ```

  1. Получите список ВМ в каталоге по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.
  1. Удалите ВМ:

     ```bash
     yc compute instance delete first-instance
     ```

- API

  Воспользуйтесь методом REST API [delete](../../api-ref/Instance/delete.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Delete](../../api-ref/grpc/instance_service.md#Delete).

- {{ TF }}

  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Если вы создавали ВМ с помощью {{ TF }}, вы можете удалить ее:
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