`--acr-id`: Authentication [factor](../../organization/concepts/mfa.md#mfa-factors) type. The possible values are:

* `any-mfa`: Authentication factors without security restrictions.

    {% include [mfa-sms-factor-pp-notice](./mfa-sms-factor-pp-notice.md) %}

* `any-except-sms`: Only FIDO2 or TOTP factors.
* `phr`: Only phishing-resistant FIDO2 factors.