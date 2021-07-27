---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating an internal DNS zone

To create an internal [DNS zone](../concepts/dns-zone.md):

{% list tabs %}

- Management console
  1. Open the **{{ dns-name }}** section in the folder where you want to create a DNS zone.
  1. Click **Create zone**.
  1. Specify the zone settings:
     1. **Zone** name.
     1. **Zone**: Domain zone. The zone name must end with a dot.
     1. **Type**: Internal.
     1. Specify the networks whose resources will be included in the created zone.
  1. Click **Create**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a new DNS zone:

  1. View a description of the CLI create zone command:

     ```
     yc dns zone create --help
     ```

  1. Create a new internal DNS zone in the default folder:

     ```
     yc dns zone create --name test-zone \
     --zone staging. \
     --private-visibility network-ids=<network IDs for the zone>
     ```

     Command execution result:

     ```
     id: aet29qhara5jeg45tbjg
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-02-21T09:21:03.935Z"
     name: test-zone
     zone: staging.
     private_visibility:
       network_ids:
       - <network ID>
     ```

{% endlist %}

{% list tabs %}

