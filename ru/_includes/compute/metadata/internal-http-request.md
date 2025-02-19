```http request
GET http://169.254.169.254/computeMetadata/v1/instance/
  ? alt=<json|text>
  & recursive=<true|false>
  & wait_for_change=<true|false>
  & last_etag=<string>
  & timeout_sec=<int>
Metadata-Flavor: Google
```

Где:
* `alt` — формат ответа (по умолчанию `text`).
* `recursive` — если `true`, возвращает все значения по дереву рекурсивно. По умолчанию `false`.
* `wait_for_change` — если `true`, ответ будет возвращен только когда один из параметров метаданных изменится. По умолчанию `false`.
* `last_etag` — значение ETag из предыдущего ответа на аналогичный запрос. Используйте при `wait_for_change="true"`.
* `timeout_sec` — максимальное время ожидания запроса. Используйте при `wait_for_change="true"`.

В ответ сервис вернет актуальные значения [ключей](../../../compute/concepts/metadata/directories.md#dir-compute) метаданных каталога `computeMetadata`.