[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for PostgreSQL](../index.md) > Вопросы и ответы > Пользователи и роли

# Пользователи и роли в Managed Service for PostgreSQL


#### Можно ли перенести пользователей из кластера-источника PostgreSQL в кластер-приемник Managed Service for PostgreSQL? {#user-migration}

Нет, пользователей нельзя автоматически перенести из стороннего кластера PostgreSQL или кластера Managed Service for PostgreSQL в кластер Managed Service for PostgreSQL. В кластере-приемнике нужно [создать пользователей](../operations/cluster-users.md#adduser) заново.

#### Как создать роль с помощью SQL-запросов? {#create-role}

С помощью SQL-запросов создать роль нельзя.

В PostgreSQL роль — это пользователь или группа пользователей БД. [Создать пользователя](../operations/cluster-users.md#adduser) в Managed Service for PostgreSQL можно только с помощью консоли управления, Yandex Cloud CLI, Terraform или API. Подробнее о создании пользователей читайте в [документации PostgreSQL](https://www.postgresql.org/docs/current/sql-createuser.html).

Вы можете [назначить пользователю привилегии](../operations/grant.md), которые определяют доступные для него действия с объектами БД.