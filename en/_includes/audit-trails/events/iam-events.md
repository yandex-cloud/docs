Event name | Description
--- | ---
`AddFederatedUserAccounts` | Adding a user to a federation
`CreateAccessKey` | Creating a static key
`CreateApiKey` | Creating an API key
`CreateCertificate` | Adding a certificate for a federation
`CreateFederation` | Creating a federation
`CreateIamCookieForSubject` | Federated user login ^*^
`CreateKey` | Creating a key pair for a service account
`CreateServiceAccount` | Creating a service account
`DeleteAccessKey` | Deleting a static key
`DeleteApiKey` | Deleting API keys
`DeleteCertificate` | Deleting a certificate for a federation
`DeleteFederation` | Deleting a federation
`DeleteKey` | Deleting a key pair for a service account
`DeleteServiceAccount` | Deleting a service account
`DetectLeakedCredential` | Detecting a secret in a public source
`DisableService` | Revoking service access to resources of other cloud services
`EnableService` | Granting service access to resources of other cloud services
`RevokeLeakedCredential` | Revoking a compromised secret
`SetServiceAccountAccessBindings` | Assigning access permissions for a service account
`UpdateAccessKey` | Updating a static key
`UpdateApiKey` | Updating an API key
`UpdateCertificate` | Renewing a certificate
`UpdateFederation` | Updating a federation
`UpdateKey` | Updating a key pair
`UpdateServiceAccount` | Updating a service account
`UpdateServiceAccountAccessBindings` | Updating access permissions for a service account
`workload.CreateFederatedCredential` | Creating [a link](../../../iam/concepts/workload-identity.md#federated-credentials) in a service account federation
`workload.DeleteFederatedCredential` | Deleting a link from a service account federation
`workload.oidc.CreateFederation` | Creating a [workload identity federation](../../../iam/concepts/workload-identity.md)
`workload.oidc.DeleteFederation` | Deleting a workload identity federation
`workload.oidc.SetFederationAccessBindings` | Assigning access permissions to a workload identity federation
`workload.oidc.UpdateFederation` | Updating a workload identity federation
`workload.oidc.UpdateFederationAccessBindings` | Modifying access permissions of a workload identity federation

\* The event will not end up in the audit log unless the [audit log collection scope](../../../audit-trails/concepts/trail.md#collecting-area) for the trail is `Organization`.