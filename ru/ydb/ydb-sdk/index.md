# Работа с SDK

При написании своего приложения можно использовать SDK, доступные для языков [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk), [Java](https://github.com/yandex-cloud/ydb-java-sdk) и [.NET](https://github.com/ydb-platform/ydb-dotnet-sdk).

На этой странице подробно разбирается код тестового приложения, доступного в составе SDK:

* Для [Python](https://github.com/yandex-cloud/ydb-python-sdk/tree/master/examples/basic_example_v1).
* Для [Go](https://github.com/yandex-cloud/ydb-go-sdk/tree/master/example/basic_example_v1).
* Для [Java](https://github.com/yandex-cloud/ydb-java-sdk/tree/master/examples/src/main/java/com/yandex/ydb/examples/basic_example).
* Для [NodeJS](https://github.com/yandex-cloud/ydb-nodejs-sdk/tree/master/examples/basic-example-v1).
* Для [.NET](https://github.com/ydb-platform/ydb-dotnet-examples/tree/main/src/BasicExample).

{% if audience == "internal" %}
* Для [C++](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/examples/basic_example)
{% endif %}

Чтобы запустить приложение, необходимо подключиться к базе данных. Подробнее читайте в разделе [{#T}](../quickstart/yql-api/ydb-sdk.md#connect-to-db).

{% if audience == "internal" %}

{% note info %}

Для аутентификации в YDB тестовое приложение использует токен из переменной окружения __YDB_TOKEN__.

{% endnote %}

{% endif %}

После запуска и выполнения приложения в консоли отобразится следующий результат:

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

- .NET

  ```bash
  $ ./Ydb.Sdk.Examples.BasicExample -e <endpoint> -d <database>

  > SimpleSelect, columns: 3, rows: 1, truncated: False
  > Series, series_id: 1, title: IT Crowd, release_date: 02/03/2006 00:00:00
  > SimpleSelect, columns: 3, rows: 1, truncated: False
  > Series, series_id: 10, title: Comming soon, release_date: 09/20/2021 00:00:00
  > ReadTable seasons, series_id: 1, season_id: 1, first_aired: 02/03/2006 00:00:00
  > ReadTable seasons, series_id: 1, season_id: 2, first_aired: 08/24/2007 00:00:00
  > ReadTable seasons, series_id: 1, season_id: 3, first_aired: 11/23/2008 00:00:00
  > ReadTable seasons, series_id: 1, season_id: 4, first_aired: 06/25/2010 00:00:00
  > ReadTable seasons, series_id: 2, season_id: 1, first_aired: 04/06/2014 00:00:00
  > ScanQuery, series_id: 1, season_id: 2, episodes_count: 5
  > ScanQuery, series_id: 1, season_id: 3, episodes_count: 6
  > ScanQuery, series_id: 1, season_id: 4, episodes_count: 6
  > ScanQuery, series_id: 2, season_id: 1, episodes_count: 8
  > ScanQuery, series_id: 2, season_id: 2, episodes_count: 10
  > ScanQuery, series_id: 2, season_id: 3, episodes_count: 10
  > ScanQuery, series_id: 2, season_id: 4, episodes_count: 10
  > ScanQuery, series_id: 2, season_id: 5, episodes_count: 8
  ```

{% endlist %}

## Создание экземпляра драйвера, клиента и сессии {#driver-client-session-init}

Для взаимодействия с {{ ydb-short-name }} необходимо создать экземпляр драйвера, клиента и сессии:

* Драйвер {{ ydb-short-name }} отвечает за взаимодействие приложения и {{ ydb-short-name }} на транспортном уровне.
* Клиент {{ ydb-short-name }} работает поверх драйвера {{ ydb-short-name }} и отвечает за работу с сущностями и транзакциями.
* Сессия {{ ydb-short-name }} содержит информацию о выполняемых транзакциях и подготовленных запросах и содержится в контексте клиента {{ ydb-short-name }}.

### Инициализация драйвера {#driver-init}

Драйвер отвечает за взаимодействие приложения и {{ ydb-short-name }} на транспортном уровне. Драйвер должен существовать на всем протяжении жизненного цикла работы с {{ ydb-short-name }}. Перед тем как создать клиента {{ ydb-short-name }} и установить сессию, необходимо инициализировать драйвер {{ ydb-short-name }}. Фрагмент кода приложения, демонстрирующий инициализацию драйвера параметрами соединения с БД:

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

- C#

  ```c#
  public static async Task Run(
      string endpoint,
      string database,
      ICredentialsProvider credentialsProvider)
  {
      var config = new DriverConfig(
          endpoint: endpoint,
          database: database,
          credentials: credentialsProvider
      );

      using var driver = new Driver(
          config: config
      );

      await driver.Initialize();
  }
  ```

{% endlist %}

### Инициализация клиента и сессии {{ ydb-short-name }} {#client-session-init}

Клиент отвечает за работу с сущностями {{ ydb-short-name }}. Сессия содержит информацию о выполняемых транзакциях и подготовленных запросах. Фрагмент кода приложения для создания сессии:

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

- C#

  ```c#
  using var tableClient = new TableClient(driver, new TableClientConfig());
  ```

{% endlist %}

## Создание таблиц {#create-table-api}

{% list tabs %}

- Python

  Для создания таблиц используется метод `session.create_table()`:

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

  С помощью метода `session.describe_table()` можно вывести информацию о структуре таблицы и убедиться, что она успешно создалась:

  ```python
  def describe_table(session, path, name):
      result = session.describe_table(os.path.join(path, name))
      print("\n> describe table: series")
      for column in result.columns:
          print("column, name:", column.name, ",", str(column.type.item).strip())
  ```

- Go

  Для создания таблиц используется метод `Session.CreateTable()`:

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
  С помощью метода `Session.DescribeTable()` можно вывести информацию о структуре таблицы и убедиться, что она успешно создалась:

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

  Для создания таблиц используется метод `Session.createTable()`:

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

  С помощью метода `Session.describeTable()` можно вывести информацию о структуре таблицы и убедиться, что она успешно создалась:

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

- C#

  Для создания таблиц используется метод `session.ExecuteSchemeQuery` с DDL (Data Definition Language) YQL-запросом.

  ```c#
  var response = await tableClient.SessionExec(async session =>
  {
      return await session.ExecuteSchemeQuery(@"
          CREATE TABLE series (
              series_id Uint64,
              title Utf8,
              series_info Utf8,
              release_date Date,
              PRIMARY KEY (series_id)
          );

          CREATE TABLE seasons (
              series_id Uint64,
              season_id Uint64,
              title Utf8,
              first_aired Date,
              last_aired Date,
              PRIMARY KEY (series_id, season_id)
          );

          CREATE TABLE episodes (
              series_id Uint64,
              season_id Uint64,
              episode_id Uint64,
              title Utf8,
              air_date Date,
              PRIMARY KEY (series_id, season_id, episode_id)
          );
      ");
  });

  response.Status.EnsureSuccess();
  ```

{% endlist %}

`PRAGMA TablePathPrefix` добавляет указанный префикс к путям таблиц внутри БД. Работает по принципу объединения путей в файловой системе — поддерживает ссылки на родительский каталог и не требует добавления слеша справа. Например:

```
PRAGMA TablePathPrefix = "/cluster/database";
SELECT * FROM episodes;
```

Подробнее о PRAGMA YQL можно прочитать в [документации YQL](../yql/reference/overview.md).

## Обработка запросов и транзакций {#query-processing}

{% list tabs %}

- Python

  Для выполнения YQL-запросов используется метод `session.transaction().execute()`.
  SDK позволяет в явном виде контролировать выполнение транзакций и настраивать необходимый режим выполнения транзакций с помощью класса ```TxControl```.

  В фрагменте кода, приведенном ниже, транзакция выполняется с помощью метода ```transaction().execute()```. Устанавливается режим выполнения транзакции ```ydb.SerializableReadWrite()```. После завершения всех запросов транзакции она будет автоматически завершена с помощью явного указания флага: ```commit_tx=True```. Тело запроса описано с помощью синтаксиса YQL и как параметр передается методу ```execute```.

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

  Для выполнения YQL-запросов используется метод `Session.Execute()`.
  SDK позволяет в явном виде контролировать выполнение транзакций и настраивать необходимый режим выполнения транзакций с помощью класса ```TxControl```.

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

  Для выполнения YQL-запросов используется метод `Session.executeDataQuery()`.
  SDK позволяет в явном виде контролировать выполнение транзакций и настраивать необходимый режим выполнения транзакций с помощью класса `TxControl`.

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

- C#

  Для выполнения YQL-запросов используется метод `session.ExecuteDataQuery()`. SDK позволяет в явном виде контролировать выполнение транзакций и настраивать необходимый режим выполнения транзакций с помощью класса `TxControl`. В фрагменте кода, приведенном ниже, используется транзакция с режимом `SerializableRW` и автоматическим коммитом после выполнения запроса. Значения параметров запроса передаются в виде словаря имя-значение в аргументе `parameters`.

  ```c#
  var response = await tableClient.SessionExec(async session =>
  {
      var query = @"
          DECLARE $id AS Uint64;

          SELECT
              series_id,
              title,
              release_date
          FROM series
          WHERE series_id = $id;
      ";

      return await session.ExecuteDataQuery(
          query: query,
          txControl: TxControl.BeginSerializableRW().Commit(),
          parameters: new Dictionary<string, YdbValue>
              {
                  { "$id", YdbValue.MakeUint64(id) }
              },
      );
  });

  response.Status.EnsureSuccess();
  var queryResponse = (ExecuteDataQueryResponse)response;
  var resultSet = queryResponse.Result.ResultSets[0];
  ```

{% endlist %}

## Обработка результатов выполнения {#results-processing}

{% list tabs %}

- Python

  Результат выполнения запроса:

  ```python
  print("\n> select_simple_transaction:")
  for row in result_sets[0].rows:
      print("series, id: ", row.series_id, ", title: ", row.title, ", release date: ", row.release_date)
  ```

- Go

  Результат выполнения запроса:

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

  Результат выполнения запроса:

  ```java
  System.out.println("\n--[ SelectSimple ]--");
  new TablePrinter(result.getResultSet(0)).print();
  ```

- C#

  Результат выполнения запроса (ResultSet) состоит из упорядоченного набора строк (Rows). Пример обработки результата выполнения запроса:

  ```c#
  foreach (var row in resultSet.Rows)
  {
      Console.WriteLine($"> Series, " +
          $"series_id: {(ulong?)row["series_id"]}, " +
          $"title: {(string?)row["title"]}, " +
          $"release_date: {(DateTime?)row["release_date"]}");
  }
  ```


{% endlist %}

## Запросы на запись и изменение данных {#write-queries}

{% list tabs %}

- Python

  Фрагмент кода, демонстрирующий выполнение запроса на запись/изменение данных:

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

  Фрагмент кода, демонстрирующий выполнение запроса на запись/изменение данных:

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

- C#

  Фрагмент кода, демонстрирующий выполнение запроса на запись/изменение данных:

  ```c#
  var response = await tableClient.SessionExec(async session =>
  {
      var query = @"
          DECLARE $id AS Uint64;
          DECLARE $title AS Utf8;
          DECLARE $release_date AS Date;

          UPSERT INTO series (series_id, title, release_date) VALUES
              ($id, $title, $release_date);
      ";

      return await session.ExecuteDataQuery(
          query: query,
          txControl: TxControl.BeginSerializableRW().Commit(),
          parameters: new Dictionary<string, YdbValue>
              {
                  { "$id", YdbValue.MakeUint64(1) },
                  { "$title", YdbValue.MakeUtf8("NewTitle") },
                  { "$release_date", YdbValue.MakeDate(DateTime.UtcNow) }
              }
      );
  });

  response.Status.EnsureSuccess();
  ```

{% endlist %}

## Параметризованные подготовленные запросы {#param-prepared-queries}

Параметризованные подготовленные запросы (prepared queries) записываются в форме шаблона, в котором определенного вида имена заменяются конкретными параметрами при каждом выполнении запроса. Использование параметризованных запросов может улучшить производительность за счет сокращения частоты выполнения компиляции и перекомпиляции запросов, отличающихся только значениями параметров.

{% list tabs %}

- Python

  Фрагмент кода, демонстрирующий возможность использования параметризованных подготовленных запросов. Подготовленный запрос хранится в контексте сессии.

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

  Фрагмент кода, демонстрирующий возможность использования параметризованных подготовленных запросов. Подготовленный запрос хранится в контексте сессии.

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

## Явное использование вызовов TCL Begin/Commit {#tcl-usage}

{% list tabs %}

- Python

  В большинстве случаев вместо явного использования [TCL](../concepts/transactions.md) вызовов Begin и Commit лучше использовать параметры контроля транзакций в вызовах execute. Это позволит избежать лишних обращений к {{ ydb-short-name }} и эффективней выполнять запросы. Фрагмент кода, демонстрирующий явное использование вызовов `transaction().begin()` и `tx.Commit()`:

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

  В большинстве случаев вместо явного использования [TCL](../concepts/transactions.md) вызовов Begin и Commit лучше использовать параметры контроля транзакций в вызовах `execute`. Это позволит избежать лишних обращений к {{ ydb-short-name }} и эффективней выполнять запросы. Фрагмент кода, демонстрирующий явное использование вызовов `beginTransaction()` и `transaction.Commit()`:

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

## Обработка ошибок {#error-handling}

Подробно об обработке ошибок написано в разделе [Обработка ошибок в API](../ydb-sdk/error_handling.md).
