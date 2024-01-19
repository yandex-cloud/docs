---
title: "Как удалить группу виртуальных машин"
description: "Удаление группы виртуальных машин — неотменяемая и необратимая операция, восстановить удаленную группу невозможно. Вместе с группой удаляются целевая группа {{ network-load-balancer-name }}, виртуальные машины и диски. Чтобы удалить группу виртуальных машин, откройте страницу каталога в консоли управления. Выберите сервис {{ compute-full-name }}. На странице Виртуальные машины перейдите на вкладку Группы виртуальных машин. Выберите пункт Удалить."
---

# Удалить группу виртуальных машин

{% note warning %}

Отменить удаление группы ВМ или восстановить ее невозможно. Вместе с группой удаляются целевая группа {{ network-load-balancer-name }} или {{ alb-name }}, ВМ и диски. Вы не сможете удалить группу ВМ, если она является целевой группой для балансировщика ({{ network-load-balancer-name }}) или группы бэкендов ({{ alb-name }}).

{% endnote %}

Чтобы удалить группу ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. В строке с нужной группой ВМ нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.groups.button_action-delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.groups.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления группы ВМ:

     ```bash
     {{ yc-compute-ig }} delete --help
     ```

  1. Получите список групп ВМ в каталоге по умолчанию:

     {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы, например `first-instance-group`.
  1. Удалите группу ВМ:

     ```bash
     {{ yc-compute-ig }} delete --name first-instance-group
     ```

     {{ ig-name }} запустит операцию удаления группы ВМ.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Если вы создавали группу ВМ с помощью {{ TF }}, вы можете удалить ее:
  1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.
  1. Удалите ресурсы с помощью команды:

     ```bash
     terraform destroy
     ```

     {% note alert %}

     {{ TF }} удалит все ресурсы, созданные в текущей конфигурации: кластеры, сети, подсети, ВМ и т. д.

     {% endnote %}

  1. Введите слово `yes` и нажмите **Enter**.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/InstanceGroup/delete.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Delete](../../api-ref/grpc/instance_group_service.md#Delete).

  Список доступных групп запрашивайте методом REST API [listInstances](../../api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances).

{% endlist %}