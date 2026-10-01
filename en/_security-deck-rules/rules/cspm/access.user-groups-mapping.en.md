### User group mapping is configured in an identity federation {#user-groups-mapping}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | access.user-groups-mapping ||
|#

#### Description

**How the rule works**: it checks that group mapping is configured in each SAML federation.

In organizations with a lot of users, you may need to grant the same access permissions for Yandex Cloud resources to multiple users at once. In which case, it is more efficient to grant roles and permissions to groups rather than individual users.

If you have created user groups in your identity provider or plan to do so, you can [map user groups](https://yandex.cloud/en/docs/organization/operations/federation-group-mapping) between the IdP and Yandex Identity Hub. Users in the identity provider's groups will be granted the same access permissions for Yandex Cloud resources as their respective groups in Identity Hub.

**Risks if the rule is not followed:** Without group mapping, access permissions must be assigned manually to each user, increasing the risk of misconfiguration and excessive privilege grants. Users who leave a group in the identity provider may retain their Yandex Cloud access indefinitely, creating orphaned permissions that can be exploited.

#### Instructions and solutions

[Configure](https://yandex.cloud/en/docs/organization/operations/federation-group-mapping) group mapping between your identity provider and Yandex Identity Hub.
