# Working with the SDK

When writing your app, you can use the SDKs available for [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk), and [Java](https://github.com/yandex-cloud/ydb-java-sdk).

This page explains in detail the test app code available as part of the SDK:

* For [Python](https://github.com/yandex-cloud/ydb-python-sdk/tree/master/examples/basic_example_v1)
* For [Go](https://github.com/yandex-cloud/ydb-go-sdk/tree/master/example/basic_example_v1)
* For [Java](https://github.com/yandex-cloud/ydb-java-sdk/tree/master/examples/src/main/java/com/yandex/ydb/examples/basic_example)
* For [NodeJS](https://github.com/yandex-cloud/ydb-nodejs-sdk/tree/master/examples/basic-example-v1)

{% if audience == "internal" %}

* For [C++](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/examples/basic_example)
{% endif %}

To launch the app, connect to the database. For more information, see [{#T}](../quickstart/launch-test-app.md).

{% if audience == "internal" %}

{% note info %}

To authenticate with YDB, the test app uses a token from the __YDB_TOKEN__ environment variable.

{% endnote %}

{% endif %}

After launching and running the app, the following is displayed in the console:

{% list tabs %}

- Python

  ```bash
  $ ./basic_example -endpoint endpoint -database database
  
  > describe table: series
  ('column, name:', 'series_id', ',', 'Uint64')
  ('column, name:', 'title', ',', 'Utf8')
  ('column, name:', 'series_info', ',', 'Utf8')
  ('column, name:', 'release_date', ',', 'Uint64')
  
  > select_simple_transaction:
  ('series, id: ', 1L, ', title: ', u'IT Crowd', ', release date: ', '2006-02-03')
  
  > bulk upsert: episodes
  
  > select_prepared_transaction:
  ('episode title:', u'To Build a Better Beta', ', air date:', '2016-06-05')
  
  > select_prepared_transaction:
  ('episode title:', u"Bachman's Earnings Over-Ride", ', air date:', '2016-06-12')
  
  > explicit TCL call
  
  > select_prepared_transaction:
  ('episode title:', u'TBD', ', air date:', '2020-09-23')
  ```

- Go

  ```bash
  $ ./basic_example_v1 -endpoint endpoint -database database
  
  inspecting Database
  
  > describe_table_options:
  
  > describe table: /path/to/database/series
  column, name: Optional<Uint64>, series_id
  column, name: Optional<Utf8>, title
  column, name: Optional<Utf8>, series_info
  column, name: Optional<Uint64>, release_date
  column, name: Optional<Utf8>, comment
  
  > select_simple_transaction: 1 IT Crowd 2006-02-03
  ```

- Java

  ```bash
  ...
  
  --[ SelectSimple ]--
  +-----------+------------------+--------------------+
  | series_id |            title |       release_date |
  +-----------+------------------+--------------------+
  |   Some[1] | Some["IT Crowd"] | Some["2006-02-03"] |
  +-----------+------------------+--------------------+
  
  --[ SelectWithParams ]--
  +------------------+------------------------+
  |     season_title |           series_title |
  +------------------+------------------------+
  | Some["Season 3"] | Some["Silicon Valley"] |
  +------------------+------------------------+
  Finished preparing query: PreparedSelectTransaction
  
  --[ PreparedSelect ]--
  +-------------+------------+-----------+-----------+--------------------------------+
  |    air_date | episode_id | season_id | series_id |                          title |
  +-------------+------------+-----------+-----------+--------------------------------+
  | Some[16957] |    Some[7] |   Some[3] |   Some[2] | Some["To Build a Better Beta"] |
  +-------------+------------+-----------+-----------+--------------------------------+
  
  --[ PreparedSelect ]--
  +-------------+------------+-----------+-----------+--------------------------------------+
  |    air_date | episode_id | season_id | series_id |                                title |
  +-------------+------------+-----------+-----------+--------------------------------------+
  | Some[16964] |    Some[8] |   Some[3] |   Some[2] | Some["Bachman's Earnings Over-Ride"] |
  +-------------+------------+-----------+-----------+--------------------------------------+
  
  --[ MultiStep ]--
  +-----------+------------+---------------------------------+-------------+
  | season_id | episode_id |                           title |    air_date |
  +-----------+------------+---------------------------------+-------------+
  |   Some[5] |    Some[1] |   Some["Grow Fast or Die Slow"] | Some[17615] |
  |   Some[5] |    Some[2] |           Some["Reorientation"] | Some[17622] |
  |   Some[5] |    Some[3] | Some["Chief Operating Officer"] | Some[17629] |
  +-----------+------------+---------------------------------+-------------+
  
  --[ PreparedSelect ]--
  +-------------+------------+-----------+-----------+-------------+
  |    air_date | episode_id | season_id | series_id |       title |
  +-------------+------------+-----------+-----------+-------------+
  | Some[18528] |    Some[1] |   Some[6] |   Some[2] | Some["TBD"] |
  +-------------+------------+-----------+-----------+-------------+
  ```

{% endlist %}

## Creating a new driver, client, and session instance {#driver-client-session-init}

To interact with {{ ydb-short-name }}, you have to create an instance of the driver, client, and session:

* The {{ ydb-short-name }} driver lets the app and {{ ydb-short-name }} interact at the transport layer.
* The {{ ydb-short-name }} client runs on top of the {{ ydb-short-name }} driver and enables the handling of entities and transactions.
* The {{ ydb-short-name }} session contains information about executed transactions and prepared queries, and is part of the {{ ydb-short-name }} client context.

### Initializing the driver {#driver-init}

The driver lets the app and {{ ydb-short-name }} interact at the transport layer. The driver must exist throughout the {{ ydb-short-name }} access lifecycle. Before creating a {{ ydb-short-name }} client and setting up a session, initialize the {{ ydb-short-name }} driver. App code snippet for driver initialization with database connection parameters:

{% list tabs %}

- Python

  ```python
  def run(endpoint, database, path):
      driver_config = ydb.DriverConfig(
          endpoint, database, credentials=ydb.construct_credentials_from_environ(),
          root_certificates=ydb.load_ydb_root_certificate(),
      )
      with ydb.Driver(driver_config) as driver:
          try:
              driver.wait(timeout=5)
          except TimeoutError:
              print("Connect failed to YDB")
              print("Last reported errors by discovery:")
              print(driver.discovery_debug_details())
              exit(1)
  ```

- Go

  ```go
  func (cmd *Command) Run(ctx context.Context, params cli.Parameters) error {
  	dialer := &ydb.Dialer{
  		DriverConfig: cmd.config(params),
  		TLSConfig:    cmd.tls(),
  		Timeout:      time.Second,
  	}
  	driver, err := dialer.Dial(ctx, params.Endpoint)
  	if err != nil {
  		return fmt.Errorf("dial error: %v", err)
  	}
  	defer driver.Close()
  ```

{% endlist %}

### Initializing the {{ ydb-short-name }} client and session {#client-session-init}

The client enables the handling of {{ ydb-short-name }} entities. The session contains information about executable transactions and prepared queries. App code snippet for creating a session:

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
  sp := table.SessionPool{
  	IdleThreshold: time.Second,
  	Builder:       &tableClient,
  }
  defer sp.Close(ctx)
  ```

- Java

  ```java
  this.tableClient = TableClient.newClient(GrpcTableRpc.useTransport(transport))
      .build();
  this.session = tableClient.createSession()
      .join()
      .expect("cannot create session");
  ```

{% endlist %}

## Creating tables {#create-table-api}

{% list tabs %}

- Python

  To create tables, use the `session.create_table()` method:

  ```python
  def create_tables(session, path):
      session.create_table(
          os.path.join(path, 'series'),
          ydb.TableDescription()
          .with_column(ydb.Column('series_id', ydb.OptionalType(ydb.PrimitiveType.Uint64)))
          .with_column(ydb.Column('title', ydb.OptionalType(ydb.PrimitiveType.Utf8)))
          .with_column(ydb.Column('series_info', ydb.OptionalType(ydb.PrimitiveType.Utf8)))
          .with_column(ydb.Column('release_date', ydb.OptionalType(ydb.PrimitiveType.Uint64)))
          .with_primary_key('series_id')
      )
  ```

  You can use the `session.describe_table()` method to output information about the table structure and make sure that it was properly created:

  ```python
  def describe_table(session, path, name):
      result = session.describe_table(os.path.join(path, name))
      print("\n> describe table: series")
      for column in result.columns:
          print("column, name:", column.name, ",", str(column.type.item).strip())
  ```

- Go

  To create tables, use the `Session.CreateTable()` method:

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
  ```

  You can use the `Session.DescribeTable()` method to output information about the table structure and make sure that it was properly created:

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
  ```

- Java

  To create tables, use the `Session.CreateTable()` method:

  ```java
  private void createTables() {
      TableDescription seriesTable = TableDescription.newBuilder()
          .addNullableColumn("series_id", PrimitiveType.uint64())
          .addNullableColumn("title", PrimitiveType.utf8())
          .addNullableColumn("series_info", PrimitiveType.utf8())
          .addNullableColumn("release_date", PrimitiveType.uint64())
          .setPrimaryKey("series_id")
          .build();
  
      execute(session -> session.createTable(database + "/series", seriesTable).join());
  
      TableDescription seasonsTable = TableDescription.newBuilder()
          .addNullableColumn("series_id", PrimitiveType.uint64())
          .addNullableColumn("season_id", PrimitiveType.uint64())
          .addNullableColumn("title", PrimitiveType.utf8())
          .addNullableColumn("first_aired", PrimitiveType.uint64())
          .addNullableColumn("last_aired", PrimitiveType.uint64())
          .setPrimaryKeys("series_id", "season_id")
          .build();
  
      execute(session -> session.createTable(database + "/seasons", seasonsTable).join());
  
      TableDescription episodesTable = TableDescription.newBuilder()
          .addNullableColumn("series_id", PrimitiveType.uint64())
          .addNullableColumn("season_id", PrimitiveType.uint64())
          .addNullableColumn("episode_id", PrimitiveType.uint64())
          .addNullableColumn("title", PrimitiveType.utf8())
          .addNullableColumn("air_date", PrimitiveType.uint64())
          .setPrimaryKeys("series_id", "season_id", "episode_id")
          .build();
  
      execute(session -> session.createTable(database + "/episodes", episodesTable).join());
  }
  ```

  You can use the `Session.DescribeTable()` method to output information about the table structure and make sure that it was properly created:

  ```java
  private void describeTables() {
      System.out.println("\n--[ DescribeTables ]--");
  
      for (String tableName : new String[]{ "series", "seasons", "episodes" }) {
          String tablePath = database + '/' + tableName;
          TableDescription tableDesc = executeWithResult(session -> session.describeTable(tablePath).join());
  
          System.out.println(tablePath + ':');
          List<String> primaryKeys = tableDesc.getPrimaryKeys();
          for (TableColumn column : tableDesc.getColumns()) {
              boolean isPrimary = primaryKeys.contains(column.getName());
              System.out.println("    " + column.getName() + ": " + column.getType() + (isPrimary ? " (PK)" : ""));
          }
          System.out.println();
      }
  }
  ```

{% endlist %}

`PRAGMA TablePathPrefix` adds a specified prefix to the database table paths. It uses standard file system path concatenation: i.e., it supports parent folder referencing and requires no trailing slash. For example:

```
PRAGMA TablePathPrefix = "/cluster/database";
SELECT * FROM episodes;
```

For more information about PRAGMA YQL support, see the [YQL documentation](../yql/reference/overview.md).

## Processing queries and transactions {#query-processing}

{% list tabs %}

- Python

  To execute YQL queries, use the `session.transaction().execute()` method.
  The SDK lets you explicitly control the execution of transactions and configure the transaction execution mode using the ```TxControl``` class.

  In the code snippet below, the transaction is executed using the ```transaction().execute()``` method. The transaction execution mode set is ```ydb.SerializableReadWrite()```. When all the queries in the transaction are completed, the transaction is automatically committed by explicitly setting the ```commit_tx=True``` flag. The query body is described using YQL syntax and is passed to the ```execute``` method as a parameter.

  ```python
  def select_simple(session, path):
      result_sets = session.transaction(ydb.SerializableReadWrite()).execute(
          """
          PRAGMA TablePathPrefix("{}");
          $format = DateTime::Format("%Y-%m-%d");
          SELECT
              series_id,
              title,
              $format(DateTime::FromSeconds(CAST(DateTime::ToSeconds(DateTime::IntervalFromDays(CAST(release_date AS Int16))) AS Uint32))) AS release_date
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

  To execute YQL queries, use the `Session.Execute()` method.
  The SDK lets you explicitly control the execution of transactions and configure the transaction execution mode using the ```TxControl``` class.

  ```go
  func selectSimple(ctx context.Context, sp *table.SessionPool, prefix string) (err error) {
  	query := render(
  		template.Must(template.New("").Parse(`
  			PRAGMA TablePathPrefix("not_var{{ .TablePathPrefix }}");
  			DECLARE $seriesID AS Uint64;
  			$format = DateTime::Format("%Y-%m-%d");
  			SELECT
  				series_id,
  				title,
  				$format(DateTime::FromSeconds(CAST(DateTime::ToSeconds(DateTime::IntervalFromDays(CAST(release_date AS Int16))) AS Uint32))) AS release_date
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
  			_, res, err = s.Execute(ctx, readTx, query,
  				table.NewQueryParameters(
  					table.ValueParam("$seriesID", ydb.Uint64Value(1)),
  				),
  				table.WithQueryCachePolicy(
  					table.WithQueryCachePolicyKeepInCache(),
  				),
  				table.WithCollectStatsModeBasic(),
  			)
  			return
  		}),
  	)
  	if err != nil {
  		return err
  	}
  	for res.NextSet() {
  		for res.NextRow() {
  			res.SeekItem("series_id")
  			id := res.OUint64()
  
  			res.NextItem()
  			title := res.OUTF8()
  
  			res.NextItem()
  			date := res.OString()
  
  			log.Printf(
  				"\n> select_simple_transaction: %d %s %s",
  				id, title, date,
  			)
  		}
  	}
  	if err := res.Err(); err != nil {
  		return err
  	}
  	return nil
  }
  ```
- Java

  To execute YQL queries, use the `Session.executeDataQuery()` method.
  The SDK lets you explicitly control the execution of transactions and configure the transaction execution mode using the `TxControl` class.

  ```java
  private void selectSimple() {
      String query = String.format(
          "PRAGMA TablePathPrefix(\"%s\");\n" +
          "$format = DateTime::Format(\"%%Y-%%m-%%d\");\n" +
          "\n" +
          "SELECT\n" +
          "    series_id,\n" +
          "    title,\n" +
          "    $format(DateTime::FromSeconds(CAST(DateTime::ToSeconds(DateTime::IntervalFromDays(CAST(release_date AS Int16))) AS Uint32))) AS release_date\n" +
          "FROM series\n" +
          "WHERE series_id = 1;",
          database);
  
      TxControl txControl = TxControl.serializableRw().setCommitTx(true);
  
      DataQueryResult result = executeWithResult(session -> session.executeDataQuery(query, txControl).join());
  
      System.out.println("\n--[ SelectSimple ]--");
      new TablePrinter(result.getResultSet(0)).print();
  }
  ```

{% endlist %}

## Processing execution results {#results-processing}

{% list tabs %}

- Python

  Query results:

  ```python
  print("\n> select_simple_transaction:")
  for row in result_sets[0].rows:
      print("series, id: ", row.series_id, ", title: ", row.title, ", release date: ", row.release_date)
  ```

- Go

  Query results:

  ```go
  for res.NextSet() {
  	for res.NextRow() {
  		res.SeekItem("series_id")
  		id := res.OUint64()
  
  		res.NextItem()
  		title := res.OUTF8()
  
  		res.NextItem()
  		date := res.OString()
  
  		log.Printf(
  			"\n> select_simple_transaction: %d %s %s",
  			id, title, date,
  		)
  	}
  }
  ```

- Java

  Query results:

  ```java
  System.out.println("\n--[ SelectSimple ]--");
  new TablePrinter(result.getResultSet(0)).print();
  ```

{% endlist %}

## Queries to insert or update data {#write-queries}

{% list tabs %}

- Python

  Code snippet for inserting and updating data:

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

- Java

  Code snippet for inserting and updating data:

  ```java
  private void upsertSimple() {
      String query = String.format(
          "PRAGMA TablePathPrefix(\"%s\");\n" +
          "\n" +
          "UPSERT INTO episodes (series_id, season_id, episode_id, title) VALUES\n" +
          "(2, 6, 1, \"TBD\");",
          database);
  
      TxControl txControl = TxControl.serializableRw().setCommitTx(true);
  
      execute(session -> session.executeDataQuery(query, txControl)
          .join()
          .toStatus());
  }
  ```

{% endlist %}

## Parameterized prepared queries {#param-prepared-queries}

Parameterized prepared queries are saved as templates where specially formatted names are replaced by relevant parameter values each time you execute the query. Use parameterized queries to improve performance by reducing how often queries that only differ in parameter values are compiled and recompiled.

{% list tabs %}

- Python

  Code snippet for parameterized prepared queries. The prepared query is stored in the session context.

  ```python
  def select_prepared(session, path, series_id, season_id, episode_id):
      query = """
      PRAGMA TablePathPrefix("{}");
      DECLARE $seriesId AS Uint64;
      DECLARE $seasonId AS Uint64;
      DECLARE $episodeId AS Uint64;
      $format = DateTime::Format("%Y-%m-%d");
      SELECT
          title,
          $format(DateTime::FromSeconds(CAST(DateTime::ToSeconds(DateTime::IntervalFromDays(CAST(air_date AS Int16))) AS Uint32))) AS air_date
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

- Java

  Code snippet for parameterized prepared queries. The prepared query is stored in the session context.

  ```java
  private void preparedSelect(long seriesId, long seasonId, long episodeId) {
      final String queryId = "PreparedSelectTransaction";
  
      DataQuery query = preparedQueries.get(queryId);
      if (query == null) {
          String queryText = String.format(
              "PRAGMA TablePathPrefix(\"%s\");\n" +
              "\n" +
              "DECLARE $seriesId AS Uint64;\n" +
              "DECLARE $seasonId AS Uint64;\n" +
              "DECLARE $episodeId AS Uint64;\n" +
              "\n" +
              "SELECT *\n" +
              "FROM episodes\n" +
              "WHERE series_id = $seriesId AND season_id = $seasonId AND episode_id = $episodeId;",
              database);
  
          query = executeWithResult(session -> session.prepareDataQuery(queryText).join());
          System.out.println("Finished preparing query: " + queryId);
  
          preparedQueries.put(queryId, query);
      }
  
      Params params = query.newParams()
          .put("$seriesId", uint64(seriesId))
          .put("$seasonId", uint64(seasonId))
          .put("$episodeId", uint64(episodeId));
  
      TxControl txControl = TxControl.serializableRw().setCommitTx(true);
      DataQueryResult result = query.execute(txControl, params)
          .join()
          .expect("prepared query failed");
  
      System.out.println("\n--[ PreparedSelect ]--");
      new TablePrinter(result.getResultSet(0)).print();
  }
  ```

{% endlist %}

## Explicit TCL Begin and Commit calls {#tcl-usage}

{% list tabs %}

- Python

  In most cases, instead of explicitly using [TCL](../concepts/transactions.md) for Begin and Commit calls, it's better to use transaction control parameters in the execute calls. This helps you avoid unnecessary requests to {{ ydb-short-name }} and run your queries more efficiently. Code snippet for `transaction().begin()` and `tx.Commit()` calls:

  ```python
  def explicit_tcl(session, path, series_id, season_id, episode_id):
      query = """
      PRAGMA TablePathPrefix("{}");
  
      DECLARE $seriesId AS Uint64;
      DECLARE $seasonId AS Uint64;
      DECLARE $episodeId AS Uint64;
  
      UPDATE episodes
      SET air_date = CAST(CurrentUtcDate() AS Uint64)
      WHERE series_id = $seriesId AND season_id = $seasonId AND episode_id = $episodeId;
      """.format(path)
      prepared_query = session.prepare(query)
  
      tx = session.transaction(ydb.SerializableReadWrite()).begin()
  
      tx.execute(
          prepared_query, {
              '$seriesId': series_id,
              '$seasonId': season_id,
              '$episodeId': episode_id
          }
      )
  
      print("\n> explicit TCL call")
  
      tx.commit()
  ```

- Java

  In most cases, instead of explicitly using [TCL](../concepts/transactions.md) for Begin and Commit calls, it's better to use transaction control parameters in `execute` calls. This helps you avoid unnecessary requests to {{ ydb-short-name }} and make queries more efficiently. Code snippet for `beginTransaction()` and `transaction.Commit()` calls:

  ```java
  private Status explicitTcl(Session session) {
      Result<Transaction> transactionResult = session.beginTransaction(TransactionMode.SERIALIZABLE_READ_WRITE)
          .join();
      if (!transactionResult.isSuccess()) {
          return transactionResult.toStatus();
      }
  
      Transaction transaction = transactionResult.expect("cannot begin transaction");
      String query = String.format(
          "PRAGMA TablePathPrefix(\"%s\");\n" +
          "DECLARE $airDate AS Uint64;\n" +
          "UPDATE episodes SET air_date = $airDate WHERE title = \"TBD\";",
          database);
  
      Params params = Params.of("$airDate", uint64(Duration.between(Instant.EPOCH, Instant.now()).toDays()));
  
      TxControl txControl = TxControl.id(transaction).setCommitTx(false);
      Result<DataQueryResult> updateResult = session.executeDataQuery(query, txControl, params)
          .join();
      if (!updateResult.isSuccess()) {
          return updateResult.toStatus();
      }
  
      return transaction.commit().join();
  }
  ```

{% endlist %}

## Handling errors {#error-handling}

For more detail on error handling, see [Error handling in the API](../api/error_handling.md).

