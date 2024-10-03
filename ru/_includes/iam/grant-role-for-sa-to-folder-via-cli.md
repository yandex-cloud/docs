1. Выберите роль, которую хотите назначить сервисному аккаунту. Описание ролей можно найти в документации {{ iam-full-name }} в [справочнике ролей {{ yandex-cloud }}](../../iam/roles-reference.md).

1. Узнайте идентификатор сервисного аккаунта по его имени:

    ```bash
    yc iam service-account get my-robot
    ```

    Результат:

    ```text
    id: aje6o61dvog2********
    folder_id: b1gvmob95yys********
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
    | aje6o61dvog2******** | my-robot         | my description  |
    +----------------------+------------------+-----------------+
    ```

1. Назначьте роль `{{ roles-viewer }}` сервисному аккаунту `my-robot`, используя его идентификатор:

    ```bash
    yc resource-manager folder add-access-binding my-folder \
      --role viewer \
      --subject serviceAccount:aje6o61dvog2********
    ```