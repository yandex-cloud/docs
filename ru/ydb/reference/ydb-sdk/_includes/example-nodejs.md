---
sourcePath: core/reference/ydb-sdk/_includes/example-nodejs.md
---
# Приложение на Node.js

На этой странице подробно разбирается код [тестового приложения](https://github.com/ydb-platform/ydb-nodejs-sdk/tree/master/examples/basic-example-v1), доступного в составе [Node.js SDK](https://github.com/yandex-cloud/ydb-nodejs-sdk) YDB.

{% include [addition.md](example/addition.md) %}

{% include [step-scan-query-intro.md](example/step-scan-query-intro.md) %}

```js
let count = 0;

const consumer = (result: ExecuteScanQueryPartialResult) => {
  count += result.resultSet?.rows?.length || 0;
};

await session.streamExecuteScanQuery(`
  DECLARE $value as Utf8;
  SELECT * FROM table WHERE value=$value;
`, consumer, {'$value': Primitive.utf8('ttt')});
```

{% include [step-error-handling.md](example/step-error-handling.md) %}
