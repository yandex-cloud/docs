---
title: How to delete a function version
description: Follow this guide to delete a function version.
---

# Deleting a function version

{% note info %}

You cannot delete a function version if it has any [tags](../../concepts/function.md#tag). [Remove the tags](tag-delete.md) before deleting a function version.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To delete a function version, run this command:

  ```bash
  yc serverless function version delete <function_version_ID>
  ```

- API {#api}

  To delete a function version, use the [deleteVersion](../../functions/api-ref/Function/deleteVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/DeleteVersion](../../functions/api-ref/grpc/Function/deleteVersion.md) gRPC API call.

{% endlist %}