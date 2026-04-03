You can edit format and value of the `NameID` attribute (user ID). The list of possible values for the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_value }}** field depends on the format you select. When you change the format, the attribute automatically resets to that format’s default value.

Possible attribute formats and values:

* `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_nameId_email }}`: User ID is provided in email address format. Available values:
    * `SubjectClaims.preferred_username`: Default value when switching to this format.

        The uniqueness and invariability of the provided ID is not guaranteed: one organization may have two users with the same `preferred_username` ID. For example: a [federated](../../iam/concepts/users/accounts.md#saml-federation) and a [local](../../iam/concepts/users/accounts.md#local) user can have the same value for this attribute.

        If the federated user's `preferred_username` ID is not in email format, the provided ID will be automatically suffixed with `@<identity_federation_ID>` to bring it to that format.
    * `SubjectClaims.email`: User email address.

* `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_nameId_persistent }}`: User ID is provided in the [organization's](../../organization/concepts/organization.md) user [ID](../../organization/operations/users-get.md) format. In this case, the provided value is guaranteed to be unique and invariable. Available values:
    * `SubjectClaims.sub`: Default value when switching to this format.
    * `SubjectClaims.external_id`: External user ID.
    * `SubjectClaims.employee_id`: Employee ID.

{% note warning %}

If the service provider's SAML request explicitly indicates the expected user's `NameID` value format, then the SAML response will present the value in the format specified in the SAML request. In this case, the format value specified in the {{ org-full-name }} settings will be ignored.

{% endnote %}