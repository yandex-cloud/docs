Where:

* `name`: Policy name. This is a required setting. The naming requirements are as follows:

  {% include [group-name-format](./group-name-format.md) %}

* `organization_id`: Organization ID. This is a required setting.
* `acr_id`: Authentication [factor](../../organization/concepts/mfa.md#mfa-factors) type. This is a required setting. The possible values are:

  * `any-mfa`: Authentication factors without security restrictions.
  * `any-except-sms`: Only FIDO2 or TOTP factors.
  * `phr`: Only phishing-resistant FIDO2 factors.

* `ttl`: Credential validity period in time format, e.g., `336h0m0s` for 14 days. This is a required setting.
* `status`: Policy status. This is an optional parameter; the possible values are: 
    * `MFA_ENFORCEMENT_STATUS_ACTIVE`: Active.
    * `MFA_ENFORCEMENT_STATUS_INACTIVE`: Inactive.
* `apply_at`: Time after which the policy will become active, in RFC3339 format, e.g., `2024-12-31T23:59:59Z`. This is an optional setting.
* `--enroll-window`: Period of time after registration during which the user must add a second authentication factor. Uses time format, e.g., `720h0m0s` for 30 days. This is a required setting.
* `description`: Policy description. This is an optional setting.

For more on the properties of the `yandex_organizationmanager_mfa_enforcement` resource, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_mfa_enforcement).