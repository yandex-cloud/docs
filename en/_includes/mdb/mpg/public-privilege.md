{% note warning %}

For new users, the privilege to create tables in the `public` schema depends on the {{ PG }} version:

* Version 14 and below: The privilege is granted automatically and cannot be revoked.
* 15 and above: The privilege must be granted to the user [manually](../../../managed-postgresql/operations/grant.md#user-readonly).

{% endnote %}
