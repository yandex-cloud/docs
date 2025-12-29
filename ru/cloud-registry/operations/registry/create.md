---
title: Создание реестра в {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы сможете создать реестр в {{ cloud-registry-name }}.
---

# Создание реестра

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать реестр.
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
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
                * Аутентифицируйтесь в `Docker Hub` по [токену доступа](https://docs.docker.com/security/for-developers/access-tokens/). Для этого выберите вариант аутентификации `Basic`, укажите имя пользователя и в поле **Идентификатор секрета в Lockbox** выберите секрет {{ lockbox-full-name }}, в ключе `value` которого сохранен токен.
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
      --registry-type <тип_реестра> \
      --properties <cвойства_реестра>
    ```

    Где:
    * `--name` — имя реестра.
    * `--description` — описание реестра.
    * `--registry-kind` — формат реестра. Доступные значения — `maven`, `npm` и `docker`.
    * `--registry-type` — [тип](../../concepts/registry.md#registry-types) реестра. Доступные значения: `local`, `remote` и `virtual`.
    * `--properties` — cвойства реестра. Задаются строкой в формате `name1=value1,name2=value2`. Доступные свойства:
        * для локальных реестров (`local`):
            * `versionPolicy` — политика версий для реестра, формат которого — `maven`. Доступные значения: `mixed`, `release`, `snapshot`. Значение по умолчанию — `mixed`.
        * для удаленных реестров (`remote`):
            * `source` — реестр-источник. Доступные значения определяются форматом реестра. Например, `@maven-central` — для `maven`, `@npmjs` — для `npm`.
            * `authorizationType` — тип авторизации. Доступные значения: `none`, `basic`. Значение по умолчанию — `none`. Доступно только для реестра, формат которого — `docker`.
            * `authorizationSecretId` — идентификатор секрета пользователя, в котором хранится токен или пароль. Требуется, если `authorizationType` — `basic`.  Доступно только для реестра, формат которого — `docker`.
            * `authorizationUsername` — имя пользователя. Требуется, если `authorizationType` — `basic`.  Доступно только для реестра, формат которого — `docker`.
        * для виртуальных реестров (`virtual`):
            * `registryIds` — список идентификаторов локальных и удаленных реестров в порядке их обхода. Указывается в формате `registryIds=registry1;registry2`.
            * `readOnly` — разрешение загрузки артефактов в реестр. Доступные значения: `true` — загрузка запрещена, `false` — загрузка разрешена.
            * `deploymentRegistryId` — идентификатор реестра для загрузки артефактов. Требуется, если `readOnly` — `false`.

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
