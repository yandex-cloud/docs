---
title: "How to delete static access keys in {{ iam-full-name }}"
description: "In this tutorial, you'll learn how to delete static access keys in {{ iam-full-name }} via the management console, CLI, and API."
---

# Deleting static access keys

{% list tabs %}

- Management console

   1. Go to the folder that the service account belongs to.
   1. Go to the **Service accounts** tab.
   1. Choose a service account and click the line with its name.
   1. Under **Access keys**, click ![image](../../../_assets/options.svg) next to the key to be deleted and select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   1. Get a list of static key `IDs` for a specific service account. Specify the service account name in the `--service-account-name` parameter:

      ```bash
      yc iam access-key list --service-account-name <service account name>
      ```

      Result:

      ```text
      +----------------------+----------------------+----------------------+
      |          ID          |  SERVICE ACCOUNT ID  |        KEY ID        |
      +----------------------+----------------------+----------------------+
      | aje8bdtqec6llp7fe49h | ajeedllrkjmam6jsn9n4 | R9JK04o1Dfaf1onhJ33a |
      | ajegqpa91btat1gvhvl6 | ajeedllrkjmam6jsn9n4 | cWXGkDoBRho5KISqk8An |
      +----------------------+----------------------+----------------------+
      ```

   1. Delete the old static key. Instead of `<ID>`, specify the static key ID:

      ```bash
      yc iam access-key delete <ID>
      ```

- API

   To delete the static key, use the [delete](../../api-ref/AccessKey/delete.md) method for the [AccessKey](../../api-ref/AccessKey/index.md) resource.

{% endlist %}