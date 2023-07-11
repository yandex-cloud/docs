1. Выберите роль, которую хотите назначить сервисному аккаунту. Описание ролей можно найти в документации {{ iam-full-name }} в разделе [{#T}](../../iam/concepts/access-control/roles.md).

1. Узнайте идентификатор сервисного аккаунта по его имени:

    ```bash
    yc iam service-account get my-robot
    ```

    Результат:

    ```bash
    id: aje6o61dvog2h6g9a...
    folder_id: b1gvmob95yysaplct...
    created_at: "2018-10-15T18:01:25Z"
    name: my-robot
    ```

    Если вы не знаете имя сервисного аккаунта, получите список сервисных аккаунтов с их идентификаторами:

    ```bash
    yc iam service-account list
    ```

    Результат:
    
    ```bash
    +----------------------+------------------+-----------------+
    |          ID          |       NAME       |   DESCRIPTION   |
    +----------------------+------------------+-----------------+
    | aje6o61dvog2h6g9a... | my-robot         | my description  |
    +----------------------+------------------+-----------------+
    ```

1. Назначьте роль `{{ roles-viewer }}` сервисному аккаунту `my-robot`, используя его идентификатор:

    ```bash
    yc resource-manager folder add-access-binding my-folder \
      --role viewer \
      --subject serviceAccount:aje6o61dvog2h6g9a...
    ```