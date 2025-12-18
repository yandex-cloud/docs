# How long a session lasts when authenticating a federated user


## Case description {#case-description}

You need to figure out the maximum `Cookie lifetime` when setting up a federation.

## Solution {#case-resolution}

The maximum session lifetime is 12 hours. You cannot increase it but you can use the **{{ ui-key.yacloud_org.entity.federation.field.forceAuthn }}** option. If enabled, the IdP will request the user to re-authenticate once the {{ yandex-cloud }} session expires.

You can learn more about the changes in **Creating a federation in your organization** here:

* [ADFS](../../../organization/tutorials/federations/integration-adfs.md#create-federation)
* [Google Workspace](../../../organization/tutorials/federations/integration-gworkspace.md#yc-settings)
* [{{ microsoft-idp.entra-id-short }}](../../../organization/tutorials/federations/integration-azure.md#yc-settings)
* [Keycloak](../../../organization/tutorials/federations/integration-keycloak.md#yc-settings)
* [SAML-compatible federation](../../../organization/operations/setup-federation.md#create-federation)
