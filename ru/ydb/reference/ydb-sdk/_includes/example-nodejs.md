# Приложение на Node.js

На этой странице подробно разбирается код тестового приложения, доступного в составе Node.js SDK {{ ydb-short-name }}.

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
