{% note info %}

Do not use an [ANAME](../../dns/concepts/resource-record.md#aname) resource record with domain names for content distribution; otherwise, the end user will get a response from a CDN server not linked to the user's geolocation. The response will always be the same for all users.

{% endnote %}