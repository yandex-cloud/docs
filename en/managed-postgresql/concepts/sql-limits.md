---
title: "SQL command limits in {{ mpg-short-name }}"
description: "{{ mpg-short-name }} has some limits on DB owner actions using SQL commands."
---

# SQL command limits

{{ mpg-short-name }} has some limits on DB owner actions using SQL commands:

* You can't change the {{ PG }} settings.
* You can't manage users and assign roles to them. However, you can [grant user privileges](../operations/grant.md) at the level of individual DB objects.
* You can't create a database. However, DB owners and users with the `mdb_admin` [role](roles.md) can run `ALTER DATABASE` for a previously created DB.
* You can't manage {{ PG }} extensions.
* No actions that require superuser privileges are allowed.

See our [step-by-step instructions](../operations/index.md) on how to perform these actions using the {{ yandex-cloud }} tools.