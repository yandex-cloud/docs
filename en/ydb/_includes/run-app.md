To launch the app and connect to the database:

{% list tabs %}

- Python

  1. Clone the [YDB Python SDK](https://github.com/yandex-cloud/ydb-python-sdk) repository and install the `ydb`, `iso8601`, and `yandexcloud` libraries:

      ```bash
      git clone https://github.com/yandex-cloud/ydb-python-sdk.git
      sudo pip3 install iso8601 ydb yandexcloud
      ```

  1. Create an authorized key for your service account, save the file [using the CLI](../../iam/operations/iam-token/create-for-sa#via-cli), and set the `SA_KEY_FILE` environment variable:

      ```bash
      yc iam key create --service-account-name sa-name -o  ~/.ydb/sa_name.json
      export SA_KEY_FILE=~/.ydb/sa_name.json
      ```

     {% note info %}

     To connect to the YDB Dedicated database, set the environment variable with the certificate:

      ```bash
      export YDB_SSL_ROOT_CERTIFICATES_FILE=~/.ydb/CA.pem
      ```

     {% endnote %}

  1. Launch the `basic_example_v1` test app from the `ydb-python-sdk` repository, specifying the values obtained earlier as startup parameters:

      ```bash
      cd ./ydb-python-sdk/examples/basic_example_v1
      python3 __main__.py -e protocol://endpoint -d database
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

      ```bash
      yc iam key create --service-account-name sa_name -o  ~/.ydb/sa_name.json
      ```

  1. Set the environment variables required for app authentication:

      ```bash
      export SA_SERVICE_FILE=~/.ydb/sa_name.json
      ```
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
      inspecting Database
      
      > describe_table_options:
      
      > describe table: /global/path/todatabase/series
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
      npm install ydb-sdk
      npm run build
      ```

  1. Get an IAM token for the appropriate service account [using the CLI](../../iam/operations/iam-token/create-for-sa#via-cli):

      ```bash
      yc iam key create --service-account-name sa_name -o  ~/.ydb/sa_name.json
      ```

  1. Set the environment variables required for app authentication:

      ```bash
      export YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS=~/.ydb/sa_name.json
      export IAM_ENDPOINT=iam.api.cloud.yandex.net:443
      export ENTRYPOINT=grpcs://YOURENDPOINT
      export DB=YOUR_DATABASE
      export YDB_SDK_LOGLEVEL=debug
      ```
      * `YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS`: Local path to the IAM token file.
      * `IAM_ENDPOINT`: IAM endpoint. Set it to `iam.api.cloud.yandex.net:443`.
      * `ENTRYPOINT`: Database endpoint.
      * `DB`: Yandex database (YDB).
      * `YDB_SDK_LOGLEVEL`: Logging level. Set it to `debug`.

  1. Run the `basic_example_v1` test app:

      ```bash
      npm run basic-v1
      ```

      App execution results:

      ```bash
      Dropping old tables...
      Describing table: series
      Column name 'series_id' has type {"optionalType":{"item":{"typeId":"UINT64"}}}
      Column name 'title' has type {"optionalType":{"item":{"typeId":"UTF8"}}}
      Column name 'series_info' has type {"optionalType":{"item":{"typeId":"UTF8"}}}
      Column name 'release_date' has type {"optionalType":{"item":{"typeId":"UINT64"}}}
      
      Inserting data to tables, preparing query...
      Query has been prepared, executing...
      
      Making a simple select...
      selectSimple result: [{"seriesId":1,"title":"IT Crowd","releaseDate":13182}]
      
      Making an upsert...
      Upsert completed.
      Preparing query...
      Selecting prepared query...
      Preparing query...
      
      Selecting prepared query...
      Select prepared query [{"title":"To Build a Better Beta","airDate":"2016-06-05","releaseDate":null}]
      Select prepared query [{"title":"Bachman's Earnings Over-Ride","airDate":"2016-06-12","releaseDate":null}]
      
      Running prepared query with explicit transaction control...
      Executing query with txId d2f98e91-e69cc14a-bebded66-10c7d3a5.
      TxId d2f98e91-e69cc14a-bebded66-10c7d3a5 committed.
      
      Preparing query...
      Selecting prepared query...
      Select prepared query [{"title":"TBD","airDate":"2020-04-05","releaseDate":null}]
      Released session ydb://session/...= on endpoint vm-xxxxx.ydb.mdb.yandexcloud.net:2135.
      ```

{% endlist %}

