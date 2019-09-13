# Работа с SDK

При написании своего приложения можно использовать SDK, доступные для языков [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Go](https://github.com/yandex-cloud/ydb-go-sdk) и [Java](https://github.com/yandex-cloud/ydb-java-sdk).

На этой странице подробно разбирается код тестового приложения `basic_example`, доступного в составе SDK:

* Для [Python](https://github.com/yandex-cloud/ydb-python-sdk/tree/master/kikimr/public/sdk/python/examples/basic_example)
* Для [Go](https://github.com/yandex-cloud/ydb-go-sdk/tree/master/example/basic_example)
{% if audience == "internal" %}
* Для [C++](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/examples/basic_example)
{% endif %}

Чтобы запустить приложение, необходимо подключиться к базе данных. Подробнее читайте в разделе [{#T}](../quickstart.md#sdk).

{% if audience == "internal" %}

{% note info %}

Для аутентификации в YDB тестовое приложение использует токен из переменной окружения __YDB_TOKEN__.

{% endnote %}

{% endif %}

После запуска и выполнения `basic_example` в консоли отобразится следующий результат:

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

## Создание экземпляра драйвера, клиента и сессии {#driver-client-session-init}

Для взаимодействия с {{ ydb-short-name }} необходимо создать экземпляр драйвера, клиента и сессии:

* Драйвер {{ ydb-short-name }} отвечает за взаимодействие приложения и {{ ydb-short-name }} на транспортном уровне.
* Клиент {{ ydb-short-name }} работает поверх драйвера {{ ydb-short-name }} и отвечает за работу с сущностями и транзакциями.
* Сессия {{ ydb-short-name }} содержит информацию о выполняемых транзакциях и подготовленных запросах и содержится в контексте клиента {{ ydb-short-name }}.

### Инициализация драйвера {#driver-init}

Драйвер отвечает за взаимодействие приложения и {{ ydb-short-name }} на транспортном уровне. Драйвер должен существовать на всем протяжении жизненного цикла работы с {{ ydb-short-name }}. Перед тем как создать клиента {{ ydb-short-name }} и установить сессию, необходимо инициализировать драйвер {{ ydb-short-name }}. Фрагмент кода приложения `basic_example`, демонстрирующий инициализацию драйвера параметрами соединения с БД:

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

### Инициализация клиента и сессии {{ ydb-short-name }} {#client-session-init}

Клиент отвечает за работу с сущностями {{ ydb-short-name }}. Сессия содержит информацию о выполняемых транзакциях и подготовленных запросах. Фрагмент кода приложения `basic_example` для создания сессии:

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

## Создание таблиц с помощью CreateTable API {#create-table-api}

{% list tabs %}

- Python
  
  Для создания таблиц используется метод `create_table`:
  
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
  
  С помощью метода `describe_table` можно вывести информацию о структуре таблицы и убедиться, что она успешно создалась. Фрагмент кода `basic_example` демонстрирует вывод информации о структуре таблицы, полученной с помощью метода `describe_table`:
  
  ```python
  result = session.describe_table(os.path.join(path, name))
  print("\n> describe table: series")
  for column in result.columns:
      print("column, name:", column.name, ",", str(column.type.optional_type.item).strip())
  ```
  
- Go
  
  Для создания таблиц используется метод `createTables`:
  
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
  С помощью метода `describeTable` можно вывести информацию о структуре таблицы и убедиться, что она успешно создалась:
  
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

Фрагмент кода `basic_example`, который при запуске выводит текст в консоль:

```bash
> describe table: series
('column, name:', 'series_id', ',', 'type_id: UINT64')
('column, name:', 'title', ',', 'type_id: UTF8')
('column, name:', 'series_info', ',', 'type_id: UTF8')
('column, name:', 'release_date', ',', 'type_id: UINT64')
```

`PRAGMA TablePathPrefix` добавляет указанный префикс к путям таблиц внутри БД. Работает по принципу объединения путей в файловой системе — поддерживает ссылки на родительский каталог и не требует добавления слеша справа. Например:

```
PRAGMA TablePathPrefix = "/ru/tutorial/home/testdb";
SELECT * FROM Episodes;
```

Подробнее про PRAGMA YQL написано в [документации YQL](../yql/reference/quickstart.md).

## Обработка запросов и транзакций {#query-processing}

{% list tabs %}

- Python
  
  Для выполнения YQL-запросов используется метод `session.transaction().execute()`.
  SDK позволяет в явном виде контролировать выполнение транзакций и настраивать необходимый режим выполнения транзакций с помощью класса ```TxControl```.
  
  В фрагменте кода `basic_example`, приведенном ниже, транзакция выполняется с помощью метода ```transaction().execute()```. Устанавливается режим выполнения транзакции ```ydb.SerializableReadWrite()```. После завершения всех запросов транзакции она будет автоматически завершена с помощью явного указания флага: ```commit_tx=True```. Тело запроса описано с помощью синтаксиса YQL и как параметр передается методу ```execute```.
  
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
  
  Для выполнения YQL-запросов используется метод `Session.selectSimple()`.
  SDK позволяет в явном виде контролировать выполнение транзакций и настраивать необходимый режим выполнения транзакций с помощью класса ```TxControl```.
  
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

## Обработка результатов выполнения {#results-processing}

{% list tabs %}

- Python
  
  В качестве результатов выполнения запроса возвращается ```result_set```:
  
  ```python
  for row in result_sets[0].rows:
      print("series, id: ", row.series_id, ", title: ", row.title, ", release date: ", row.release_date)
  ```
  
  Проверка:
  
  ```bash
  > SelectSimple:
  series, Id: 1, title: IT Crowd, Release date: 2006-02-03
  ```
{% endlist %}

## Запросы на запись и изменение данных {#write-queries}

{% list tabs %}

- Python
  
  Фрагмент кода `basic_example`, демонстрирующий выполнение запроса на запись/изменение данных:
  
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

## Параметризованные подготовленные запросы {#param-prepared-queries}

Параметризованные подготовленные запросы (prepared queries) записываются в форме шаблона, в котором определенного вида имена заменяются конкретными параметрами при каждом выполнении запроса. Использование параметризованных запросов может улучшить производительность, за счет сокращения частоты выполнения компиляции и перекомпиляции запросов, отличающихся только значениями параметров.

{% list tabs %}

- Python
  
  Фрагмент кода `basic_example`, демонстрирующий возможность использования параметризованных подготовленных запросов. Подготовленный запрос хранится в контексте сессии.
  
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
  
  Проверка:
  
  ```bash
  > select_prepared_transaction:
  ('episode title:', u'To Build a Better Beta', ', air date:', '2016-06-05')
  ```
{% endlist %}

## Явное использование вызовов TCL Begin/Commit {#tcl-usage}

{% list tabs %}

- Python
  
  В большинстве случаев вместо явного использования [TCL](../concepts/transactions.md) вызовов Begin и Commit лучше использовать параметры контроля транзакций в вызовах execute. Это позволит избежать лишних обращений к YDB и эффективней выполнять запросы. Фрагмент кода `basic_example` демонстрирующий явное использование вызовов ```transaction().begin()``` и ```tx.Commit()```:
  
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

## Обработка ошибок {#error-handling}

Подробно об обработке ошибок написано в разделе [Обработка ошибок в API](../api/error_handling.md).
