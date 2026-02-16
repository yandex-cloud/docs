Event name | Description
--- | ---
`CreateAccessKey` | Creating a static key
`CreateApiKey` | Creating an API key
`CreateCertificate` | Adding a certificate for a federation
`CreateIamCookieForSubject` | Federated user login ^*^
`CreateKey` | Creating a key pair for a service account
`CreateServiceAccount` | Creating a service account
`DeleteAccessKey` | Deleting a static key
`DeleteApiKey` | Deleting API keys
`DeleteCertificate` | Deleting a certificate for a federation
`DeleteKey` | Deleting a key pair for a service account
`DeleteServiceAccount` | Deleting a service account
`DetectLeakedCredential` | Detecting a secret in a public source
`DisableService` | Revoking service access to resources of other cloud services
`EnableService` | Granting service access to resources of other cloud services
`mfa.CreateUserCredential` | Creating user credentials during verification of additional [MFA factors](../../../organization/concepts/mfa.md)
`mfa.DeleteUserCredential` | Deleting user credentials during verification of additional [MFA factors](../../../organization/concepts/mfa.md)
`mfa.UpdateUserCredential` | Updating user credentials during verification of additional [MFA factors](../../../organization/concepts/mfa.md)
`oauthclient.CreateOAuthClient` | Creating an OAuth client
`oauthclient.CreateOAuthClientSecret` | Creating a secret for an OAuth client
`oauthclient.DeleteOAuthClient` | Deleting an OAuth client
`oauthclient.DeleteOAuthClientSecret` | Deleting a secret for an OAuth client
`oauthclient.UpdateOAuthClient` | Updating an OAuth client
`RevokeLeakedCredential` | Revoking a compromised secret
`SetServiceAccountAccessBindings` | Assigning access permissions for a service account
`UpdateAccessKey` | Updating a static key
`UpdateApiKey` | Updating an API key
`UpdateCertificate` | Renewing a certificate
`UpdateKey` | Updating a key pair
`UpdateServiceAccount` | Updating a service account
`UpdateServiceAccountAccessBindings` | Updating access permissions for a service account
`workload.CreateFederatedCredential` | Creating [federated credentials](../../../iam/concepts/workload-identity.md#federated-credentials) in a workload identity federation
`workload.DeleteFederatedCredential` | Deleting federated credentials from a workload identity federation
`workload.oidc.CreateFederation` | Creating a [workload identity federation](../../../iam/concepts/workload-identity.md)
`workload.oidc.DeleteFederation` | Deleting a workload identity federation
`workload.oidc.SetFederationAccessBindings` | Assigning access permissions to a workload identity federation
`workload.oidc.UpdateFederation` | Updating a workload identity federation
`workload.oidc.UpdateFederationAccessBindings` | Modifying access permissions of a workload identity federation

\* The event will not end up in the audit log unless the [audit log collection scope](../../../audit-trails/concepts/trail.md#collecting-area) for the trail is `Organization`.
