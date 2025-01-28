## Deleting a trunk {#trunk-del}

{% note warning %}

Before deleting a trunk, you must delete all private and public connections created in that trunk.

{% endnote %}

To delete a trunk and all connections within it, create a [new support request]({{ link-console-support }}).

### Contacting support to delete a trunk and all connections in it {#trunk-ticket}

Follow this request format:
```s
Subject: [CIC] Deleting a trunk and private connections in it.

Request text:

Please delete the following private connections with prc_id:
cf3qdug4fsf737******, cf3qdug4fsf78213******

Please delete the trunk with trunk_id euus5dfgchu23b******.
```

Where:

* `trunk_id`: ID of the trunk to delete.
* `prc_id`: List of private connection IDs to delete.

### Support team's response to the customer's request {#priv-ticket-resp}

Support will notify you when the trunk has been deleted.

Example of support's response:

```s
The euus5dfgchu23****** trunk and
the cf3qdug4fsf737g2gpdu, cf3qdug4fsf78213****** private connections have been deleted successfully.
```

If you want to remove public connections from your trunk, you can add them to the request text as a list of IDs (`pbc_id`).

{% note info %}

When your trunk is deleted, billing will no longer receive its data and you will no longer be charged for this trunk.

{% endnote %}

