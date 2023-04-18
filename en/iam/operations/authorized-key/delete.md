---
title: "How to delete authorized keys in {{ iam-full-name }}"
description: "In this tutorial, you'll learn how to delete authorized keys in {{ iam-full-name }} via the management console, CLI, and API."
---

# Deleting authorized keys

{% list tabs %}

- Management console

   1. Go to the folder that the service account belongs to.
   1. Go to the **Service accounts** tab.
   1. Choose a service account and click the line with its name.
   1. Under **Authorized keys**, click ![image](../../../_assets/options.svg) next to the key to be deleted and select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   1. Get a list of authorized key `IDs` for a specific service account. Specify the service account name in the `--service-account-name` parameter:

      ```bash
      yc iam key list --service-account-name <service account name>
      ```

      Result:

      ```text
      +----------------------+-------------------------------------+-----------+---------------------+
      |          ID          |               SUBJECT               | ALGORITHM |     CREATED AT      |
      +----------------------+-------------------------------------+-----------+---------------------+
      | ajeave7oktutd6kha7lq | serviceAccount:ajeedllrkjmam6jsn9n4 | RSA_2048  | 2022-03-13 20:14:22 |
      | ajeb794igb80sl0fbpvp | serviceAccount:ajeedllrkjmam6jsn9n4 | RSA_2048  | 2022-03-13 20:06:13 |
      +----------------------+-------------------------------------+-----------+---------------------+
      ```

   1. Delete the old authorized key. Instead of `<ID>`, specify the authorized key ID:

      ```bash
      yc iam key delete <ID>
      ```

- API

   To delete an authorized key, use the [delete](../../api-ref/Key/delete.md) REST API method for the [Key](../../api-ref/Key/index.md) resource or the [KeyService/Delete](../../api-ref/grpc/key_service.md#Delete) gRPC API call.

{% endlist %}