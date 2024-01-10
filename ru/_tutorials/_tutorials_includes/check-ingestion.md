## Проверьте отправку и получение данных {#check-ingestion}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создали поток данных, трансфер и бакет.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
  1. Выберите поток данных `logs-stream`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}** и посмотрите графики активности потока.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer_ru }}**.
  1. Выберите трансфер `logs-transfer`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}** и посмотрите графики активности трансфера.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите бакет, созданный ранее.
  1. Проверьте, что в бакете появились объекты. Скачайте и посмотрите полученные файлы с логами.

{% endlist %}