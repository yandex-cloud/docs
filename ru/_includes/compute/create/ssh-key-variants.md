Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:

1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
1. Задайте имя SSH-ключа.
1. Выберите вариант:

    * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
    * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
    * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
    
      {% include [where-generated-keys](./where-generated-keys.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% include [ssh-add-to-org-profile](./ssh-add-to-org-profile.md) %}