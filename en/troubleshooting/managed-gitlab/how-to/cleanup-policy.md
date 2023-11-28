# How to set up a cleanup policy when running out of space



## Scenario description {#case-description}

You need to set up cleanup.

## Solution {#case-resolution}

To clean up space, you need to set up a cleanup policy. For enabling cleanup policies, see [here](https://docs.gitlab.com/ee/user/packages/container_registry/reduce_container_registry_storage.html#enable-the-cleanup-policy).

You will need to:
1. [Configure settings](https://docs.gitlab.com/ee/api/settings.html#get-current-application-settings)
2. Enter the required parameters and [apply the settings](https://docs.gitlab.com/ee/api/settings.html#change-application-settings).

By default, the cleanup policy is called every 12 hours. As a one-off solution, you can try deleting irrelevant tags manually, for example, using the {{ mgl-full-name }} interface.