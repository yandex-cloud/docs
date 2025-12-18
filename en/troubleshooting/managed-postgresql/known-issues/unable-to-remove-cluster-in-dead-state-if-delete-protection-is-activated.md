# You are unable to delete your {{ mpg-name }} cluster in the `DEAD` status if it has deletion protection enabled


## Issue description {#issue-description} 

* You are unable to delete a cluster in the `DEAD` status because it has deletion protection enabled.
* {{ mpg-name }} cluster switched to the `UNKNOWN` status right after it was created, and you are unable to delete it from the [management console]({{ link-console-main }}).

## Solution {#issue-resolution}

If your cluster status is `DEAD` or `UNKNOWN`, you can disable its deletion protection by running this YC CLI command:
```
yc managed-postgresql cluster update --deletion-protection=false <CLUSTER_ID>
```

Once done, you can delete this cluster as follows:
```
yc managed-postgresql cluster delete <CLUSTER_ID>
```

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). When creating a ticket, specify your cluster ID and describe the issue in brief.
