The `storage.configurer` role allows you to manage object lifecycle, static website hosting, access policy, and CORS settings. It does not allow you to manage access control list (ACL) or public access settings, nor does it provide access to bucket data.

{% cut "Users with this role can:" %}

* View bucket [access policy](../../storage/concepts/policy.md) info, create, modify, and delete bucket access policies.
* View bucket [CORS](../../storage/concepts/cors.md) configuration info and modify the CORS configuration.
* View bucket [static website hosting](../../storage/concepts/hosting.md) configuration info and modify the static website hosting configuration.
* View bucket access [protocol](../../storage/concepts/bucket.md#bucket-https) info and change the access protocol.
* View bucket action [logging](../../storage/concepts/server-logs.md) settings and change the logging settings.
* View bucket [encryption](../../storage/concepts/encryption.md) settings and change the encryption settings.
* View bucket region info.
* View object [lifecycle](../../storage/concepts/lifecycles.md) configuration info and change the lifecycle configuration.
* View bucket [versioning](../../storage/concepts/versioning.md) settings.
* View [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) info.

{% endcut %}
