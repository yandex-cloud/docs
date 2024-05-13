## Создайте поток данных {#create-stream}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [поток данных](../../data-streams/concepts/glossary.md#stream-concepts).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-streams.button_create-stream }}**.
  1. Укажите существующую [бессерверную](../../ydb/concepts/serverless-and-dedicated.md#serverless) базу данных {{ ydb-short-name }} или [создайте](../../ydb/quickstart.md#serverless) новую. Если вы создали новую БД, нажмите значок ![refresh-button](../../_assets/data-streams/refresh-button.svg), чтобы обновить список БД.
  1. Введите имя потока данных, например `logs-stream`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  Дождитесь запуска потока данных. Когда поток станет готов к использованию, его статус изменится с `Creating` на `Active`.

{% endlist %}