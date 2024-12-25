To search data via the {{ yandex-cloud }} REST API:

1. {% include [create-sa](create-sa.md) %}
1. [Add the service account to the namespace](../../../speechsense/operations/space/add-user-to-space.md) with the `{{ roles-speechsense-data-viewer }}` role. This will allow your service account to work with data in {{ speechsense-name }}.
1. {% include [create-api-key](create-api-key.md) %}
1. [Upload voice call recordings](../../../speechsense/operations/data/upload-data.md) or [chat transcripts](../../../speechsense/operations/data/upload-chat-text.md) to {{ speechsense-name }}.
