{% note warning %}

The access is checked by object [ACL](../../storage/security/acl.md) after checking the {{ sts-name }} policy. Therefore, if the service account through which you obtain temporary access keys has ACL permissions configured for objects in the bucket, those objects will become available for temporary access key requests, regardless of the specified policy. For more information, see [how the access management works](../../storage/security/overview.md) in {{ objstorage-name }}.

{% endnote %}
