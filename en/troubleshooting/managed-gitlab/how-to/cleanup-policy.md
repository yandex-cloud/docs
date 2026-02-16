# How to set up a cleanup policy when running out of space



## Case description {#case-description}

You need to set up cleanup because you have run out of space.

## Solution {#case-resolution}

To clean up space, you need to set up a cleanup policy. Learn how to enable cleanup policies [here](https://docs.gitlab.com/ee/user/packages/container_registry/reduce_container_registry_storage.html#enable-the-cleanup-policy). 

You will need to:

1. [Configure your application](https://docs.gitlab.com/ee/api/settings.html#get-current-application-settings).
1. Enter the required parameters and [apply the settings](https://docs.gitlab.com/ee/api/settings.html#change-application-settings).

{% note info %}

By default, the cleanup policy is called every 12 hours. As a one-off solution, you can try deleting irrelevant tags manually, using the {{ mgl-name }} interface as well.

{% endnote %}