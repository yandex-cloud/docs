## Deleting a trunk {#trunk-del}

{% note warning %}

Before deleting a trunk, you must delete all private and public connections created within it.

{% endnote %}

To delete a trunk and all connections within it, create a [new support ticket]({{ link-console-support }}).

### Contacting support to delete a trunk and all connections within it {#trunk-ticket}

Follow this request format:
```s
Subject: [CIC] Deleting a trunk and private connections within it.

Request text:

Please delete the following private connections with prc_id:
cf3qdug4fsf737******, cf3qdug4fsf78213******

Please delete the trunk with trunk_id euus5dfgchu23b******.
```

Where:

* `trunk_id`: Trunk ID
* `prc_id`: Private connection IDs

### Support team's response to your ticket {#priv-ticket-resp}

Support will notify you when the trunk has been deleted.

Support response example:

```s
The euus5dfgchu23****** trunk and
the cf3qdug4fsf737g2gpdu, cf3qdug4fsf78213****** private connections have been successfully deleted.
```

If you want to remove public connections from your trunk, you can add their IDs to the request under the `pbc_id` variable.

{% note info %}

Once your trunk is deleted, billing will no longer receive its data and you will no longer be charged for it.

{% endnote %}

