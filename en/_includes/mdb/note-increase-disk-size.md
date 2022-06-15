{% if audience != "internal" %}
Make sure that:

* The required cluster doesn't use non-replicated SSD storage. You can't increase the size of non-replicated SSD storage.
* The cloud has sufficient quota to increase storage capacity. Open your cloud's [Quotas]({{ link-console-quotas }}) page and make sure that under **Managed Databases**, there is space available in the **HDD storage capacity** or the **SSD storage capacity** lines.
{% endif %}
