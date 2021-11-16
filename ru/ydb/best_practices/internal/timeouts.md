---
title: Использование таймаутов в Yandex Database (YDB)
description: 'Значение operation_timeout определяет время, в течение которого результат запроса интересен пользователю. Если за данное время операция не выполнилась, сервер возвращает ошибку c кодом Timeout и попытается прекратить выполнение запроса, однако отмена запроса не гарантируется. Всегда рекомендуется устанавливать и таймаут на операцию, и транспортный таймаут. '
---

# Использование таймаутов

Подробнее об использовании таймаутов читайте в [документации](https://cloud.yandex.ru/docs/ydb/oss/public/develop/best_practices/timeouts).

Примеры использования таймаутов:

{% list tabs %}

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
      "a.yandex-team.ru/kikimr/public/sdk/go/ydb"
      "a.yandex-team.ru/kikimr/public/sdk/go/ydb/table"
  )

  func executeInTx(ctx context.Context, s *table.Session, query string) {
      newCtx, close := context.WithTimeout(ctx, time.Millisecond*300)         // client and by default operation timeout
      newCtx2 := ydb.WithOperationTimeout(newCtx, time.Millisecond*400)       // operation timeout override
      newCtx3 := ydb.WithOperationCancelAfter(newCtx2, time.Millisecond*300)  // cancel after timeout
      defer close()
      tx := table.TxControl(table.BeginTx(table.WithSerializableReadWrite()), table.CommitTx())
      _, res, err := session.Execute(newCtx3, tx, query)
  }
  ```

{% endlist %}
