# Подключение к управляемым БД из функции

Создайте подключение, чтобы обращаться из функций к хостам кластера {{ mpg-full-name }} и {{ mch-full-name }}, для которых не настроен публичный доступ.

## Создать подключение {#create}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать подключение.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-mdb-proxy }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-mdb-proxy.list.button_create }}**.
    1. Введите имя и описание подключения. Формат имени:

        {% include [name-format](../../_includes/name-format.md) %}

    1. Укажите:
        * Кластер.
        * Базу данных.
        * Пользователя БД.
        * Пароль пользователя.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Подключиться к БД {#connect}

Чтобы обратиться из функции к хостам кластера БД, используя созданное подключение:
* в настройках версии функции укажите сервисный аккаунт, которому назначена роль `serverless.mdbProxies.user`. [Как назначить роль](./function/role-add.md).
* в дополнительных настройках кластера включите опцию **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}**.

Чтобы подключиться к БД из функции, в качестве пароля используйте [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, указанного в настройках версии функции. [Как получить IAM-токен](./function-sa.md).

Подключиться к БД из функции можно только по SSL.

## Примеры функций для подключения к БД

Узнать идентификатор подключения и точку входа можно в [консоли управления]({{ link-console-main }}), на странице подключения.

### {{ mpg-name }}

{% list tabs group=programming_language %}

- Node.js {#node}

    **index.js**

    ```js
    const pg = require('pg');

    module.exports.handler = async function (event, context) {
        let proxyId = "akfaf7nqdu**********"; // Идентификатор подключения
        let proxyEndpoint = "akfaf7nqdu**********.postgresql-proxy.serverless.yandexcloud.net:6432"; // Точка входа
        let user = "user1"; // Пользователь БД
        console.log(context.token);
        let conString = "postgres://" + user + ":" + context.token.access_token + "@" + proxyEndpoint + "/" + proxyId + "?ssl=true";

        let client = new pg.Client(conString);
        client.connect();

        let result = await client.query("SELECT 1;");
        return result;
    };
    ```

    **package.json**

    ```
    {
      "name": "my-app",
      "version": "1",
      "dependencies": {
        "pg": "8.7.3"
      }
    }
    ```

- Python {#python}

    ```py
    import psycopg2


    def handler(event, context):
        connection = psycopg2.connect(
            database="akfiotqh2m**********", # Идентификатор подключения
            user="user1", # Пользователь БД
            password=context.token["access_token"],
            host="akfiotqh2m**********.postgresql-proxy.serverless.yandexcloud.net", # Точка входа
            port=6432,
            sslmode="require")
        cursor = connection.cursor()
        cursor.execute("SELECT 42;")
        record = cursor.fetchall()
        return record
    ```

- Go {#go}

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
        host   = "akfv6p92v4**********.postgresql-proxy.serverless.cloud-preprod.yandex.net" // Точка входа
        port   = 6432
        user   = "user1" // Пользователь БД
        dbname = "akfv6p92v4**********" // Идентификатор подключения
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
        psqlInfo := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=require",
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

### {{ mch-name }}

{% list tabs group=programming_language %}

- Node.js {#node}

    ```js
    module.exports.handler = async function (event, context) {
        const https = require('https');
        const querystring = require('querystring');
        const fs = require('fs');

        const DB_HOST = "akfd3bhqk3**********.clickhouse-proxy.serverless.yandexcloud.net"; // Точка входа
        const DB_NAME = "akfd3bhqk3**********"; // Идентификатор подключения
        const DB_USER = "user1"; // Пользователь БД
        const DB_PASS = context.token.access_token;

        const CACERT = "/etc/ssl/certs/ca-certificates.crt";

        const options = {
            'method': 'GET',
            'ca': fs.readFileSync(CACERT),
            'path': '/?' + querystring.stringify({
                'database': DB_NAME,
                'query': 'SELECT version()',
            }),
            'port': 8443,
            'hostname': DB_HOST,
            'headers': {
                'X-ClickHouse-User': DB_USER,
                'X-ClickHouse-Key': DB_PASS,
            },
        };

        return {
            statusCode: 200,
            body: await new Promise((resolve) => {
                data = ''
                const req = https.request(options, (res) => {
                   res.setEncoding('utf8');
                   res.on('data', (chunk) => {
                     data += chunk;
                   });
                   res.on('end', () => { resolve(data) });
                });
                req.end();
            }),
        };
    };
    ```

- Python {#python}

    ```py
    import requests


    def handler(event, context):
        url = 'https://{host}:8443/?database={db}&query={query}'.format(
            host='akfd3bhqk3**********.clickhouse-proxy.serverless.yandexcloud.net', # Точка входа
            db='akfd3bhqk3**********', # Идентификатор подключения
            query='SELECT version()')

        auth = {
            'X-ClickHouse-User': 'user1', # Пользователь БД
            'X-ClickHouse-Key': context.token["access_token"],
        }

        cacert = '/etc/ssl/certs/ca-certificates.crt'

        rs = requests.get(url, headers=auth, verify=cacert)
        rs.raise_for_status()

        return {
            'statusCode': 200,
            'body': rs.text,
        }
    ```

- Go {#go}

    ```golang
    package main

    import (
        "context"
      "fmt"
      "net/http"
      "io/ioutil"
      "crypto/x509"
      "crypto/tls"

      ycsdk "github.com/yandex-cloud/go-sdk"
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
      const DB_HOST =  "akfd3bhqk3**********.clickhouse-proxy.serverless.yandexcloud.net" // Точка входа
      const DB_NAME = "akfd3bhqk3**********" // Идентификатор подключения
      const DB_USER = "user1" // Пользователь БД
      DB_PASS := getToken(ctx)

      caCertPool, _ := x509.SystemCertPool()
      conn := &http.Client{
        Transport: &http.Transport{
          TLSClientConfig: &tls.Config{ RootCAs: caCertPool },
        },
      }

      req, _ := http.NewRequest("GET", fmt.Sprintf("https://%s:8443/", DB_HOST), nil)
      query := req.URL.Query()
      query.Add("database", DB_NAME)
      query.Add("query", "SELECT version()")

      req.URL.RawQuery = query.Encode()

      req.Header.Add("X-ClickHouse-User", DB_USER)
      req.Header.Add("X-ClickHouse-Key", DB_PASS)

      resp, err := conn.Do(req)
      if err != nil {
        if resp != nil {
          data, _ := ioutil.ReadAll(resp.Body)
          panic(data)
        }
        panic(err)
      }
      defer resp.Body.Close()

      data, err := ioutil.ReadAll(resp.Body)
      if err != nil {
        panic(err)
      }

        return &Response{
            StatusCode: 200,
            Body:       string(data),
      }, nil
    }
    ```

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
