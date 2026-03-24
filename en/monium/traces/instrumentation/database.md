# Working with databases

With [auto-instrumentation](auto.md), spans for database calls are created and attributes are filled automatically. If using [manual instrumentation](manual.md), follow the conventions described below.

## Naming convention {#naming}

The span name has the `<db.operation> <db.name>.<db.sql.table>` format, e.g., `SELECT shop.orders`. If any of the components is not available, you can omit it: `SELECT shop`, `SELECT orders`. For more information, see the [database span naming specification](https://opentelemetry.io/docs/specs/semconv/database/database-spans/#name).

## Attributes {#attributes}

#|
|| Attribute | Description ||
|| `db.system` | DBMS type: `mysql`, `postgresql`, `redis`, `mongodb`, etc. ||
|| `db.name` | Database name ||
|| `db.operation` | Operation: `SELECT`, `INSERT`, `UPDATE`, `DELETE` ||
|| `db.sql.table` | Table name ||
|| `db.statement` | Query text ||
|| `db.user` | Database username ||
|| `db.connection_string` | Connection string ||
|| `server.address` | Host name or IP address of the database server ||
|| `server.port` | Database server port ||
|#

{% note warning %}

The `db.statement` attribute may contain sensitive data. Ensure that queries do not include passwords, tokens, or any personally identifiable information in plaintext.

{% endnote %}

## Example {#example}

`order-service` runs a query to the MySQL database:

#|
|| Attribute | Value ||
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
