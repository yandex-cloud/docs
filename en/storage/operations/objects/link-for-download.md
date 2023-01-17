# Getting a download link

If you have a public bucket, its objects are always available. You can get a link by following these instructions or generate one yourself. [Read more about the link format](../../concepts/object.md#object-url).

If you have a bucket with restricted access, {{ objstorage-name }} lets you generate a signed object link. Anyone who receives this link can download the object even from a bucket with restricted access. [Read more about pre-signed URLs, their generation, and their use](../../concepts/pre-signed-urls.md).

{% list tabs %}

- Management console

  {% include [storage-get-link-for-download](../../_includes_service/storage-get-link-for-download.md) %}

{% endlist %}
