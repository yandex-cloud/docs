{% note warning %}

If the cluster already uses a service account to access objects from {{ objstorage-name }}, then changing it to a different service account may make these objects unavailable and interrupt the cluster operation. Before changing the service account settings, make sure that the cluster doesn't use the objects in question.

{% endnote %}