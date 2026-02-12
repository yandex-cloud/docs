1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../resource-manager/concepts/resources-hierarchy.md#cloud).
1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
1. Выберите ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.

   ![create-folder1](../_assets/resource-manager/create-folder-ru1.png)

1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:

    {% include [name-format](name-format.md) %}

1. (Опционально) Введите описание каталога.
1. Выберите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

   ![create-folder2](../_assets/resource-manager/create-folder-ru2.png)
