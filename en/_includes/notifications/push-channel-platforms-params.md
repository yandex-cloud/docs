**{{ ui-key.yacloud.cns.select_apns-title }}**

* Select the **{{ ui-key.yacloud.cns.field_apns-method }}**: `{{ ui-key.yacloud.cns.auth_token }}` or `{{ ui-key.yacloud.cns.auth_certificate }}`.

    {% include [auth-apns](auth-apns.md) %}

* Select the **{{ ui-key.yacloud.cns.field_apns-environment }}**: `{{ ui-key.yacloud.cns.env_development }}` or `{{ ui-key.yacloud.cns.env_production }}`. Use `{{ ui-key.yacloud.cns.env_development }}` to test the application.

**{{ ui-key.yacloud.cns.select_gcm-title }}**

Specify which **{{ ui-key.yacloud.cns.field_gcm-version }}** will be used: `{{ ui-key.yacloud.cns.switch_gcm-api-v1 }}` or `{{ ui-key.yacloud.cns.switch_gcm-api-legacy }}`.

{% include [auth-fcm](auth-fcm.md) %}

**{{ ui-key.yacloud.cns.select_hms-title }}**

{% include [auth-hms](auth-hms.md) %}