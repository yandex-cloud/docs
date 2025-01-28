## Deleting a public connection {#pub-del}

To delete an existing public connection from a trunk, create a [new support request]({{ link-console-support }}).

### Contacting support to delete a public connection from a trunk {#pub-ticket}

Follow this request format:
```s
Subject: [CIC] Deleting a public connection from a trunk.

Request text:
Please delete a public connection from a trunk.

trunk_id: euus5dfgchu23b******
pbc_id: cf3qxpv5pgf692******
```

Where:

* `trunk_id`: ID of the trunk the public connection was created in.
* `pbc_id`: ID of the public connection to delete.

### Support team's response to the customer's request {#pub-ticket-resp}

Support will notify you when the public connection is fully removed.

Example of support's response:

```s
The cf3qxpv5pgf692****** public connection was successfully deleted
from the euus5dfgchu23b****** trunk.
```

