# SQL command limits

{{ mmy-short-name }} has some limits on DB owner actions using SQL commands:

* You can't change the {{ MY }} settings.
* You can't manage users and user permissions at the level of the entire cluster or an individual database. However, you can [grant user privileges](../operations/grant.md) at the level of individual DB objects.
* You can't create a database. However DB owners and users with the `ALL_PRIVILEGES` [privilege](user-rights.md#db-privileges) can run `ALTER DATABASE` for a previously created DB.
* No actions related to server administration are allowed.

See our [step-by-step instructions](../operations/index.md) on how to perform these actions using the {{ yandex-cloud }} tools.