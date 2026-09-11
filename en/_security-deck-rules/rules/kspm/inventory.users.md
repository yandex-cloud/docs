### OS-level user inventory {#users}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.users ||
|#

#### Description

This inventory rule collects data on users across worker nodes using an inventory agent.

Queries:

logged. List logged in users with ssh keys.

```SELECT lu.user, lu.tty, lu.host, lu.time, u.directory, u.shell, u.uid, au.key, au.key_file FROM (SELECT * FROM logged_in_users WHERE type='user') lu JOIN users u ON u.username = lu.user JOIN authorized_keys au USING (uid);```

groups. Users and groups from etc_passwd.

```SELECT users.uid, users.gid, groups.groupname, users.directory, users.username, users.shell FROM users LEFT JOIN groups ON groups.gid = users.gid;```

groups_s. Users and groups from etc_passwd snapshot.

```SELECT users.uid, users.gid, groups.groupname, users.directory, users.username, users.shell FROM users LEFT JOIN groups ON groups.gid = users.gid;```

empty_passwd. List users with empty passwords.

```SELECT * FROM shadow WHERE (password_status = 'empty') OR (hash_alg='' AND password_status='active');```

password_expires. To warn users when password expires.

```SELECT * FROM shadow WHERE (expire < 7) AND (expire > 0);```

list. List changes in users.

```SELECT * FROM users;```

list_s. List users.

```SELECT * FROM users;```

list_groups. List changes in groups.

```SELECT * FROM groups;```

list_groups_s. List groups.

```SELECT * FROM groups;```

ipmi. Detect ipmi login.

```SELECT type, user, tty, pid FROM logged_in_users WHERE type != 'dead' AND tty LIKE 'tty%';```

You can analyze the results by exporting event data from [Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) to your SIEM or SOC system.

#### Instructions and solutions

This rule does not require guidance since it is informational and used to collect inventory events within Audit Trails.

You can configure [event collection for Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) in Audit Trails and export the data to SIEM or SOC systems to analyze the inventory results.
