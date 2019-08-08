# Working with the SDK

When writing your app, you can use the SDKs available for [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk), and [Java](https://github.com/yandex-cloud/ydb-java-sdk).

This page explains in detail the `basic_example` test app code available as part of the SDK:

* For [Python](https://github.com/yandex-cloud/ydb-python-sdk/tree/master/kikimr/public/sdk/python/examples/basic_example)
* For [Go](https://github.com/yandex-cloud/ydb-go-sdk/tree/master/example/basic_example)
{% if audience == "internal" %}
* For [C++](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/examples/basic_example)
{% endif %}

To launch the app, connect to the database. For more information, see [{#T}](../quickstart.md#sdk).

{% if audience == "internal" %}

{% note info %}

To authenticate with YDB, the test app uses a token from the __YDB_TOKEN__ environment variable.

{% endnote %}

{% endif %}

After launching and running `basic_example`, the following is displayed in the console:

{% list tabs %}

- Python

  ```bash
  ./basic_example -endpoint endpoint -database database
  
  > describe table: series
  ('column, name:', 'series_id', ',', 'type_id: UINT64')
  ('column, name:', 'title', ',', 'type_id: UTF8')
  ('column, name:', 'series_info', ',', 'type_id: UTF8')
  ('column, name:', 'release_date', ',', 'type_id: UINT64')
  
  > select_simple_transaction:
  ('series, id: ', 1L, ', title: ', u'IT Crowd', ', release date: ', '2006-02-03')
  
  > select_prepared_transaction:
  ('episode title:', u'To Build a Better Beta', ', air date:', '2016-06-05')
  
  > select_prepared_transaction:
  ('episode title:', u"Bachman's Earnings Over-Ride", ', air date:', '2016-06-12')
  
  > explicit TCL call
  
  > select_prepared_transaction:
  ('episode title:', u'TBD', ', air date:', '2018-09-11')
  ```

- Go

  ```bash
  ./basic_example_v1 -endpoint endpoint -database database
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

{% endlist %}

## Create a new driver, client, and session instance {#driver-client-session-init}

To interact with {{ ydb-short-name }}, you have to create driver, client, and session instance:

* The {{ ydb-short-name }} driver lets the app and {{ ydb-short-name }} interact at the transport layer.
* The {{ ydb-short-name }} client runs on top of the {{ ydb-short-name }} driver and enables the handling of entities and transactions.
* The {{ ydb-short-name }} session contains information about executed transactions and prepared queries, and is part of the {{ ydb-short-name }} client context.

### Initialize the driver {#driver-init}

The driver lets the app and {{ ydb-short-name }} interact at the transport layer. The driver must exist throughout the {{ ydb-short-name }} access lifecycle. Before creating a {{ ydb-short-name }} client and setting up a session, initialize the {{ ydb-short-name }} driver. `basic_example` app code snippet for driver initialization with database connection parameters:

{% list tabs %}

- Python

  ```python
  connection_params = ydb.DriverConfig(endpoint, database=database, auth_token=auth_token)
  try:
      driver = ydb.Driver(connection_params)
      driver.wait(timeout=5)
  except TimeoutError:
      raise RuntimeError("Connect failed to YDB")
  ```

- Go

  ```go
  func run(ctx context.Context, endpoint, prefix string, config *ydb.DriverConfig) error {
  	driver, err := (&ydb.Dialer{
  		DriverConfig: config,
  		NetDial: func(ctx context.Context, addr string) (net.Conn, error) {
  			var d net.Dialer
  			conn, err := d.DialContext(ctx, "tcp", addr)
  			if err == nil {
  				return conn, nil
  			}
  			log.Printf("want to dial %q", addr)
  			h, _, _ := net.SplitHostPort(addr)
  			log.Printf("stripping %q host", h)
  			return d.DialContext(ctx, "tcp", "localhost:22135")
  		},
  	}).Dial(ctx, endpoint)
  	if err != nil {
  		return fmt.Errorf("dial error: %v", err)
  	}
  }
  ```

{% endlist %}

### Initialize the client and session {{ ydb-short-name }} {#client-session-init}

The client enables the handling of {{ ydb-short-name }} entities. The session contains information about executable transactions and prepared queries. `basic_example` app code snippet for creating a session:

{% list tabs %}

- Python

  ```python
  session = driver.table_client.session().create()
  ```

- Go

  ```go
  tableClient := table.Client{
      Driver: driver,
  }
  ```

{% endlist %}

## Create tables using the CreateTable API {#create-table-api}

{% list tabs %}

- Python

  Use the `create_table` method to create tables:
  
    ```python
    # Creates the series table.
    session.create_table(
        os.path.join(path, 'series'),
        ydb.TableDescription()
        .with_column(ydb.Column('series_id', ydb.OptionalType(ydb.DataType.Uint64)))
        .with_column(ydb.Column('title', ydb.OptionalType(ydb.DataType.Utf8)))
        .with_column(ydb.Column('series_info', ydb.OptionalType(ydb.DataType.Utf8)))
        .with_column(ydb.Column('release_date', ydb.OptionalType(ydb.DataType.Uint64)))
        .with_primary_key('series_id')
    )
    ```

  You can use the `describe_table` method to output information about the table structure and make sure that it was properly created. `basic_example` app code snippet with the output of table structure information retrieved using the `describe_table` method:

  ```python
  result = session.describe_table(os.path.join(path, name))
  print("\n> describe table: series")
  for column in result.columns:
      print("column, name:", column.name, ",", str(column.type.optional_type.item).strip())
  ```

- Go

  To create tables, use the `createTables` method:

  ```go
  func createTables(ctx context.Context, sp *table.SessionPool, prefix string) (err error) {
  	err = table.Retry(ctx, sp,
  		table.OperationFunc(func(ctx context.Context, s *table.Session) error {
  			return s.CreateTable(ctx, path.Join(prefix, "series"),
  				table.WithColumn("series_id", ydb.Optional(ydb.TypeUint64)),
  				table.WithColumn("title", ydb.Optional(ydb.TypeUTF8)),
  				table.WithColumn("series_info", ydb.Optional(ydb.TypeUTF8)),
  				table.WithColumn("release_date", ydb.Optional(ydb.TypeUint64)),
  				table.WithColumn("comment", ydb.Optional(ydb.TypeUTF8)),
  				table.WithPrimaryKeyColumn("series_id"),
  			)
  		}),
  	)
  ...
  ```

  Use the `describeTable` method to output information about the table structure and make sure that it was properly created.

  ```go
  func describeTable(ctx context.Context, sp *table.SessionPool, path string) (err error) {
  	err = table.Retry(ctx, sp,
  		table.OperationFunc(func(ctx context.Context, s *table.Session) error {
  			desc, err := s.DescribeTable(ctx, path)
  			if err != nil {
  				return err
  			}
  			log.Printf("\n> describe table: %s", path)
  			for _, c := range desc.Columns {
  				log.Printf("column, name: %s, %s", c.Type, c.Name)
  			}
  			return nil
  		}),
  	)
  ...
  ```

{% endlist %}

`basic_example` app code snippet where text is output to the console at startup:

```bash
> describe table: series
('column, name:', 'series_id', ',', 'type_id: UINT64')
('column, name:', 'title', ',', 'type_id: UTF8')
('column, name:', 'series_info', ',', 'type_id: UTF8')
('column, name:', 'release_date', ',', 'type_id: UINT64')
```

`PRAGMA TablePathPrefix` adds a specified prefix to the database table paths. It uses standard file system path concatenation: it supports parent folder referencing and requires no trailing slash. For example:

```
PRAGMA TablePathPrefix = "/ru/tutorial/home/testdb";
SELECT * FROM Episodes;
```

For more information about PRAGMA YQL, see the [YQL documentation](../yql/reference/quickstart.md).

## Execute queries and transactions {#query-processing}

{% list tabs %}

- Python

  To execute YQL queries, use the `session.transaction().execute()` method.
The SDK lets you explicitly control the execution of transactions and configure the transaction execution mode using the ```TxControl``` class.

  In the `basic_example` code snippet below, the transaction is executed using the ```transaction().execute()``` method. The transaction execution mode set is ```ydb.SerializableReadWrite()```. When all the queries in the transaction are completed, the transaction is automatically committed by explicitly setting the flag ```commit_tx=True```. The query body is described using YQL syntax and is passed to the ```execute``` method as a parameter.
  
  ```python
  def select_simple(session, path):
      # A new transaction in serializable read write mode.
      # If a query is completed successfully, you will get the result sets;
      # otherwise, an exception will be raised.
      result_sets = session.transaction(ydb.SerializableReadWrite()).execute(
          """
          PRAGMA TablePathPrefix("{}");
          SELECT series_id, title, DateTime::ToDate(DateTime::FromDays(release_date)) AS release_date
          FROM series
          WHERE series_id = 1;
          """.format(path),
          commit_tx=True,
      )
      print("\n> select_simple_transaction:")
      for row in result_sets[0].rows:
          print("series, id: ", row.series_id, ", title: ", row.title, ", release date: ", row.release_date)
  
      return result_sets[0]
  ```

- Go

  To execute YQL queries, use the `Session.selectSimple()` method.
The SDK lets you explicitly control the execution of transactions and configure the transaction execution mode using the ```TxControl``` class.

  ```go
  func selectSimple(ctx context.Context, sp *table.SessionPool, prefix string) (err error) {
  	query := render(
  		template.Must(template.New("").Parse(`
  			PRAGMA TablePathPrefix("{{ .TablePathPrefix }}");
  			DECLARE $seriesID AS Uint64;
  
  			SELECT
  				series_id,
  				title,
  				DateTime::ToDate(DateTime::FromDays(release_date)) AS release_date
  			FROM
  				series
  			WHERE
  				series_id = $seriesID;
  		`)),
  		templateConfig{
  			TablePathPrefix: prefix,
  		},
  	)
  	readTx := table.TxControl(
  		table.BeginTx(
  			table.WithOnlineReadOnly(),
  		),
  		table.CommitTx(),
  	)
  	var res *table.Result
  	err = table.Retry(ctx, sp,
  		table.OperationFunc(func(ctx context.Context, s *table.Session) (err error) {
  			_, res, err = s.ExecuteDataQuery(ctx, readTx,
  				table.TextDataQuery(query),
  				table.NewQueryParameters(
  					table.ValueParam("$seriesID", ydb.Uint64Value(1)),
  				),
  				table.WithExecuteDataQueryOperationParams(
  					table.WithOperationModeSync(),
  				),
  				table.WithQueryCachePolicy(
  					table.WithQueryCachePolicyKeepInCache(),
  				),
  				table.WithCollectStatsModeBasic(),
  			)
  			return
          ...
  ```

{% endlist %}

## Process execution results {#results-processing}

{% list tabs %}

- Python

  When the query is executed, a ```result_set``` is returned:
  
  ```python
  for row in result_sets[0].rows:
      print("series, id: ", row.series_id, ", title: ", row.title, ", release date: ", row.release_date)
  ```

  Check:

  ```bash
  > SelectSimple:
  series, Id: 1, title: IT Crowd, Release date: 2006-02-03
  ```

{% endlist %}

## Queries to insert or update data {#write-queries}

{% list tabs %}

- Python

  `basic_example` code snippet for data insert/update:
  
  ```python
  def upsert_simple(session, path):
      session.transaction().execute(
          """
          PRAGMA TablePathPrefix("{}");
          UPSERT INTO episodes (series_id, season_id, episode_id, title) VALUES
              (2, 6, 1, "TBD");
          """.format(path),
          commit_tx=True,
      )
  ```

{% endlist %}

## Parameterized prepared queries {#param-prepared-queries}

Parameterized prepared queries are saved as templates where specially formatted names are replaced by relevant parameter values each time you execute the query. Use parameterized queries to improve performance by reducing how often queries that only differ in parameter values are compiled and recompiled.

{% list tabs %}

- Python

  `basic_example` code snippet for parameterized prepared queries. The prepared query is stored in the session context.
  
  ```python
  def select_prepared(session, path, series_id, season_id, episode_id):
      query = """
      PRAGMA TablePathPrefix("{}");
  
      DECLARE $seriesId AS Uint64;
      DECLARE $seasonId AS Uint64;
      DECLARE $episodeId AS Uint64;
  
      SELECT title, DateTime::ToDate(DateTime::FromDays(air_date)) as air_date
      FROM episodes
      WHERE series_id = $seriesId AND season_id = $seasonId AND episode_id = $episodeId;
      """.format(path)
  
      prepared_query = session.prepare(query)
      result_sets = session.transaction(ydb.SerializableReadWrite()).execute(
          prepared_query, {
              '$seriesId': series_id,
              '$seasonId': season_id,
              '$episodeId': episode_id,
          },
          commit_tx=True
      )
      print("\n> select_prepared_transaction:")
      for row in result_sets[0].rows:
          print("episode title:", row.title, ", air date:", row.air_date)
  
      return result_sets[0]
  ```

  Check:

  ```bash
  > select_prepared_transaction:
  ('episode title:', u'To Build a Better Beta', ', air date:', '2016-06-05')
  ```

{% endlist %}

## Explicit TCL Begin and Commit calls {#tcl-usage}

{% list tabs %}

- Python

  In most cases, instead of explicitly using [TCL](../concepts/transactions.md) for Begin and Commit calls, it's better to use transaction control parameters in execute calls. This helps you avoid unnecessary YDB calls and run your queries more efficiently. `basic_example` code snippet for ```transaction().begin()``` and ```tx.Commit()``` calls:
  
  ```python
  # Shows usage of the explicit Begin/Commit transaction control calls.
  # In most cases it's better to use transaction control settings in the session.transaction
  # calls instead of avoiding additional hops to YDB cluster and allowing more efficient
  # execution of queries.
  def explicit_tcl(session, path, series_id, season_id, episode_id):
      query = """
      PRAGMA TablePathPrefix("{}");
  
      DECLARE $seriesId AS Uint64;
      DECLARE $seasonId AS Uint64;
      DECLARE $episodeId AS Uint64;
  
      UPDATE episodes
      SET air_date = DateTime::ToDays(DateTime::TimestampFromString("2018-09-11T15:15:59.373006Z"))
      WHERE series_id = $seriesId AND season_id = $seasonId AND episode_id = $episodeId;
      """.format(path)
      prepared_query = session.prepare(query)
  
      # Get newly created transaction id
      tx = session.transaction(ydb.SerializableReadWrite()).begin()
  
      # Execute data query.
      # Transaction control settings continues active transaction (tx)
      tx.execute(
          prepared_query, {
              '$seriesId': series_id,
              '$seasonId': season_id,
              '$episodeId': episode_id
          }
      )
  
      print("\n> explicit TCL call")
  
      # Commit active transaction(tx)
      tx.commit()
  ```

{% endlist %}

## Handling errors {#error-handling}

For more information on error handling, see [Error handling in the API](../api/error_handling.md).

