{% note warning %}

The access is checked against the object [ACL](../../storage/security/acl.md) after the {{ sts-name }} policy check. Therefore, if the service account you are using to obtain temporary access keys has ACL permissions configured for objects in the bucket, those objects will become available for temporary access key requests, regardless of the specified policy. For more information, see the {{ objstorage-name }} [access management mechanisms diagram](../../storage/security/overview.md).

{% endnote %}
