You cannot change the name of the `NameID` attribute in which the user ID is provided. You can change the ID format for this attribute, unless the attribute's format is explicitly specified in the service provider's SAML request. When the format changes, the attribute value changes automatically. Possible attribute formats and values:

* `urn: oasis: names: tc: SAML: 1.1:nameid-format: emailAddress`: User ID is provided in email address format in the `SubjectClaims.preferred_username` attribute. This is the default format.

    The uniqueness and invariability of the provided ID is not guaranteed: one organization may have two users with the same `preferred_username` ID. For example: a [federated](../../iam/concepts/users/accounts.md#saml-federation) and a [local](../../iam/concepts/users/accounts.md#local) user can have the same value for this attribute.

    If the federated user's `preferred_username` ID is not in email format, the provided ID will be automatically suffixed with `@<identity_federation_ID>` to bring it to that format.
* `urn: oasis: names: tc: SAML: 2.0:nameid-format: persistent`: User ID is provided in the `SubjectClaims.sub` attribute in the [organization's](../../organization/concepts/organization.md) user [ID](../../organization/operations/users-get.md) format. In this case, the provided value is guaranteed to be unique and invariable.

{% note warning %}

If the service provider's SAML request explicitly indicates the expected user's `NameID` value format, then the SAML response will present the value in the format specified in the SAML request. In this case, the format value specified in the {{ org-name }} settings will be ignored.

{% endnote %}