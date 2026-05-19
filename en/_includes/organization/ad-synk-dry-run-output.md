As a result, the agent [logs](../../organization/concepts/ad-sync.md#logging) will record changes that must be made to {{ org-full-name }} user and group data to align with the agent configuration updates.

For example:

```text
2026-04-22T06:46:35.504Zinfosynchronization/sync_process.go:542Would synchronize Users.			 Change type: Create. Successful: 10. Failed: 0
2026-04-22T06:46:35.504Zinfosynchronization/sync_process.go:542Would synchronize Users.			 Change type: Update. Successful: 0. Failed: 0
2026-04-22T06:46:35.504Zinfosynchronization/sync_process.go:542Would synchronize Users.			 Change type: Delete. Successful: 2. Failed: 0
2026-04-22T06:46:35.504Zinfosynchronization/sync_process.go:542Would synchronize Users.			 Change type: Activate. Successful: 0. Failed: 0
2026-04-22T06:46:35.504Zinfosynchronization/sync_process.go:542Would synchronize Users.			 Change type: Deactivate. Successful: 0. Failed: 0
2026-04-22T06:46:35.504Zinfosynchronization/sync_process.go:542Would synchronize Users.			 Change type: PasswordHashUpdate. Successful: 300. Failed: 0
2026-04-22T06:46:35.504Zinfosynchronization/sync_process.go:542Would synchronize Groups.			 Change type: Create. Successful: 5. Failed: 0
2026-04-22T06:46:35.504Zinfosynchronization/sync_process.go:542Would synchronize Groups.			 Change type: Update. Successful: 0. Failed: 0
2026-04-22T06:46:35.504Zinfosynchronization/sync_process.go:542Would synchronize Groups.			 Change type: Delete. Successful: 0. Failed: 0
2026-04-22T06:46:35.504Zinfosynchronization/sync_process.go:542Would synchronize Memberships.			 Change type: Create. Successful: 30. Failed: 0
2026-04-22T06:46:35.504Zinfosynchronization/sync_process.go:542Would synchronize Memberships.			 Change type: Delete. Successful: 0. Failed: 0
```

The example shows that, after synchronization starts, the system will apply these updates in {{ org-full-name }}:

* Create 10 new users.
* Delete two users.
* Update password hashes for 300 users.
* Create five user groups.
* Add 30 new user group memberships.