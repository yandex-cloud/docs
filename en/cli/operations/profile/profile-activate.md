# Activating a profile

Multiple profiles let you quickly switch your command execution context.

{% include [profile-name](../../../_includes/cli-profile-name.md) %}

1. Activate the `test` profile:

    ```bash
    yc config profile activate test
    Profile 'test' activated
    ```
1. Make sure that the profile is activated. It will have the `ACTIVE` label next to it:

    ```bash
    yc config profile list
    prod
    test ACTIVE
    ```
