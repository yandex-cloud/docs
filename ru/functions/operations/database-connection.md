---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Подключение к управляемым БД из функции

Подключение к управляемым БД находится на стадии [Preview](../../overview/concepts/launch-stages.md).

Создайте подключение, чтобы обращаться из функций к хостам кластера Managed Service for PostgreSQL, для которых не настроен публичный доступ.

## Создать подключение

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать подключение.
    1. Откройте сервис **{{ sf-name }}**.
    1. Перейдите на вкладку **Подключения к БД**.
    1. Нажмите кнопку **Создать подключение**.
    1. Введите имя и описание подключения. Формат имени:

        {% include [name-format](../../_includes/name-format.md) %}

    1. Укажите:
        * кластер;
        * базу данных;
        * пользователя БД;
        * пароль пользователя.
    1. Нажмите кнопку **Создать**.

{% endlist %}

## Подключиться к БД

Чтобы обратиться из функции к хостам кластера БД, используя созданное подключение:
* в настройках версии функции укажите сервисный аккаунт, которому назначена роль `serverless.mdbProxies.user`. [Как назначить роль.](./function-public.md#add-access)
* в дополнительных настройках кластера включите опцию **Доступ из Serverless**.

Ниже приведены примеры функций для подключения к БД. Узнать идентификатор подключения и точку входа можно в [консоли управления]({{ link-console-main }}), на странице подключения.

{% list tabs %}

- Node.js

    ```js
    const pg = require('pg');

    module.exports.handler = async function (event, context) {
        let proxyId = "akfiotqh2mhktdhf7o47"; // Идентификатор подключения
        let proxyEndpoint = "akfiotqh2mhktdhf7o47.postgresql-proxy.serverless.yandexcloud.net:6432"; // Точка входа
        let user = "user1"; // Пользователь БД
        console.log(context.token);
        let conString = "postgres://" + user + ":" + context.token.access_token + "@" + proxyEndpoint + "/" + proxyId;

        let client = new pg.Client(conString);
        client.connect();

        let result = await client.query("SELECT 1");
        return result;
    };
    ```

- Python

    ```py
    import psycopg2


    def handler(event, context):
        connection = psycopg2.connect(
            database="akfiotqh2mhktdhf7o47", # Идентификатор подключения
            user="user1", # Пользователь БД
            password=context.token["access_token"],
            host="akfiotqh2mhktdhf7o47.postgresql-proxy.serverless.yandexcloud.net", # Точка входа
            port=6432,
            sslmode="require")
        cursor = connection.cursor()
        cursor.execute("SELECT 42;")
        record = cursor.fetchall()
        return record
    ```

- Go

    ```golang
    package main

    import (
        "context"
        "database/sql"
        "fmt"
        "github.com/yandex-cloud/go-sdk"

        _ "github.com/lib/pq"
    )

    const (
        host   = "akfv6p92v4gug2jncub5.postgresql-proxy.serverless.cloud-preprod.yandex.net" // Точка входа
        port   = 6432
        user   = "user1" // Пользователь БД
        dbname = "akfv6p92v4gug2jncub5" // Идентификатор подключения
    )

    type Response struct {
        StatusCode int         `json:"statusCode"`
        Body       interface{} `json:"body"`
    }

    // Получение IAM-токена сервисного аккаунта, указанного в настройках функции
    func getToken(ctx context.Context) string {
        resp, err := ycsdk.InstanceServiceAccount().IAMToken(ctx)
        if err != nil {
            panic(err)
        }
        return resp.IamToken
    }

    // Подключение к БД
    func Handler(ctx context.Context) (*Response, error) {
        psqlInfo := fmt.Sprintf("host=%s port=%d user=%s "+"password=%s dbname=%s sslmode=require",
            host, port, user, getToken(ctx), dbname)
        db, err := sql.Open("postgres", psqlInfo)
        if err != nil {
            panic(err)
        }
        defer db.Close()

        err = db.Ping()
        if err != nil {
            panic(err)
        }

        _, err = db.Query("select 1")
        if err != nil {
            panic(err)
        }

        return &Response{
            StatusCode: 200,
            Body:       "Successfully connected!",
        }, nil
    }
    ```

{% endlist %}