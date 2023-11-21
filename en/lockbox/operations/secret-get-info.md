---
title: "How to get information about a secret in {{ lockbox-full-name }}"
---

# Getting information about a secret, its contents, and access rights

You can get detailed [information about a secret](#secret-info) and [secret contents](#secret-contents) and [view access rights to a secret](#secret-access).

## Getting information about a secret {#secret-info}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See a description of the CLI command to get information about a secret:

      ```bash
      yc lockbox secret get --help
      ```

   1. Get information about a secret by specifying its name or ID:

      ```bash
      yc lockbox secret get <secret_name_or_ID>
      ```

      Result:

      ```bash
      id: e6qi98vtdva1********
      folder_id: b1go79qlt1tp********
      created_at: "2023-11-03T15:28:18.909Z"
      name: test-secret
      kms_key_id: abj765aos682********
      status: ACTIVE
      current_version:
        id: e6q7nvojsgmk********
        secret_id: e6qi98vtdva1********
        created_at: "2023-11-03T15:28:18.909Z"
        status: ACTIVE
        payload_entry_keys:
          - example-key
      ```

{% endlist %}

## Getting the contents of a secret {#secret-contents}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get the contents of a secret:

      ```bash
      yc lockbox payload get --help
      ```

   1. Get the contents of a secret by specifying its name or ID:

      ```bash
      yc lockbox payload get <secret_name_or_ID>
      ```

      Result:

      ```bash
      version_id: e6q7nvojsgmk********
      entries:
        - key: example-key
          text_value: example-value
      ```

{% endlist %}

## Viewing access rights to a secret {#secret-access}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to view access rights to a secret:

      ```bash
      yc lockbox secret list-access-bindings --help
      ```

   1. View access rights to a secret by specifying its name or ID:

      ```bash
      yc lockbox secret list-access-bindings <secret_name_or_ID>
      ```

      Result:

      ```bash
      +---------+---------------+----------------------+
      | ROLE ID | SUBJECT TYPE  |      SUBJECT ID      |
      +---------+---------------+----------------------+
      | viewer  | federatedUser | ajej2i98kcjd******** |
      +---------+---------------+----------------------+
      ```

{% endlist %}