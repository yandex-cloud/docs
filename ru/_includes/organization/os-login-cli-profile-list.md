Получите список логинов в [профилях {{ oslogin }}](../../organization/concepts/os-login.md#os-login-profiles) пользователей и сервисных аккаунтов нужной организации, указав ее идентификатор:

```bash
yc organization-manager os-login profile list \
  --organization-id <идентификатор_организации>
```

Результат:

```text
+----------------------+----------------------+-----------+----------------------+----------------------+------------+
|          ID          |        LOGIN         |    UID    |   ORGANIZATION ID    |      SUBJECT ID      | IS DEFAULT |
+----------------------+----------------------+-----------+----------------------+----------------------+------------+
| aje1eb5qm7jb******** | yc-sa-my-service-acc | 487816044 | bpfaidqca8vd******** | ajevnu4u2q3m******** | true       |
| ajegs81t2k9s******** | user1                | 760684761 | bpfaidqca8vd******** | aje7b4u65nb6******** | true       |
| ajej57b2kf0t******** | user2                |      1011 | bpfaidqca8vd******** | ajei280a73vc******** | true       |
+----------------------+----------------------+-----------+----------------------+----------------------+------------+
```

Сохраните значение поля `LOGIN` для нужного пользователя или сервисного аккаунта — оно понадобится позднее.

{% include [os-login-profile-tab-access-notice](./os-login-profile-tab-access-notice.md) %}