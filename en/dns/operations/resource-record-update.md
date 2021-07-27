---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Updating a resource record

You can change the value of a [resource record](../concepts/resource-record.md). To update a record:

{% list tabs %}

- Management console
  1. Open the **{{ dns-name }}** section in the folder where the DNS zone to update a record in is located.
  1. Select the zone from the list.
  1. Select **Records** in the menu on the left.
  1. Click ![image](../../_assets/options.svg) in the row of the record you want to update.
  1. In the menu that opens, click **Edit**.
  1. Change the record's TTL or value.
  1. Click **Save**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update a DNS zone:

  1. View a description of the CLI update record command:

     ```
     yc dns zone replace-records --help
     ```

  1. Change the record value:

     ```
     yc dns zone replace-records --name <zone name> \
     --record "<record domain name> 600 <record type> <new record value>"
     ```

{% endlist %}

