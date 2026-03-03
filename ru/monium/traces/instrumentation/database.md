# Работа с базами данных

Если вы используете [автоматическую инструментацию](auto.md), спаны для обращений к базам данных создаются и атрибуты заполняются автоматически. При [ручной инструментации](manual.md) следуйте конвенциям, описанным ниже.

## Конвенция именования {#naming}

Имя спана формируется как `<db.operation> <db.name>.<db.sql.table>`, например `SELECT shop.orders`. Если какой-то из компонентов недоступен, его можно опустить: `SELECT shop`, `SELECT orders`. Подробнее см. в [спецификации именования DB-спанов](https://opentelemetry.io/docs/specs/semconv/database/database-spans/#name).

## Атрибуты {#attributes}

#|
|| Атрибут | Описание ||
|| `db.system` | Тип СУБД: `mysql`, `postgresql`, `redis`, `mongodb` и др. ||
|| `db.name` | Имя базы данных ||
|| `db.operation` | Операция: `SELECT`, `INSERT`, `UPDATE`, `DELETE` ||
|| `db.sql.table` | Имя таблицы ||
|| `db.statement` | Текст запроса ||
|| `db.user` | Имя пользователя БД ||
|| `db.connection_string` | Строка подключения ||
|| `server.address` | Имя хоста или IP-адрес сервера БД ||
|| `server.port` | Порт сервера БД ||
|#

{% note warning %}

Атрибут `db.statement` может содержать чувствительные данные. Убедитесь, что в запросах не передаются пароли, токены и персональные данные в открытом виде.

{% endnote %}

## Пример {#example}

Сервис `order-service` выполняет запрос к базе данных MySQL:

#|
|| Атрибут | Значение ||
|| Name | `SELECT shop.orders` ||
|| Kind | `CLIENT` ||
|| Status | `OK` ||
|| `db.system` | `mysql` ||
|| `db.name` | `shop` ||
|| `db.operation` | `SELECT` ||
|| `db.sql.table` | `orders` ||
|| `db.statement` | `SELECT * FROM orders WHERE order_id = 'o4711'` ||
|| `db.user` | `billing_user` ||
|| `db.connection_string` | `Server=shopdb.example.com;Database=ShopDb;` ||
|| `server.address` | `shopdb.example.com` ||
|| `server.port` | `3306` ||
|#
