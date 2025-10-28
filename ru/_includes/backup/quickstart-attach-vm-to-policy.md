Привяжите ВМ к политике резервного копирования:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором активирован сервис и где находится нужная виртуальная машина.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![policies](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Выберите одну из политик, созданных по умолчанию. При необходимости нажмите кнопку **{{ ui-key.yacloud.backup.button_create-policy }}**, чтобы создать новую политику.
  1. В блоке **{{ ui-key.yacloud.backup.title_linked-recourses }}** на вкладке **{{ ui-key.yacloud.backup.value_vm-recourses }}** нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}**.
  1. В открывшемся окне выберите нужную ВМ из списка и нажмите **{{ ui-key.yacloud_billing.backup.button_attach-instance-submit }}**.

{% endlist %}

В результате виртуальная машина будет привязана к политике резервного копирования, а ее резервные копии начнут создаваться по расписанию, заданному в политике.