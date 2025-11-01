{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/list-ul.svg) **{{ ui-key.yacloud.postbox.label_configuration-sets }}** и нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя конфигурации `postbox-events-config`.
  1. В блоке **{{ ui-key.yacloud.postbox.label_event-destinations }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}** и в появившейся форме:

      1. В поле **{{ ui-key.yacloud.postbox.label_name }}** укажите название [подписки](../../../postbox/concepts/glossary.md#subscription) `postbox-events-subscribe`.
      1. В поле **{{ ui-key.yacloud.postbox.label_data-stream }}** выберите [поток данных](../../../data-streams/concepts/glossary.md#stream-concepts) `postbox-events-stream`.
      1. Включите опцию **{{ ui-key.yacloud.common.enabled }}**, чтобы активировать подписку.

  1. Другие параметры конфигурации оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.

{% endlist %}