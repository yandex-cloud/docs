---
title: "How to delete authorized keys in {{ iam-short-name }}"
description: "Following this guide you will learn how you can delete authorized keys in {{ iam-short-name }} via the management console, CLI and API of the service."
---

# Deleting authorized keys


{% list tabs %}

- Management console

   1. Go to the folder that the service account belongs to.
   1. Go to the **Service accounts** tab.
   1. Choose a service account and click the line with its name.
   1. Under **Authorized keys**, click ![image](../../../_assets/options.svg) next to the key to be deleted and select **Delete**.
   1. Confirm the deletion.

- CLI

   1. Get a list of authorized key `IDs` for a specific service account. Specify the service account name in the `--service-account-name` parameter:

      ```bash
      yc iam key list --service-account-name <service account name>
      ```

      Result:

      ```bash
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

   To delete the authorized key, use the [delete](../../api-ref/Key/delete.md) method for the [Key](../../api-ref/Key/index.md) resource.

{% endlist %}