---
title: Создание реестра в {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы сможете создать реестр в {{ cloud-registry-name }}.
---

# Создание реестра

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать реестр.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud.cloud-registry.title_registries }}**.
    1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.cloud-registry.action_registry-create }}**.
    1. Выберите формат реестра.
    1. Настройте формат реестра:

        1. В поле **Тип реестра** выберите нужный [тип](../../concepts/registry.md#registry-types) создаваемого реестра:

            * `Local` — [локальный](../../concepts/registry.md#local-registry) реестр. Тип доступен для всех форматов реестра.
            * `Remote` — [удаленный](../../concepts/registry.md#remote-registry) реестр. Доступен для форматов `Maven`, `Npm` и `Docker`.
            * `Virtual` — [виртуальный](../../concepts/registry.md#virtual-registry) реестр. Доступен для форматов `Maven`, `Npm` и `Docker`.
        1. Если вы выбрали формат реестра `Maven` и тип `Local`, в поле **Политика версий** выберите политику версий:

            * `Release` — стабильные версии;
            * `Snapshot` — разработка с частыми обновлениями;
            * `Mixed` — сочетание политик `Release` и `Snapshot` для гибкости.
        1. Если вы выбрали тип реестра `Remote`, выберите адрес удаленного реестра:

            * Для формата `Maven` доступны репозитории `Maven Central` и `Axiom`.

                {% note info %}

                Репозиторий `Axiom` доступен по запросу. Чтобы активировать доступ к `Axiom`, [создайте]({{ link-console-support }}/tickets/create) обращение в службу технической поддержки.

                {% endnote %}

            * Для формата `Npm` доступен только репозиторий `Npm`.
            * Для формата `Docker` доступен только репозиторий `Docker Hub`. При этом необходимо задать данные для аутентификации в `Docker Hub`:

                * Предоставьте [сервисному агенту](../../../iam/concepts/service-control.md#service-agent) сервиса {{ cloud-registry-name }} доступ к содержимому [секрета](../../../lockbox/concepts/secret.md) {{ lockbox-full-name }}, назначив ему на этот секрет [роль](../../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.

                    В настоящее время такой доступ можно выдать только с помощью команды [{{ yandex-cloud }} CLI](../../../cli/quickstart.md), указав в ней идентификатор секрета {{ lockbox-full-name }}, содержащего токен или пароль, и [идентификатор облака](../../../organization/operations/organization-get-id.md), в котором вы создаете реестр:

                    ```bash
                    yc lockbox secret add-access-binding \
                      --id <идентификатор_секрета> \
                      --role lockbox.payloadViewer \
                      --agent cloud-registry:data-plane \
                      --cloud-id <идентификатор_облака>
                    ```
                * Выберите способ аутентификации в `Docker Hub`:

                    * Чтобы аутентифицироваться по [токену доступа](https://docs.docker.com/security/for-developers/access-tokens/), выберите вариант аутентификации `Bearer` и в поле **Идентификатор секрета в Lockbox** выберите секрет {{ lockbox-full-name }}, в ключе `value` которого сохранен нужный токен.
                    * Чтобы аутентифицироваться по имени пользователя и паролю, выберите вариант аутентификации `Basic`, укажите имя пользователя и в поле **Идентификатор секрета в Lockbox** выберите секрет {{ lockbox-full-name }}, в ключе `value` которого сохранен пароль.
        1. Если вы выбрали тип реестра `Virtual`, в поле **Реестры** с помощью кнопки ![plus](../../../_assets/console-icons/plus.svg) **Добавить реестр** добавьте в виртуальный реестр нужные локальные и/или удаленные реестры, указав их идентификаторы.

            Идентификатор реестра можно посмотреть в консоли управления на странице с информацией о реестре.
    1. Введите имя и описание реестра.
    1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    Чтобы создать реестр, выполните команду:

    ```
    yc cloud-registry registry create \
      --name <имя_реестра> \
      --description <описание_реестра> \
      --registry-kind <формат_реестра> \
      --registry-type <тип_реестра>
    ```

    Где:
    * `--name` — имя реестра.
    * `--description` — описание реестра.
    * `--registry-kind` — формат реестра. Доступные значения — `maven`, `npm` и `docker`.
    * `--registry-type` — [тип](../../concepts/registry.md#registry-types) реестра. Доступные значения: `local`, `remote` и `virtual`.

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
