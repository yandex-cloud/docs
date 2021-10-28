To connect to the database and run a test application:

{% list tabs %}

- Python

  1. Clone the [YDB Python SDK](https://github.com/yandex-cloud/ydb-python-sdk) repository and install the `ydb`, `iso8601`, and `yandexcloud` libraries:

      ```bash
      git clone https://github.com/yandex-cloud/ydb-python-sdk.git
      sudo pip3 install iso8601 ydb yandexcloud
      ```

  1. Create an authorized key for your service account and save the file [using the CLI](../../iam/operations/iam-token/create-for-sa#via-cli):

     1. View a description of the command:

        ```bash
        yc iam key create --help
        ```

     1. Run the command, indicating the following parameters:
        * `folder_id`: ID of the folder.
        * `service-account-name`: Service account name.

        ```bash
        yc iam key create --folder-id b1geoelk7fldts6chmjq --service-account-name sa-ydb-user --output ~/.ydb/sa_name.json
        ```

  1. Set the `SA_KEY_FILE` environment variable:

     ```bash
     export SA_KEY_FILE=~/.ydb/sa_name.json
     ```

     {% note info %}

     To connect to the YDB Dedicated database, set the environment variable with the certificate:

      ```bash
      export YDB_SSL_ROOT_CERTIFICATES_FILE=~/.ydb/CA.pem
      ```

     {% endnote %}

  1. Run the `basic_example_v1` test app from the `ydb-python-sdk` repository, specifying the following values as startup parameters:
      * `protocol`: Name of the protocol used to access the database, such as `grpcs`.
      * `endpoint`: Database endpoint.
      * `database`: Database ID.

      ```bash
      cd ./ydb-python-sdk/examples/basic_example_v1
      python3 __main__.py \
      -e grpcs://ydb.serverless.yandexcloud.net:2135 \
      -d /ru-central1/b1gia87mbaomkfvsleds/etn03o8tbtd3r07sner3
      ```

      App execution results:

      ```bash
      > describe table: series
      column, name: series_id , Uint64
      column, name: title , Utf8
      column, name: series_info , Utf8
      column, name: release_date , Uint64
      column, name: comment , Utf8
      
      > select_simple_transaction:
      series, id:  1 , title:  IT Crowd , release date:  b'2006-02-03'
      
      > select_prepared_transaction:
      episode title: To Build a Better Beta , air date: b'2016-06-05'
      
      > select_prepared_transaction:
      episode title: Bachman's Earnings Over-Ride , air date: b'2016-06-12'
      
      > explicit TCL call
      
      > select_prepared_transaction:
      episode title: TBD , air date: b'2019-05-10'
      ```

- Go

  1. Install the [YDB Go SDK](https://github.com/yandex-cloud/ydb-go-sdk):

      ```bash
      go get -u github.com/yandex-cloud/ydb-go-sdk
      go get github.com/dgrijalva/jwt-go
      ```

  1. Get an IAM token for the appropriate service account [using the CLI](../../iam/operations/iam-token/create-for-sa#via-cli):

     1. View a description of the command:

        ```bash
        yc iam key create --help
        ```

     1. Run the command:

        ```bash
        yc iam key create --service-account-name sa_name -o  ~/.ydb/sa_name.json
        ```

  1. Set the `SA_KEY_FILE` environment variable required for application authentification:

      ```bash
      export SA_SERVICE_FILE=~/.ydb/sa_name.json
      ```

      Where:
      * `SA_SERVICE_FILE`: Local path to the IAM token file.

  1. Compile the `basic_example_v1` test app:

      ```bash
      go build github.com/yandex-cloud/ydb-go-sdk/example/basic_example_v1/
      ```

  1. Launch `basic_example_v1`, specifying the values of the endpoint and database ID obtained earlier as startup parameters and the path to the saved SSL certificate:

      ```bash
      ./basic_example_v1 -endpoint endpoint -database database -root-ca ~/.ydb/CA.pem
      ```

      App execution results:

      ```bash
      > describe table: /ru-central1/b1gia87mbaomkfvsleds/etn0061p28k0t9rajt8d/series
      column, name: Optional<Uint64>, series_id
      column, name: Optional<Utf8>, title
      column, name: Optional<Utf8>, series_info
      column, name: Optional<Uint64>, release_date
      column, name: Optional<Utf8>, comment
      
      > select_simple_transaction: 1 IT Crowd 2006-02-03
      ```

- Node.js

  1. Install the [YDB Node.js SDK](https://github.com/yandex-cloud/ydb-nodejs-sdk):

      ```bash
      git clone https://github.com/yandex-cloud/ydb-nodejs-sdk.git
      cd ydb-nodejs-sdk/examples
      npm install
      npm run build
      ```

  1. Get an IAM token for the appropriate service account [using the CLI](../../iam/operations/iam-token/create-for-sa#via-cli):

     1. View a description of the command:

        ```bash
        yc iam key create --help
        ```

     1. Run the command:

        ```bash
        yc iam key create --service-account-name sa_name -o  ~/.ydb/sa_name.json
        ```

     {% note info %}

     To connect to the YDB Dedicated database, set the environment variable with the certificate:

      ```bash
      export YDB_SSL_ROOT_CERTIFICATES_FILE=~/.ydb/CA.pem
      ```

     {% endnote %}

  1. Set the environment variables required for app authentication:

      ```bash
      export YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS=~/.ydb/sa_name.json
      export IAM_ENDPOINT=iam.api.cloud.yandex.net:443
      export ENTRYPOINT=grpcs://<endpoint>
      export DB=<database>
      export YDB_SDK_LOGLEVEL=debug
      ```
      * `YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS`: Local path to the IAM token file.
      * `IAM_ENDPOINT`: IAM endpoint. Set it to `iam.api.cloud.yandex.net:443`.
      * `ENTRYPOINT`: Database endpoint.
      * `DB`: YDB database ID.
      * `YDB_SDK_LOGLEVEL`: Logging level. Set it to `debug`.

  1. Run the `basic_example_v1` test app:

      ```bash
      npm run basic-v1 -- --db <YDB database> --endpoint <database endpoint>
      ```

      App execution results:

      ```bash
      node build/basic-example-v1/index.js $ENTRYPOINT $DB | pino-pretty
      [1603883537002] INFO  (58433 on laptop): Running basic-example script against entry-point 'grpcs://ydb.serverless.yandexcloud.net:2135' and database '/ru-central1/b1gia87mbaomkfvsleds/etn0061p28k0t9rajt8d'.
      [1603883537003] DEBUG (58433 on laptop): Protocol grpcs specified in entry-point, using SSL connection.
      [1603883537003] DEBUG (58433 on laptop): SA_JSON_FILE env var found, using IamAuthService with params from that json.
      [1603883537004] DEBUG (58433 on laptop): Driver initializing...
      [1603883537589] DEBUG (58433 on laptop): Driver is ready!
      [1603883537833] DEBUG (58433 on laptop): Acquired session ydb://session/3?node_id=12065&id=ZTM4OGQwMjktOTk5ZGRiOGQtZWRiZTFmZjMtYmRmYWY3ZTA= on endpoint ydb.serverless.yandexcloud.net:2135.
      [1603883537833] INFO  (58433 on laptop): Dropping old tables...
      [1603883538114] INFO  (58433 on laptop): Creating tables...
      [1603883538660] INFO  (58433 on laptop): Describing table: series
      [1603883538735] INFO  (58433 on laptop): Column name 'series_id' has type {"optionalType":{"item":{"typeId":"UINT64"}}}
      [1603883538735] INFO  (58433 on laptop): Column name 'title' has type {"optionalType":{"item":{"typeId":"UTF8"}}}
      [1603883538735] INFO  (58433 on laptop): Column name 'series_info' has type {"optionalType":{"item":{"typeId":"UTF8"}}}
      [1603883538735] INFO  (58433 on laptop): Column name 'release_date' has type {"optionalType":{"item":{"typeId":"UINT64"}}}
      [1603883538736] INFO  (58433 on laptop): Inserting data to tables, preparing query...
      [1603883538807] INFO  (58433 on laptop): Query has been prepared, executing...
      [1603883538915] DEBUG (58433 on laptop): Released session ydb://session/3?node_id=12065&id=ZTM4OGQwMjktOTk5ZGRiOGQtZWRiZTFmZjMtYmRmYWY3ZTA= on endpoint ydb.serverless.yandexcloud.net:2135.
      [1603883538915] DEBUG (58433 on laptop): Acquired session ydb://session/3?node_id=12065&id=ZjY5NWRlM2EtYWMyYjA5YWEtNzQ0MTVlYTMtM2Q4ZDgzOWQ= on endpoint ydb.serverless.yandexcloud.net:2135.
      [1603883538915] INFO  (58433 on laptop): Making a simple select...
      [1603883539008] INFO  (58433 on laptop): selectSimple result:
      [1603883539008] INFO  (58433 on laptop): Making an upsert...
      [1603883539057] INFO  (58433 on laptop): Upsert completed.
      [1603883539057] INFO  (58433 on laptop): Preparing query...
      [1603883539119] INFO  (58433 on laptop): Selecting prepared query...
      [1603883539168] INFO  (58433 on laptop): Select prepared query
      [1603883539244] INFO  (58433 on laptop): Select prepared query
      [1603883539244] INFO  (58433 on laptop): Running prepared query with explicit transaction control...
      [1603883539456] INFO  (58433 on laptop): Executing query with txId 5e3f1eb1-d532afbf-ead22387-53272811.
      [1603883539558] INFO  (58433 on laptop): TxId 5e3f1eb1-d532afbf-ead22387-53272811 committed.
      [1603883539558] INFO  (58433 on laptop): Preparing query...
      [1603883539602] INFO  (58433 on laptop): Selecting prepared query...
      [1603883539685] INFO  (58433 on laptop): Select prepared query
      [1603883539685] DEBUG (58433 on laptop): Released session ydb://session/3?node_id=12065&id=ZjY5NWRlM2EtYWMyYjA5YWEtNzQ0MTVlYTMtM2Q4ZDgzOWQ= on endpoint ydb.serverless.yandexcloud.net:2135.
      [1603883539685] DEBUG (58433 on laptop): Destroying driver...
      [1603883539686] DEBUG (58433 on laptop): Destroying pool...
      [1603883539754] DEBUG (58433 on laptop): Pool has been destroyed.
      [1603883539754] DEBUG (58433 on laptop): Driver has been destroyed.
      ```

- Java

  1. Build a test app.

      ```bash
      git clone https://github.com/yandex-cloud/ydb-java-sdk.git
      cd ydb-java-sdk/examples/maven-project
      mvn package
      ```

  1. To run a test app from outside the cloud, get your OAUTH token by [following the link](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb) and set the environment variable.

      ```bash
      export OAUTH_TOKEN=<your oauth token>
      ```

      To run it in a VM, create a VM using the service account you created earlier. In this case, no OAUTH_TOKEN is required, since authorization is performed on behalf of the service account.

  1. Run the test app:

      ```bash
      cd target/release
      java -jar example.jar <database endpoint> <YDB database>
      ```

      To run it in a VM, copy the entire target/release folder to the VM.

{% endlist %}

