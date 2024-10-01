---
title: "How to delete a profile"
description: "Follow this guide to delete a profile."
---

# Deleting a profile

{% note warning %}

You cannot delete a profile if:
- It is an active profile.
- It is the only profile.

{% endnote %}

1. Get the list of profiles:
    
    ```bash
    yc config profile list
    prod ACTIVE
    test
    ```
1. Delete the `test` profile:
    ```bash
    yc config profile delete test
    Profile 'test' deleted
    ```
1. Make sure that the profile was deleted:
    ```bash
    yc config profile list
    prod ACTIVE
    ```
