1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно подключить ВМ к {{ backup-name }}.
1. [Перейдите]({{ link-console-main }}/link/compute) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** и в открывшемся списке выберите нужную ВМ.
1. На панели сверху нажмите кнопку ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}** выберите сервисный аккаунт с ролью `backup.user` или выше.
1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.