1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно подключить ВМ к {{ backup-name }}.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** и в открывшемся списке выберите нужную ВМ.
1. В правом верхнем углу страницы нажмите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}** выберите сервисный аккаунт с ролью `backup.editor`.
1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.