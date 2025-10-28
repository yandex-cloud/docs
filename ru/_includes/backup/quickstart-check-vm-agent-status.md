Убедитесь, что агент {{ backup-name }} установлен:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором активирован сервис.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Выберите нужную ВМ.
  1. Убедитесь, что в блоке **{{ ui-key.yacloud.backup.title_backup }}** в поле **{{ ui-key.yacloud.backup.field_vm-instances }}** отображается значение `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-no-applications }}`.

{% endlist %}