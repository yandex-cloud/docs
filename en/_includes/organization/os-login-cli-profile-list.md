Get a list of logins in the {{ oslogin }} profiles of the organization's users and service accounts by specifying the organization ID:

```bash
yc organization-manager os-login profile list \
  --organization-id <organization_ID>
```

Result:

```text
+----------------------+----------------------+-----------+----------------------+----------------------+------------+
|          ID          |        LOGIN         |    UID    |   ORGANIZATION ID    |      SUBJECT ID      | IS DEFAULT |
+----------------------+----------------------+-----------+----------------------+----------------------+------------+
| aje1eb5qm7jb******** | yc-sa-my-service-acc | 487816044 | bpfaidqca8vd******** | ajevnu4u2q3m******** | true       |
| ajegs81t2k9s******** | user1                | 760684761 | bpfaidqca8vd******** | aje7b4u65nb6******** | true       |
| ajej57b2kf0t******** | user2                |      1011 | bpfaidqca8vd******** | ajei280a73vc******** | true       |
+----------------------+----------------------+-----------+----------------------+----------------------+------------+
```

Save the `LOGIN` field value for the required user or service account: you will need it later.

{% include [os-login-profile-tab-access-notice](./os-login-profile-tab-access-notice.md) %}