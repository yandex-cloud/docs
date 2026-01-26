`--acr-id` — тип [фактора](../../organization/concepts/mfa.md#mfa-factors) аутентификации. Возможные значения:

* `any-mfa` — факторы аутентификации без ограничений по безопасности.

    {% include [mfa-sms-factor-pp-notice](./mfa-sms-factor-pp-notice.md) %}

* `any-except-sms` — только FIDO2 или TOTP-факторы.
* `phr` — только FIDO2-факторы, устойчивые к фишингу.