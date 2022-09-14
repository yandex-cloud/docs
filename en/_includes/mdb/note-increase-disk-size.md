{% if audience != "internal" %}
Make sure that:

* The required cluster doesn't use non-replicated SSD storage. You can't increase the size of non-replicated SSD storage.
* Make sure the cloud has enough quota to increase the storage size. Open the cloud's [Quotas]({{ link-console-quotas }}) page and make sure there is space available under **Managed Databases** in the **HDD storage capacity** or the **SDD storage capacity** line.
{% endif %}
