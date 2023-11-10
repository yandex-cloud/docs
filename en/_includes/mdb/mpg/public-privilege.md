{% note warning %}

Granting the `public` table create privilege to new users depends on the {{ PG }} version:

* 14 and lower: The privilege is granted automatically and cannot be revoked.
* 15 and higher: The privilege is manually granted to the [user](../../../managed-postgresql/operations/grant.md#user-readonly).

{% endnote %}
