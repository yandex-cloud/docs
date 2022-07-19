# Deleting a profile

{% note warning %}

You can't delete a profile if:
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
