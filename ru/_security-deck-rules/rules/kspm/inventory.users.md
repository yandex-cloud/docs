### Инвентаризация пользователей ОС {#users}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.users ||
|#

#### Описание

Данное правило инвентаризации собирает информацию о пользователях на рабочих узлах с помощью агента инвентаризации.

Запросы:

logged. Список вошедших пользователей с SSH-ключами.

```SELECT lu.user, lu.tty, lu.host, lu.time, u.directory, u.shell, u.uid, au.key, au.key_file FROM (SELECT * FROM logged_in_users WHERE type='user') lu JOIN users u ON u.username = lu.user JOIN authorized_keys au USING (uid);```

groups. Пользователи и группы из etc_passwd.

```SELECT users.uid, users.gid, groups.groupname, users.directory, users.username, users.shell FROM users LEFT JOIN groups ON groups.gid = users.gid;```

groups_s. Снимок пользователей и групп из etc_passwd.

```SELECT users.uid, users.gid, groups.groupname, users.directory, users.username, users.shell FROM users LEFT JOIN groups ON groups.gid = users.gid;```

empty_passwd. Список пользователей с пустыми паролями.

```SELECT * FROM shadow WHERE (password_status = 'empty') OR (hash_alg='' AND password_status='active');```

password_expires. Предупреждение о скором истечении пароля.

```SELECT * FROM shadow WHERE (expire < 7) AND (expire > 0);```

list. Изменения в списке пользователей.

```SELECT * FROM users;```

list_s. Список пользователей.

```SELECT * FROM users;```

list_groups. Изменения в списке групп.

```SELECT * FROM groups;```

list_groups_s. Список групп.

```SELECT * FROM groups;```

ipmi. Обнаружение IPMI-логина.

```SELECT type, user, tty, pid FROM logged_in_users WHERE type != 'dead' AND tty LIKE 'tty%';```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
