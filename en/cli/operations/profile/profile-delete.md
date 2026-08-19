---
title: How to delete a profile
description: Follow this guide to delete a profile.
---

# Deleting a {{ yandex-cloud }} CLI profile

{% note warning %}

You cannot delete a profile if:
- It is an active profile.
- It is the only profile.

If it is the only profile, [delete](./manage-properties.md#unset) its parameters one by one.

{% endnote %}

1. Get the list of profiles:
    
    ```bash
    yc config profile list
    ```

    Result:

    ```text
    prod ACTIVE
    test
    ```
1. Delete the `test` profile:

    ```bash
    yc config profile delete test
    ```

    Result:

    ```text
    Profile 'test' deleted
    ```
1. Make sure that the profile was deleted:

    ```bash
    yc config profile list
    ```

    Result:

    ```text
    prod ACTIVE
    ```
