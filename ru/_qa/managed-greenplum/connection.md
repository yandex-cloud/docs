#### Могу ли подключиться к БД от лица суперпользователя? {#super-user}

Нет, но вы можете подключиться от лица пользователя-администратора с ролью `mdb_admin`. Его набор привилегий заменяет суперпользователя. Подробнее читайте в разделе [{#T}](../../managed-greenplum/concepts/cluster-users.md#mdb_admin).

#### Как получить доступ к запущенному хосту базы данных? {#db-access}

Вы можете подключаться к базам данных {{ mgp-short-name }} способами, стандартными для СУБД.

[Подробнее о подключении к кластерам](../../managed-greenplum/operations/connect.md).

#### Как настроить аутентификацию пользователей? {#auth-user}

Настроить аутентификацию пользователей в {{ mgp-name }} можно с помощью [правил](../../managed-greenplum/operations/user-auth-rules.md).

Подробнее см. в разделе [{#T}](../../managed-greenplum/concepts/user-authentication.md).
