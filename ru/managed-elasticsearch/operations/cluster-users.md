# Управление пользователями {{ ES }}

Вы можете управлять пользователями кластера с помощью специального пользователя `admin`. Задать пароль этого пользователя можно при [создании](cluster-create.md#create-cluster) или [изменении](cluster-update.md#change-admin-password) кластера.

Доступные интерфейсы для управления:
- [Security API {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-api.html#security-user-apis).
- [Kibana](https://www.elastic.co/guide/en/kibana/current/xpack-security.html#_users_2). Подробнее о подключении к Kibana см. в разделе [{#T}](cluster-connect.md).

Для выполнения повседневных задач создайте отдельных пользователей с минимально необходимым [набором привилегий](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-privileges.html). Не рекомендуется применять для этих целей учетную запись `admin`, поскольку она имеет полный доступ к кластеру. Отправленная от ее имени ошибочная команда может привести к неработоспособности кластера.

Подробнее о ролях и привилегиях см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/authorization.html).
