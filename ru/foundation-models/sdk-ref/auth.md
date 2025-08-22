---
sourcePath: en/_sdk-ref/sdk-ref/auth.md
---
# Authentication

Here must be algorithm about how auto-authorization works

And here – how SDK will work if you pass a string to SDK auth param

## Authentication methods classes

### *class* yandex\_cloud\_ml\_sdk.auth.**APIKeyAuth**{#yandex_cloud_ml_sdk.auth.APIKeyAuth}

Authentication method using an API key.

Read more about the API key in the [IAM documentation](https://yandex.cloud/docs/iam/concepts/authorization/api-key).

### *class* yandex\_cloud\_ml\_sdk.auth.**EnvIAMTokenAuth**{#yandex_cloud_ml_sdk.auth.EnvIAMTokenAuth}

Auth method, which takes IAM token from environment variable for every request.

It is assumed that the token will be refreshed in the environment before it expires.

However, by default, the YC\_TOKEN environment variable is used when auto-selecting the auth method, in order to be compatible with a Yandex DataSphere environment. Therefore, it is not recommended to use this environment variable when setting up a personal work environment.

### *class* yandex\_cloud\_ml\_sdk.auth.**IAMTokenAuth**{#yandex_cloud_ml_sdk.auth.IAMTokenAuth}

Authentication method using an IAM token.

Read more about the IAM token in [the AIM documentation](https://yandex.cloud/docs/iam/concepts/authorization/iam-token).

### *class* yandex\_cloud\_ml\_sdk.auth.**MetadataAuth**{#yandex_cloud_ml_sdk.auth.MetadataAuth}

Authentication class for retrieving IAM tokens from metadata service.

This class retrieves IAM tokens from the Google Cloud metadata service. Read more in [the VM metadata documentation](https://yandex.cloud/docs/compute/concepts/vm-metadata).

### *class* yandex\_cloud\_ml\_sdk.auth.**NoAuth**{#yandex_cloud_ml_sdk.auth.NoAuth}

### *class* yandex\_cloud\_ml\_sdk.auth.**OAuthTokenAuth**{#yandex_cloud_ml_sdk.auth.OAuthTokenAuth}

Auth method that uses an OAuth token for authentication.

This class extends the RefresheableIAMTokenAuth to provide functionality for managing and using an OAuth token for authentication purposes.

Read more about the OAuth token in [the corresponding documentation](https://yandex.cloud/docs/iam/concepts/authorization/oauth-token).

### *class* yandex\_cloud\_ml\_sdk.auth.**YandexCloudCLIAuth**{#yandex_cloud_ml_sdk.auth.YandexCloudCLIAuth}

Authentication class for Yandex Cloud CLI using IAM tokens.

It handles the initialization and retrieval of IAM tokens via the Yandex Cloud CLI that should be installed and configured.

Yandex Cloud CLI is a downloadable software for managing cloud resources via the command line. Read more in [the CLI documentation](https://yandex.cloud/docs/cli/).