# Отключить доступ к серийной консоли

Включенный доступ к серийной консоли небезопасен: злоумышленники могут получить доступ к вашей виртуальной машине.

Чтобы отключить доступ к серийной консоли:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите на имя нужной ВМ.
  1. Нажмите кнопку ![image](../../../_assets/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}** выключите опцию **{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}**.
  1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  Установите в метаданных виртуальной машины параметр `serial-port-enable` в значение `0`.

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список виртуальных машин в каталоге по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.

  1. Установите в метаданных виртуальной машины параметр `serial-port-enable=0`:

     ```bash
     yc compute instance add-metadata \
         --name first-instance \
         --metadata serial-port-enable=0
     ```

     Данная команда запустит операцию деактивации серийной консоли на машине с именем `first-instance`.

{% endlist %}

