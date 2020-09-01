В разделе приведено описание доступных таймаутов и представлены примеры использования на различных языках программирования.

## Таймаут на операцию ``operation_timeout``

Данное значение определяет время, в течение которого результат запроса интересен пользователю. Если за данное время операция не выполнилась, сервер возращает ошибку c кодом ``Timeout`` и попытается завершить выполнение запроса, однако отмена запроса не гарантируется. Таким образом, запрос, на который пользовавателю была возвращена ошибка ``Timeout``, может быть как успешно выполнен на сервере, так и отменен.

## Таймаут отмены операции ``cancel_after``

Данное значение опеределяет время, через которое сервер начнет отмену запроса, если отменить запрос возможно. В случае успешной отмены запрос сервер вернет ошибку с кодом ``Cancelled``.

## Транспортный таймаут

На каждый запрос клиент может выставить транспортный таймаут. Данное значение позволяет определить количество времени, которое клиент готов ждать ответа от сервера. Если за данное время сервер не ответил, то клиенту будет возвращена транспортная ошибка c кодом ``DeadlineExceeded``.

## Применение таймаутов

Всегда рекомендуется устанавливать таймаут на операцию и транспортный таймаут. Обычно транспортный таймаут должен быть чуть больше на 50-100ms, чем таймаут на операцию, поскольку таким образом остается некоторый запас времени, за который клиент сможет получить серверную ошибку c кодом ``Timeout``.

Рассмотрим примеры использования таймаутов на различных языках программирования:

{% list tabs %}

- Python

  ```python
  from kikimr.public.sdk.python import client as ydb

  def execute_in_tx(session, query):
    settings = ydb.BaseRequestSettings()
    settings = settings.with_timeout(0.5)  # transport timeout
    settings = settings.with_operation_timeout(0.4)  # operation timeout
    settings = settings.with_cancel_after(0.4)  # cancel after timeout
    session.transaction().execute(
        query,
        commit_tx=True,
        settings=settings,
    )
  ```
w
- С++
  ```cpp
  #include <kikimr/public/sdk/cpp/client/ydb.h>
  #include <kikimr/public/sdk/cpp/client/ydb_table.h>
  #include <kikimr/public/sdk/cpp/client/ydb_value.h>

  using namespace NYdb;
  using namespace NYdb::NTable;

  TAsyncStatus ExecuteInTx(TSession& session, TString query, TParams params) {
    return session.ExecuteDataQuery(
        query
        , TTxControl::BeginTx(TTxSettings::SerializableRW()).CommitTx()
        , TExecDataQuerySettings()
        .OperationTimeout(TDuration::MilliSeconds(300))  // operation timeout
        .ClientTimeout(TDuration::MilliSeconds(400))   // transport timeout
        .CancelAfter(TDuration::MilliSeconds(300)));  // cancel after timeout
  }

  ```

- Go
  ```go
  import (
      "context"
      "a.yandex-team.ru/kikimr/public/sdk/go/ydb/table"
  )

  func executeInTx(ctx context.Context, s *table.Session, query string) {
      newCtx, close := context.WithTimeout(ctx, time.Second)
      defer close()
      tx := table.TxControl(table.BeginTx(table.WithSerializableReadWrite()), table.CommitTx())
      _, res, err := session.Execute(newCtx, tx, query)
  }
  ```

{% endlist %}
