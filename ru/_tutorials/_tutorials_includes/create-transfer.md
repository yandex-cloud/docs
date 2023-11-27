## Создайте трансфер {#create-transfer}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать трансфер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer_ru }}**.
  1. Создайте эндпоинт-источник:
      1. На вкладке ![endpoint](../../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}** нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
      1. В поле **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** выберите `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
      1. Введите имя эндпоинта, например `logs-source`.
      1. В списке **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** выберите `{{ ui-key.yacloud.data-transfer.label_endpoint-type-YDS_ru }}`.
      1. Выберите базу данных, которую указали в настройках потока данных, созданного ранее.
      1. Введите имя потока данных `logs-stream`.
      1. Выберите созданный ранее сервисный аккаунт `logs-sa`.
      1. В блоке **{{ ui-key.yacloud.alb.label_detailed-settings }}** укажите правила конвертации для данных `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_cloud_logging.title }}`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Создайте эндпоинт-приёмник:
      1. На вкладке ![endpoint](../../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}** нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
      1. В поле **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** выберите `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
      1. Введите имя эндпоинта, например `logs-receiver`.
      1. В списке **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** выберите `{{ ui-key.yacloud.data-transfer.label_endpoint-type-OBJECT_STORAGE }}`.
      1. Введите имя созданного ранее бакета.
      1. Выберите созданный ранее сервисный аккаунт `logs-sa`.
      1. В поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}** выберите `JSON`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Создайте трансфер:
      1. На вкладке ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}** нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-transfer }}**.
      1. Введите имя трансфера, например `logs-transfer`.
      1. Выберите созданный ранее эндпоинт-источник `logs-source`.
      1. Выберите созданный ранее эндпоинт-приёмник `logs-receiver`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Напротив созданного трансфера нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

  Дождитесь активации трансфера. Когда трансфер станет готов к использованию, его статус сменится с `{{ ui-key.yacloud.data-transfer.label_connector-status-CREATING }}` на `{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}`.

{% endlist %}