Роль `iam.serviceAccounts.tokenCreator` позволяет пользователю получать IAM-токен для сервисного аккаунта.

C помощью такого [IAM-токена](../../../iam/concepts/authorization/iam-token.md) пользователь сможет [имперсонироваться](../../../iam/concepts/access-control/index.md#impersonation) в сервисный аккаунт и выполнять действия, разрешенные для этого [сервисного аккаунта](../../../iam/concepts/users/accounts.md#sa). 

Роль не позволяет пользователю изменять права доступа или удалять сервисный аккаунт.