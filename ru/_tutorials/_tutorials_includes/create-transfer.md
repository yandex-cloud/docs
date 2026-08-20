## Создайте трансфер {#create-transfer}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [трансфер](../../data-transfer/concepts/index.md#transfer).
  1. [Перейдите]({{ link-console-main }}/link/data-transfer) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer_ru }}**.
  1. Создайте [эндпоинт](../../data-transfer/concepts/index.md#endpoint)-источник:
     1. На панели слева выберите ![endpoint](../../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
     1. В поле **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** выберите `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
     1. Введите **{{ ui-key.yacloud.common.name }}** эндпоинта, например `logs-source`.
     1. В списке **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** выберите `Yandex Data Streams`.
     1. Выберите базу данных, которую указали в настройках [потока данных](../../data-streams/concepts/glossary.md#stream-concepts), созданного ранее.
     1. Введите имя потока данных `logs-stream`.
     1. Выберите созданный ранее [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) `logs-sa`.
     1. В блоке **Расширенные настройки** укажите правила конвертации для данных `Парсер CloudLogging`.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Создайте эндпоинт-приемник:
     1. На панели слева выберите ![endpoint](../../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
     1. В поле **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** выберите `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
     1. Введите **{{ ui-key.yacloud.common.name }}** эндпоинта, например `logs-receiver`.
     1. В списке **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** выберите `Object Storage`.
     1. Введите имя созданного ранее [бакета](../../storage/concepts/bucket.md).
     1. Выберите созданный ранее сервисный аккаунт `logs-sa`.
     1. В поле **Выходной формат** выберите `JSON`.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Создайте трансфер:
     1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-transfer }}**.
     1. Введите **{{ ui-key.yacloud.common.name }}** трансфера, например `logs-transfer`.
     1. Выберите созданный ранее эндпоинт-источник `logs-source`.
     1. Выберите созданный ранее эндпоинт-приемник `logs-receiver`.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Справа в строке созданного трансфера нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

  Дождитесь активации трансфера. Когда трансфер станет готов к использованию, его [статус](../../data-transfer/concepts/transfer-lifecycle.md#statuses) сменится с `{{ ui-key.yacloud.data-transfer.label_connector-status-CREATING }}` на `{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}`.

{% endlist %}