В результате в [логах](../../organization/concepts/ad-sync.md#logging) агента будут сохранены изменения, которые должны быть внесены в данные пользователей и групп {{ org-full-name }} в связи с изменениями, внесенными в конфигурацию агента.

Например:

```text
2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Create. Successful: 10. Failed: 0
2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Update. Successful: 0. Failed: 0
2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Delete. Successful: 2. Failed: 0
2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Activate. Successful: 0. Failed: 0
2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Deactivate. Successful: 0. Failed: 0
2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: PasswordHashUpdate. Successful: 300. Failed: 0
2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Groups. Change type: Create. Successful: 5. Failed: 0
2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Groups. Change type: Update. Successful: 0. Failed: 0
2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Groups. Change type: Delete. Successful: 0. Failed: 0
2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Memberships. Change type: Create. Successful: 30. Failed: 0
2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Memberships. Change type: Delete. Successful: 0. Failed: 0
```

Из приведенного примера видно, что после запуска синхронизации в {{ org-full-name }}:

* будет создано 10 новых пользователей;
* будет удалено 2 пользователя;
* будут обновлены хеши паролей для 300 пользователей;
* будет создано 5 групп пользователей;
* будет добавлено 30 новых членств пользователей в группах.