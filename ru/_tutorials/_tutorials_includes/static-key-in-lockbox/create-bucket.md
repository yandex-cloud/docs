{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  ```bash
  aws --endpoint-url=https://storage.yandexcloud.net \
    s3 mb s3://<имя_бакета>
  ```

  Результат:

  ```bash
  make_bucket: my-first-bucket
  ```

{% endlist %}

В результате будет создан новый бакет в {{ objstorage-name }}. При создании бакета используется статический ключ доступа, полученный из секрета {{ lockbox-name }} и сохраненный в переменные окружения.

Вы также передать значения идентификатора ключа, секретного ключа и региона размещения непосредственно в каждой команде AWS CLI: