# You are unable to delete your Managed Service for PostgreSQL cluster in the Dead status if deletion protection was enabled for it

## Issue description {#issue-resolution}

How this issue can manifest:
* You are unable to delete a cluster in the `Dead` status because it has deletion protection enabled.
* Managed Service for PostgreSQL cluster switched to the `Unknown` status immediately after creation, and you are unable to delete it from the management console.

## Solution {#issue-resolution}

If a cluster is in the `DEAD`/`UNKNOWN` status, you can disable deletion protection using the YC CLI:

```
yc managed-postreqsl cluster update --deletion-protection=false <CLUSTER_ID>
```

Once this operation completes, you can delete this cluster in the YC CLI as well:

```
yc managed-postreqsl cluster delete <CLUSTER_ID>
```

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In your request, specify the ID of the problem cluster and briefly describe the issue.
