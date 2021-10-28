# Working with the YDB SDK

To familiarize yourself with the {{ ydb-short-name }} SDK, you can use test apps in [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk), and [Java](https://github.com/yandex-cloud/ydb-java-sdk). Set up a DB connection and then install and run the appropriate test app.

{% note info %}

For a detailed test app code analysis, see [{#T}](../../sdk/index.md).

{% endnote %}

## Setting up a DB connection {#connect-to-db}

To connect to a database:

1. Prepare the endpoint and the full path of the [created database](../create-db.md).

    {% cut "How to get the endpoint and the full path of the database" %}

    {% include [ydb-endpoint](../../_includes/ydb-endpoint.md) %}

    {% endcut %}

    {% note info %}

    If your database doesn't have a public endpoint, [create](../../../compute/operations/vm-create/create-linux-vm.md) a virtual machine for accessing the DB in {{ yandex-cloud }}.

    Further setup is done in the created VM.

    {% endnote %}

1. For database authentication, [create a service account](../../iam/operations/sa/create) and [assign](../../../iam/operations/sa/assign-role-for-sa.md) it the `viewer` and `editor` roles.

1. Using the [YC CLI](../../../cli/quickstart.md#install) save the authorized service account key to a file:

    ```bash
    yc iam key create \
      --service-account-name <service_account_name> \
      --output <path/to/file>
    ```

    * `--service-account-name`: Name of the previously created service account.
    * `--output`: Path and name of the file where the authorized key is saved, for example, `~/sa_authorized.json`.

## Running a test app {#run-app}

To install and run a test app:

{% list tabs %}

- Python

  1. Clone the [YDB Python SDK](https://github.com/yandex-cloud/ydb-python-sdk) repository and install the `ydb`, `iso8601`, and `yandexcloud` libraries:

      ```bash
      git clone https://github.com/yandex-cloud/ydb-python-sdk.git
      sudo pip3 install iso8601 ydb yandexcloud
      ```

  1. Set the `SA_KEY_FILE` environment variable to authenticate the application:

      ```bash
      export SA_KEY_FILE=~/sa_authorized.json
      ```

      {% note info %}

      To connect to a {{ ydb-short-name }} dedicated DB, get the certificate and save the path of the certificate file to the environment variable:

      ```bash
      wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/CA.pem
      export YDB_SSL_ROOT_CERTIFICATES_FILE=~/CA.pem
      ```

      {% endnote %}

  1. Run the `basic_example_v1` test app:

      ```bash
      cd ./ydb-python-sdk/examples/basic_example_v1
      python3 __main__.py \
        -e grpcs://lb.etn03umae82ti1blt4er.ydb.mdb.yandexcloud.net:2135 \
        -d /ru-central1/b1gia87mbaomkfvscrus/etn03umae82ti1blt4er
      ```

      * `-e`: Database endpoint.
      * `-d`: Full database path.

      Result:

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
      ```

  1. Set the `YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS` environment variable to authenticate the application:

      ```bash
      export YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS=~/sa_authorized.json
      ```

  1. Compile the `basic_example_v1` test app:

      ```bash
      go build github.com/yandex-cloud/ydb-go-sdk/example/basic_example_v1/
      ```

  1. Run the `basic_example_v1` test app:

      ```bash
      ./basic_example_v1 \
        -endpoint lb.etn03umae82ti1blt4er.ydb.mdb.yandexcloud.net:2135
        -database /ru-central1/b1gia87mbaomkfvscrus/etn03umae82ti1blt4er
      ```

      * `-endpoint`: Database endpoint.
      * `-database`: Full database path.

      Result:

      ```bash
      > describe table: /ru-central1/b1gia87mbaomkfvscrus/etn0061p28k0t9rajt8d/series
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

  1. Set the `SA_JSON_FILE` environment variable to authenticate the application:

      ```bash
      export SA_JSON_FILE=~/sa_authorized.json
      ```

      {% note info %}

      To connect to a {{ ydb-short-name }} dedicated DB, get the certificate and save the path of the certificate file to the environment variable:

      ```bash
      wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/CA.pem
      export YDB_SSL_ROOT_CERTIFICATES_FILE=~/CA.pem
      ```

      {% endnote %}

  1. Run the `basic_example_v1` test app:

      ```bash
      npm run basic-v1 -- \
        --db /ru-central1/b1gia87mbaomkfvscrus/etn03umae82ti1blt4er \
        --endpoint lb.etn03umae82ti1blt4er.ydb.mdb.yandexcloud.net:2135
      ```
      
      * `--endpoint`: Database endpoint.
      * `--db`: Full database path.

      Result:

      ```bash
      > ydb-sdk-examples@0.0.1 basic-v1
      > node build/basic-example-v1/index.js "--db" "/ru-central1/b1gia87mbaomkfvscrus/etn03umae82ti1blt4er" "--endpoint" "lb.etn03umae82ti1blt4er.ydb.mdb.yandexcloud.net:2135"
      
      [1627467690996] INFO  (1106 on test): Running basic-example script against endpoint 'lb.etn03umae82ti1blt4er.ydb.mdb.yandexcloud.net:2135' and database '/ru-central1/b1gia87mbaomkfvscrus/etn03umae82ti1blt4er'.
      [1627467691512] INFO  (1106 on test): Dropping old tables...
      [1627467691612] INFO  (1106 on test): Creating tables...
      [1627467691983] INFO  (1106 on test): Describing table: series
      [1627467691993] INFO  (1106 on test): Column name 'series_id' has type {"optionalType":{"item":{"typeId":"UINT64"}}}
      [1627467691993] INFO  (1106 on test): Column name 'title' has type {"optionalType":{"item":{"typeId":"UTF8"}}}
      [1627467691993] INFO  (1106 on test): Column name 'series_info' has type {"optionalType":{"item":{"typeId":"UTF8"}}}
      [1627467691994] INFO  (1106 on test): Column name 'release_date' has type {"optionalType":{"item":{"typeId":"DATE"}}}
      [1627467691994] INFO  (1106 on test): Inserting data to tables, preparing query...
      [1627467692016] INFO  (1106 on test): Query has been prepared, executing...
      [1627467692057] INFO  (1106 on test): Making a simple select...
      [1627467692073] INFO  (1106 on test): selectSimple result: [
        {
          "seriesId": 1,
          "title": "IT Crowd",
          "releaseDate": "2006-02-03T00:00:00.000Z"
        }
      ]
      [1627467692073] INFO  (1106 on test): Making an upsert...
      [1627467692089] INFO  (1106 on test): Upsert completed.
      [1627467692090] INFO  (1106 on test): Preparing query...
      [1627467692103] INFO  (1106 on test): Selecting prepared query...
      [1627467692109] INFO  (1106 on test): Select prepared query [
        {
          "title": "To Build a Better Beta",
          "airDate": "2016-06-05T00:00:00.000Z"
        }
      ]
      [1627467692115] INFO  (1106 on test): Select prepared query [
        {
          "title": "Bachman's Earnings Over-Ride",
          "airDate": "2016-06-12T00:00:00.000Z"
        }
      ]
      [1627467692115] INFO  (1106 on test): Running prepared query with explicit transaction control...
      [1627467692134] INFO  (1106 on test): Executing query with txId c06611b3-1f45089c-3d25caa0-ba02eabd.
      [1627467692152] INFO  (1106 on test): TxId c06611b3-1f45089c-3d25caa0-ba02eabd committed.
      [1627467692152] INFO  (1106 on test): Preparing query...
      [1627467692156] INFO  (1106 on test): Selecting prepared query...
      [1627467692162] INFO  (1106 on test): Select prepared query [
        {
          "title": "TBD",
          "airDate": "2021-07-28T00:00:00.000Z"
        }
      ]
      ```

- Java

  1. Build a test app:

     1. Clone the [YDB Java SDK](https://github.com/yandex-cloud/ydb-java-sdk) repository:

        ```bash
        git clone https://github.com/yandex-cloud/ydb-java-sdk.git
        ```

     1. Go to the folder with the test app `ydb-java-sdk/examples/maven_project`:

        ```bash
        cd ydb-java-sdk/examples/maven_project
        ```

     1. Build it:

        ```bash
        mvn package
        ```

  1. Set the `SA_KEY_FILE` environment variable to authenticate the application:

     ```bash
     export SA_KEY_FILE=~/sa_authorized.json
     ```

  1. Run the test app:

      ```bash
      cd target/release
      java -jar example.jar <database endpoint> <full database path>
      ```

      Result:

      ```bash
      ...
      Columns reported by describeTable: [species, name, color, price]
      
      Result of select query:
      species: cat
      name: Tom
      color: black
      price: 10.000000
      ```

{% endlist %}
