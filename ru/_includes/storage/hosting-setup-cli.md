1. Посмотрите описание команды CLI для настройки хостинга статического сайта в бакете:

    ```bash
    yc storage bucket update --help
    ```
    
1. Создайте файл с настройками хостинга в формате JSON. Например:
    
    ```json
    {
      "index": "index.html",
      "error": "error404.html"
    }
    ```

    Где:

    * `index` — абсолютный путь к файлу главной страницы сайта.

      {% include [static-site-index-restriction](static-site-index-restriction.md) %}

    * `error` — абсолютный путь к файлу, который будет отображаться пользователю при ошибках 4xx.

1. Выполните следующую команду:

    ```bash
    yc storage bucket update --name <имя_бакета> \
      --website-settings-from-file <путь_к_файлу>
    ```
    
    Где:
    * `--name` — имя бакета.
    * `--website-settings-from-file` — путь к файлу с настройками хостинга.

    Результат:

    ```text
    name: my-bucket
    folder_id: b1gjs8dck8bv********
    default_storage_class: STANDARD
    versioning: VERSIONING_SUSPENDED
    max_size: "10737418240"
    acl: {}
    created_at: "2022-12-14T08:42:16.273717Z"
    ```

Чтобы убедиться, что настройки хостинга появились в описании бакета, выполните команду:

```bash
yc storage --name <имя_бакета> bucket get --full
```

Результат:

```text
website_settings:
  index: index.html
  error: error404.html
  redirect_all_requests: {}
```