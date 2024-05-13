## Проверьте сохраненное состояние {#check-condition}

Убедитесь, что файл состояния загружен в [{{ objstorage-full-name }}](../../storage/):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления]({{ link-console-main }}) и выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится созданный [бакет](../../storage/concepts/bucket.md).
  1. Выберите сервис **{{ objstorage-name }}**.
  1. В списке бакетов выберите тот, в котором должно было сохраниться состояние {{ TF }}.
  1. Убедитесь, что в бакете появился файл состояния.

{% endlist %}