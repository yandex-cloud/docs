---
title: "How to delete a profile"
description: "This guide describes how you can delete a profile."
---

# Deleting a profile

{% note warning %}

You cannot delete a profile if:
- It is an active profile.
- It is the only profile.

{% endnote %}

1. Get the list of profiles:

   ```
   yc config profile list
   prod ACTIVE
   test
   ```
1. Delete the `test` profile:
   ```
   yc config profile delete test
   Profile 'test' deleted
   ```
1. Make sure that the profile was deleted:
   ```
   yc config profile list
   prod ACTIVE
   ```
