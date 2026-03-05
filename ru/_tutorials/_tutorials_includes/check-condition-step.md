## Проверьте сохраненное состояние {#check-condition}

Убедитесь, что файл состояния загружен в [{{ objstorage-full-name }}](../../storage/):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления]({{ link-console-main }}) и выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится созданный [бакет](../../storage/concepts/bucket.md).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. В списке бакетов выберите тот, в котором должно было сохраниться состояние {{ TF }}.
  1. Убедитесь, что в бакете появился файл состояния.

{% endlist %}