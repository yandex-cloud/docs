Создайте [поток данных](../../../data-streams/concepts/glossary.md#stream-concepts), в котором будут регистрироваться события {{ postbox-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}** и нажмите кнопку **{{ ui-key.yacloud.data-streams.button_create-stream }}**.
  1. В поле **{{ ui-key.yacloud.data-streams.label_database }}** выберите созданную ранее базу данных `postbox-events-ydb`.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя потока данных `postbox-events-stream`.
  1. В поле **{{ ui-key.yacloud.data-streams.label_meter-mode }}** выберите `{{ ui-key.yacloud.data-streams.label_request-units }}`.
  1. Другие параметры потока данных оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Дождитесь запуска потока данных. Когда поток станет готов к использованию, его статус изменится с `Creating` на `Active`.