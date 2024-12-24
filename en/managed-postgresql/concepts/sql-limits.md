---
title: SQL command limits in {{ mpg-full-name }}
description: '{{ mpg-short-name }} has some limitations on DB owner actions when using SQL commands.'
---

# SQL command limits

{{ mpg-short-name }} has some limitations on DB owner actions when using SQL commands:

* You cannot change the {{ PG }} settings.
* You cannot manage users or create and assign roles to them. However, you can [grant user privileges](../operations/grant.md) at the level of individual DB objects.
* You cannot create databases; however, DB owners and users with the `mdb_admin` or `mdb_superuser` [role](roles.md) can run the `ALTER DATABASE` command for a previously created DB.
* You cannot manage {{ PG }} extensions.
* No actions that require superuser privileges are allowed.

You can, however, perform all these actions using the {{ yandex-cloud }} tools. To learn how, check out our [step-by-step guides](../operations/index.md).
