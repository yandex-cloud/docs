# Использование плана запроса

Когда вы выполняете какой-либо запрос, оптимизатор запросов YDB пытается придумать оптимальный план выполнения этого запроса. Чтобы анализировать и лучше понимать работу своих запросов, вы можете получить и проанализировать план запроса. Получить план запроса можно:

* С помощью YDB CLI.
* В консоли управления.

Дополнительно к плану запроса вы можете получить AST (абстрактное синтаксическое дерево). Раздел AST содержит представление на внутреннем языке miniKQL. Эта информация нужна разработчикам YDB для диагностики запроса.

## Получение плана запроса

{% include [note_sample_tables](../_includes/note_sample_tables.md) %}

Получите план следующего запроса:

{% include [select-from-series](../_includes/queries/select-from-series.md) %}

{% list tabs %}

- YDB CLI

  1. Если у вас еще нет интерфейса командной строки YDB CLI, [установите его и подготовьте к работе](../quickstart/yql-api/ydb-cli.md#how-to-install).
  2. Для получения плана запроса используйте команду `explain`. Посмотрите как использовать команду, выполнив:
     ```bash
     ydb table query explain --help
     ```
  3. Выполните команду:
     ```bash
     ydb -e grpcs://<эндпоинт> -d <база данных> \
     table query explain -q "SELECT season_id, episode_id, title \
     FROM episodes \
     WHERE series_id = 1 AND season_id > 1 \
     ORDER BY season_id, episode_id LIMIT 3"
     ```

     Результат выполнения:
  
     ```bash
     Query plan:
     {
         meta : {
             version : "0.1",
             type : query
         },
         tables : [
             {
                 name : "/ru-central1/b1gia87mbaomkfvsleds/etn008v5oqsj8joktlvd/episodes",
                 reads : [
                     {
                         type : Lookup,
                         lookup_by : [
                             "series_id (\"1\")"
                         ],
                         scan_by : [
                             "season_id (\"1\", +inf]",
                             episode_id
                         ],
                         columns : [
                             episode_id,
                             season_id,
                             title
                         ]
                     }
                 ]
             }
         ]
     }
     ```

  4. Для получения AST (абстрактного синтаксического дерева) добавьте в конце команды флаг `--ast`:
     ```bash
     ydb -e grpcs://<эндпоинт> -d <база данных> \
     table query explain -q "SELECT season_id, episode_id, title \
     FROM episodes \
     WHERE series_id = 1 AND season_id > 1 \
     ORDER BY season_id, episode_id LIMIT 3" --ast
     ```
  
     В результате дополнительно отобразится AST запроса:
  
     ```bash
     Query AST:
     (
     (let $1 '('"/ru-central1/b1gia87mbaomkfvsleds/etn008v5oqsj8joktlvd/episodes" '"1" '"72075186234215788:16"))
     (let $2 (Uint64 '"1"))
     (let $3 '('"series_id" $2 $2))
     (let $4 '('"season_id" $2 (Void)))
     (let $5 '('"episode_id" (Void) (Void)))
     (let $6 '('"ExcFrom" '"IncTo" $3 $4 $5))
     (let $7 '('"episode_id" '"season_id" '"title"))
     (let $8 (KiSelectRange '"db" $1 $6 $7 '('('"SkipNullKeys" '('"series_id" '"season_id")))))
     (let $9 (Bool 'true))
     (let $10 '($9 $9))
     (let $11 (lambda '($15) '((Member $15 '"season_id") (Member $15 '"episode_id"))))
     (let $12 (KiPartialSort $8 $10 $11))
     (let $13 (Uint64 '"3"))
     (let $14 (Sort (KiPartialTake $12 $13) $10 $11))
     (return '('((Take $14 $13)) (List (ListType (VoidType)))))
     )
     ```

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог для работы.
  1. В списке сервисов выберите **Yandex Database**.
  2. На странице **Базы данных** выберите базу, где содержится таблица `episodes`.
  3. Чтобы открыть корневую директорию базы, перейдите на вкладку **Навигация**.
  4. Для создания запроса к базе нажмите кнопку SQL-запрос в правом верхнем углу. Откроется страница **Запрос**.
  5. В поле **Запрос** введите: 
     
     {% include [select-from-series](../_includes/queries/select-from-series.md) %}

  6. Чтобы получить план запроса в нижней части окна нажмите на кнопку ![image](../_assets/ydb_btn_select.png "Кнопка выбора") (рядом с кнопкой Запрос) и выберите пункт **Explain**.

     В результе отобразится поле, содержащее план запроса:

     ```
     {
         "meta": {
             "type": "query",
             "version": "0.1"
         }
         "tables": [
             {
                 "name": "/ru-central1/b1gia87mbaomkfvsleds/etn008v5oqsj8joktlvd/episodes",
                 "reads": [
                     {
                         "columns": [
                             "episode_id",
                             "season_id",
                             "title"
                         ],
                         "lookup_by": [
                             "series_id (\"1\")"
                         ],
                         "scan_by": [
                             "season_id (\"1\", +inf]",
                             "episode_id"
                         ],
                         "type": "Lookup"
                     }
                 ]
             }
         ]
     }
     ```

{% endlist %}

## Анализ плана запроса

{% include [query explain](../_includes/query-explain.md) %}