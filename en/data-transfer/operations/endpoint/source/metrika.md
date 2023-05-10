---
noIndex: true
---

# Configuring source endpoints {{ metrika-endpoint }}

{% include [note-metrica-pro](../../../../_includes/data-transfer/note-metrica-pro.md) %}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to [{{ metrika }}]({{ metrika-link }}).

## Settings {#settings}

{% list tabs %}

- Management console

   * **Tags**: Specify the [numbers of the tags]({{ link-yandex }}/support/metrica/general/tag-id.html) the data will be coming from.
   * **Token**: Specify the OAuth token of the user with permission to edit the tag. To obtain it, follow this [link]({{ ya-oauth-url }}/authorize?response_type=token&client_id=36b7fc9aa96c4fa09158bcacbbdc796a).
   * **Hits**: Select whether information about hits should be transferred.
      * **Fields**: Select the hit fields to export. In addition to the fields you select, there are certain mandatory fields that are always exported.
   * **Sessions**: Select whether information about sessions (visits) should be transferred.
      * **Fields**: Select the session fields to export. In addition to the fields you select, there are certain mandatory fields that are always exported.

{% endlist %}

For more information about the settings, see the [service documentation]({{ link-yandex }}/support/metrica/index.html).

See [this tutorial](../../../tutorials/metrika-to-clickhouse.md) on how to transfer {{ metrika }} tag data to a {{ CH }} cluster.