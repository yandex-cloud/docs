Создайте бакет {{ objstorage-name }}, который вы будете подключать к Nextcloud:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/storage) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. На панели сверху нажмите **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета. Например: `my-nextcloud-bucket`. Имя бакета должно быть [уникальным](../../../storage/concepts/bucket.md#naming) в пределах {{ objstorage-full-name }}.
  1. Чтобы установить ограничение на размер бакета, включите опцию **{{ ui-key.yacloud.storage.form-components.SizeLimitField.field_size-limit-enabled_hPy7f }}** и в появившихся полях задайте нужный размер.

      {% include [storage-no-max-limit](../../../storage/_includes_service/storage-no-max-limit.md) %}

  1. Значения остальных параметров оставьте без изменений и нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}