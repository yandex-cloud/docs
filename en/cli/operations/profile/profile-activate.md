---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Activating a profile

Having multiple profiles let you quickly switch your command execution context.

{% include [profile-name](../../../_includes/cli-profile-name.md) %}

1. Activate the profile with the `test` name:

    ```
    $ yc config profile activate test
    Profile 'test' activated
    ```

1. Make sure that the profile is activated. It will have the `ACTIVE` label next to it:

    ```
    $ yc config profile list
    prod
    test ACTIVE
    ```

