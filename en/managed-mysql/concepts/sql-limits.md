---
title: SQL command limits in {{ mmy-full-name }}
description: '{{ mmy-short-name }} has some limits on DB owner actions when using SQL commands.'
---

# SQL command limits

{{ mmy-short-name }} has some limitations on DB owner actions when using SQL commands:

* You cannot change the {{ MY }} settings.
* You cannot manage users and user permissions at the level of the entire cluster or an individual database. However, you can [grant user privileges](./../operations/grant.md) at the level of individual DB objects.
* You cannot create databases; however, DB owners and users with the `ALL_PRIVILEGES` [privilege](user-rights.md#db-privileges) can run `ALTER DATABASE` for a previously created DB.
* No actions related to server administration are allowed.

You can, however, perform all these actions using the {{ yandex-cloud }} tools. To learn how, check out our [step-by-step guides](../operations/index.md).
