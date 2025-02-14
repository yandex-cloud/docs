**{{ ui-key.yacloud.cns.select_apns-title }}**

* Выберите **{{ ui-key.yacloud.cns.field_apns-method }}**: `{{ ui-key.yacloud.cns.auth_token }}` или `{{ ui-key.yacloud.cns.auth_certificate }}`.

    {% include [auth-apns](auth-apns.md) %}

* Выберите **{{ ui-key.yacloud.cns.field_apns-environment }}**: `{{ ui-key.yacloud.cns.env_development }}` или `{{ ui-key.yacloud.cns.env_production }}`. Для тестирования приложения используйте `{{ ui-key.yacloud.cns.env_development }}`.

**{{ ui-key.yacloud.cns.select_gcm-title }}**

Укажите, какая **{{ ui-key.yacloud.cns.field_gcm-version }}** будет использоваться: `{{ ui-key.yacloud.cns.switch_gcm-api-v1 }}` или `{{ ui-key.yacloud.cns.switch_gcm-api-legacy }}`.

{% include [auth-fcm](auth-fcm.md) %}

**{{ ui-key.yacloud.cns.select_hms-title }}**

{% include [auth-hms](auth-hms.md) %}