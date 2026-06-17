# Создать локальный реестр

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать локальный реестр.
    1. Перейдите в сервис **Cloud Registry**.
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Реестры**.
    1. В правом верхнем углу нажмите кнопку **Создать реестр**.
    1. Выберите формат реестра.
    1. В поле **Тип реестра** выберите `Local`.
    1. Если вы выбрали формат реестра:

        * `Docker`, укажите политику неизменяемости артефактов:

            * `Disabled` — не использовать политику.
            * `Simple` — запретить перезаписывать артефакты.
            * `Full` — запретить перезаписывать артефакты, даже если артефакт удален.

        * `Maven`, укажите политику версий:

            * `Mixed` — сочетание политик `Release` и `Snapshot` для гибкости.
            * `Release` — стабильные версии.
            * `Snapshot` — разработка с частыми обновлениями.

    1. Введите имя и описание реестра.
    1. Добавьте метки в формате `ключ: значение`.
    1. Нажмите **Создать**.

- CLI {#cli}

    Чтобы создать локальный реестр, выполните команду:

    ```
    yc cloud-registry registry create \
      --name <имя_реестра> \
      --description <описание_реестра> \
      --registry-kind <формат реестра> \
      --registry-type local \
      --properties <cвойства_реестра>
    ```

    Где:
    * `--name` — имя реестра.
    * `--description` — описание реестра.
    * `--registry-kind` — формат реестра. Доступные форматы: `maven`, `npm`, `docker`, `nuget`, `pypi`, `binary`.
    * `--registry-type` — [тип](../../concepts/registry.md#registry-types) реестра.
    * `--properties` — свойства реестра. Задаются строкой в формате `name1=value1,name2=value2`. Доступные свойства для локальных реестров:

        * `immutable-artifacts-policy` — политика неизменяемости артефактов. Поддерживается только для формата реестра `docker`. Доступные политики:

            * `disabled` — не использовать политику.
            * `simple` — запретить перезаписывать артефакты.
            * `full` — запретить перезаписывать артефакты, даже если артефакт удален.

            Значение по умолчанию — `disabled`.

        * `version-policy` — политика версий. Поддерживается только для формата реестра `maven`. Доступные политики:

            * `mixed` — сочетание политик `release` и `snapshot` для гибкости.
            * `release` — стабильные версии.
            * `snapshot` — разработка с частыми обновлениями.

            Значение по умолчанию — `mixed`.

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

    Чтобы создать локальный реестр, воспользуйтесь методом REST API [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Create](../../api-ref/grpc/Registry/create.md).

    В поле `type` укажите `LOCAL`.

{% endlist %}