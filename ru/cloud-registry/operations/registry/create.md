# Создание реестра

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать реестр.
    1. В списке сервисов выберите **{{ cloud-registry-name }}**.
    1. Перейдите на вкладку **Реестры**.
    1. В правом верхнем углу нажмите кнопку **Создать реестр**.
    1. Выберите формат реестра.
    1. Если выбрали формат реестра Maven, укажите политику версий:
        * `Release` — стабильные версии;
        * `Snapshot` — разработка с частыми обновлениями;
        * `Mixed` — сочетание политик `Release` и `Snapshot` для гибкости.
    1. Введите имя и описание реестра.
    1. Нажмите **Создать**.

- CLI {#cli}

    Чтобы создать реестр, выполните команду:

    ```
    yc cloud-registry registry create \
      --name <имя_реестра> \
      --description <описание_реестра> \
      --registry-kind <формат_реестра> \
      --registry-type <расположение_реестра>
    ```

    Где:
    * `--name` — имя реестра.
    * `--description` — описание реестра.
    * `--registry-kind` — формат реестра. Доступные значения — `maven`, `npm` и `docker`.
    * `--registry-type` — расположение реестра. Доступные значения — `local`.

    Результат:

    ```
    done (3s)
    id: cn1fsnc2dak********
    folder_id: b1gc1t4cb638********
    name: my-first-registry
    kind: DOCKER
    type: LOCAL
    status: ACTIVE
    description: docker
    created_at: "2024-11-30T16:11:12.901356Z"
    modified_at: "2024-11-30T16:11:16.243323Z"
    ```

- API {#api}

    Чтобы создать реестр, воспользуйтесь методом REST API [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Create](../../api-ref/grpc/Registry/create.md).

{% endlist %}
