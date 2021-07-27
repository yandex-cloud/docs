---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating a public DNS zone

To create a public [DNS zone](../concepts/dns-zone.md):

{% list tabs %}

- Management console
  1. Open the **{{ dns-name }}** section in the folder where you want to create a DNS zone.
  1. Click **Create zone**.
  1. Specify the zone settings:
     1. **Zone** name.
     1. **Zone**: Domain zone. The zone name must end with a dot. You can't create public top-level domain (TLD) zones.
     1. **Type**: **Public**.
  1. Click **Create**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a new DNS zone:

  1. View a description of the CLI create zone command:

     ```
     yc dns zone create --help
     ```

  1. Create a new public DNS zone in the default folder:

     ```
     yc dns zone create --name production-zone --zone www.example.com. --public-visibility
     ```

     Command execution result:

     ```
     id: aet2q4fn8i8icfug97p0
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-03-03T19:07:08.685Z"
     name: production-zone
     zone: www.example.com.
     public_visibility: {}
     ```

{% endlist %}

To get access to public zone domain names, you need to delegate the domain. Specify the addresses of the `ns1.yandexcloud.net` and `ns2.yandexcloud.net` servers in your personal dashboard at your registrar.

