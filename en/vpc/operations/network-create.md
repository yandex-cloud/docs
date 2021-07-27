---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating a cloud network

In addition to the cloud network in the default folder, you can create cloud networks in other folders.

{% list tabs %}

- Management console

  To create a [cloud network](../concepts/network.md):

  1. Open the **Virtual Private Cloud** section in the folder where you want to create the cloud network.

  1. Click **Create network.**

  1. Enter the network name.

      {% include [name-format](../../_includes/name-format.md) %}

  1. Click **Create network**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a [cloud network](../concepts/network.md):

  1. See the description of the CLI command for creating a cloud network:

      ```
      $ yc vpc network create --help
      ```

  1. Create a cloud network in the default folder:

      ```
      $ yc vpc network create --name test-network-1 \
          --description "My test network"
      ```

      {% include [name-format](../../_includes/name-format.md) %}

      The `--name` and `--description` flags are optional: you can create a network without any name or description and access it by ID.

  1. Get a list of all cloud networks in the default folder:

      ```
      $ yc vpc network list
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpiuvhhd4t80k4n80i8 | test-network-1 |
      | enplom7a98s1t0lhass8 | default        |
      +----------------------+----------------+
      ```

      Get the same list with more details in YAML format:

      ```
      $ yc vpc network list --format yaml
      - id: enpiuvhhd4t80k4n80i8
        folder_id: b1g6ci08ma55klukmdjs
        created_at: "2018-10-23T11:12:51Z"
        name: test-network-1
        description: My first network
      - id: enplom7a98s1t0lhass8
        folder_id: b1g6ci08ma55klukmdjs
        created_at: "2018-09-24T08:23:00Z"
        name: default
        description: Auto-created default network
      ```

{% endlist %}

## Examples {#examples}

Create a cloud network with a name and description in the selected folder:

{% list tabs %}

- CLI

  ```
  $ yc vpc network create --name test-network-1 \
    --description "My test network" \
    --folder-id b1gnbfd11bq5g5vnjgr4
  ```

{% endlist %}

