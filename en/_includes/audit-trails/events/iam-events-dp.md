Event name | Description
--- | ---
`awscompatibility.CreateEphemeralAccessKey` | Creating an ephemeral static access key
`awscompatibility.CreateTemporaryAccessKey` | Creating a temporary access key
`CreateIamToken` | Creating an IAM token
`credential.ApplicationLoginEvent` | User logon to the application
`credential.CreateRefreshTokenForSubject` | Creating a [refresh token](../../../iam/concepts/authorization/refresh-token.md) for a user
`credential.RevokeRefreshTokenForSubject` | Revoking a refresh token from a user
`credential.RevokeSsoSession` | Terminating a SSO session
`mfa.VerifyUserCredential` | Confirming user credentials when verifying additional [MFA factors](../../../organization/concepts/mfa.md)
`oslogin.CheckSshPolicy` | Checking permissions to connect via SSH with {{ oslogin }} access
`oslogin.GenerateSshCertificate` | Generating an SSH certificate for {{ oslogin }} access
`RevokeIamToken` | Revoking an IAM token