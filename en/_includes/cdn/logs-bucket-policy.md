{% note info %}

Do not configure an [access policy](../../storage/concepts/policy.md) that denies access to the bucket. If your access policy restricts access to the bucket, you will get the `403 Forbidden` error in response to your log export request. Even after you restore access to the bucket, logs that could not be written will not be exported.

{% endnote %}
