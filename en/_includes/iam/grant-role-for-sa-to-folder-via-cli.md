1. Select the role to assign to the service account. You can find the description of the roles in the {{ iam-full-name }} documentation in the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md).

1. Find out the service account ID by its name:

    ```bash
    yc iam service-account get my-robot
    ```

    Result:

    ```text
    id: aje6o61dvog2********
    folder_id: b1gvmob95yys********
    created_at: "2018-10-15T18:01:25Z"
    name: my-robot
    ```

    If you don't know the name of the service account, get a list of service accounts with their IDs:

    ```bash
    yc iam service-account list
    ```

    Result:

    ```bash
    +----------------------+------------------+-----------------+
    |          ID          |       NAME       |   DESCRIPTION   |
    +----------------------+------------------+-----------------+
    | aje6o61dvog2******** | my-robot         | my description  |
    +----------------------+------------------+-----------------+
    ```

1. Assign the `{{ roles-viewer }}` role to the `my-robot` service account using its ID:

    ```bash
    yc resource-manager folder add-access-binding my-folder \
      --role viewer \
      --subject serviceAccount:aje6o61dvog2********
    ```
