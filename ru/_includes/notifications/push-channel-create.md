
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать канал уведомлений.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
1. Нажмите **{{ ui-key.yacloud.cns.action_create-channel }}**.
1. На вкладке **{{ ui-key.yacloud.cns.type_mobile }}** выберите платформу для отправки:

    * `{{ ui-key.yacloud.cns.select_apns-title }}` — для iOS-устройств.
    * `{{ ui-key.yacloud.cns.select_gcm-title }}` — для Android-устройств c установленными сервисами Google Play.
    * `{{ ui-key.yacloud.cns.select_hms-title }}` — для Android-устройств c установленными сервисами Huawei.

1. В зависимости от платформы задайте параметры аутентификации:

    {% include [push-channel-platforms-params.md](push-channel-platforms-params.md) %}

1. Введите **{{ ui-key.yacloud.cns.field_channel-name }}** канала уведомлений. Должно быть уникальным в [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud). Может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Допустимая длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name).
1. (опционально) Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.cns.button_add-description }}** и введите описание для канала уведомлений.
1. Нажмите **{{ ui-key.yacloud.common.create }}**.
