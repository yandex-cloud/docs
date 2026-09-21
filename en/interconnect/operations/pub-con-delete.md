---
title: How to delete a public connection from a {{ interconnect-name }} trunk
description: Follow this guide to delete a public connection from a {{ interconnect-name }} trunk.
---

# Deleting a public connection

Currently, you can only delete a public connection by contacting support.

[Get information](pub-con-get-info.md) about a public connection and save the IDs of the connection and the trunk it was created in.

Create a [support ticket]({{ link-console-support }}) with the following content:

```text
Subject: [CIC] Deleting a public connection.

Please delete this public connection.

trunk_id: euus5dfgchu23b******
pbc_id: cf3qxpv5pgf692******
```

Where:

* `trunk_id`: Trunk ID.
* `pbc_id`: Public connection ID to delete.

Support will notify you when the operation is completed.
