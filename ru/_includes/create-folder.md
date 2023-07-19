1. В [консоли управления]({{ link-console-main }}) выберите [облако](../resource-manager/concepts/resources-hierarchy.md#cloud) и справа сверху нажмите кнопку ![image](../_assets/create.png) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:

    {% include [name-format](name-format.md) %}

1. (Опционально) Введите описание каталога.
1. Выберите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.