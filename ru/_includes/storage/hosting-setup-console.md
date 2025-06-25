1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, для которого хотите настроить хостинг.
1. На панели слева выберите ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_general-settings }}**.
1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
1. Нажмите **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.
1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
1. В разделе **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**:
    * В поле **{{ ui-key.yacloud.storage.bucket.website.field_index }}** укажите абсолютный путь к файлу в бакете для главной страницы сайта, например `index.html`.

      {% include [static-site-index-restriction](static-site-index-restriction.md) %}

    * (опционально) В поле **{{ ui-key.yacloud.storage.bucket.website.field_error }}** укажите абсолютный путь к файлу в бакете, который будет отображаться при ошибках 4xx, например `pages/error404.html`. По умолчанию {{ objstorage-name }} возвращает собственную страницу.
1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

Проверить хостинг можно, перейдя по ссылке в поле **{{ ui-key.yacloud.storage.bucket.website.field_link }}**.
