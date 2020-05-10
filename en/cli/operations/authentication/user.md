# Authenticating as a user

You can authenticate in the [profile creation wizard](../profile/profile-create.md#interactive-create) using the `yc init` command or following these steps:

1. Get an [OAuth token](../../../iam/concepts/authorization/oauth-token.md).
1. [Create a profile](../profile/profile-create.md#create).
1. Specify your OAuth token in the `token` parameter:

    ```
    $ yc config set token <OAuth token>
    ```

The OAuth token is saved in the profile configuration for automatically authenticating.

