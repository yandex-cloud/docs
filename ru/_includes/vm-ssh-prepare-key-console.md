1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет [создана](../compute/operations/vm-create/create-linux-vm.md) ВМ.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. На панели слева выберите ![image](../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
1. Нажмите **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** нажмите **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
1. В открывшемся окне выберите `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` и нажмите **{{ ui-key.yacloud.common.add }}**.

    {% include [where-generated-keys](./compute/create/where-generated-keys.md) %}

    {% include [ssh-add-to-org-profile](./compute/create/ssh-add-to-org-profile.md) %}