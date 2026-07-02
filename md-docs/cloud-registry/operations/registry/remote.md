[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Управление реестром > Создание реестра > Удаленный

# Создать удаленный реестр

{% note info %}

Удаленный реестр можно создать любого формата, кроме Binary.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать удаленный реестр.
    1. Перейдите в сервис **Cloud Registry**.
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Реестры**.
    1. В правом верхнем углу нажмите кнопку **Создать реестр**.
    1. Выберите формат реестра.
    1. В поле **Тип реестра** выберите `Remote`.
    1. Выберите тип источника:

        * `Public` — публичный источник.

            Формат реестра | Адреса публичных источников
            --- | ---
            Maven | `Maven Central`<br/>`Gradle Plugin Portal`<br/>`Axiom`
            Npm | `Npm`
            Docker | `Docker Hub`
            NuGet| `NuGet`
            PyPI | `PyPI`<br/>`PyPI Test`


            {% note info %}

            Публичный источник `Axiom` доступен по запросу. Чтобы активировать доступ к `Axiom`, [создайте](https://center.yandex.cloud/support/tickets/create) обращение в службу технической поддержки.

            {% endnote %}


        * `Custom` — [пользовательский](../../concepts/registry.md#custom-registry) источник.

            Укажите свой адрес пользовательского источника.

    1. Выберите тип авторизации:

        {% note info %}

        Авторизация доступна для пользовательских источников и публичного источника `Docker Hub`. Для публичного источника `Docker Hub` доступен только тип авторизации `Basic`.

        {% endnote %}

        * `None` — без авторизации.

        * `Basic` — авторизация по имени пользователя и паролю.

        * `Bearer` — авторизация по Bearer-токену.

    1. Если вы выбрали тип авторизации `Basic` или `Bearer`:

        1. [Создайте](../../../lockbox/operations/secret-create.md) секрет Yandex Lockbox. В поле **Ключ** укажите `value`, в поле **Значение** укажите:

            * пароль, если тип авторизации — `Basic`.
            * Bearer-токен, если тип авторизации — `Bearer`.

        1. Предоставьте [сервисному агенту](../../../iam/concepts/service-control.md#service-agent) сервиса Cloud Registry доступ к содержимому секрета, назначив ему на этот секрет [роль](../../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.

            В настоящее время такой доступ можно выдать только с помощью команды [Yandex Cloud CLI](../../../cli/quickstart.md), указав в ней идентификатор секрета Yandex Lockbox, содержащего пароль или Bearer-токен, и [идентификатор облака](../../../organization/operations/organization-get-id.md), в котором вы создаете реестр:

            ```bash
            yc lockbox secret add-access-binding \
              --id <идентификатор_секрета> \
              --role lockbox.payloadViewer \
              --agent cloud-registry:data-plane \
              --cloud-id <идентификатор_облака>
            ```

        1. В настройках реестра укажите имя пользователя (если тип авторизации — `Basic`) и идентификатор созданного секрета Yandex Lockbox.

    1. Введите имя и описание реестра.
    1. Добавьте метки в формате `ключ: значение`.
    1. Нажмите **Создать**.

- CLI {#cli}

    Чтобы создать удаленный реестр, выполните команду:

    ```
    yc cloud-registry registry create \
      --name <имя_реестра> \
      --description <описание_реестра> \
      --registry-kind <формат реестра> \
      --registry-type remote \
      --properties <cвойства_реестра>
    ```

    Где:
    * `--name` — имя реестра.
    * `--description` — описание реестра.
    * `--registry-kind` — формат реестра. Доступные форматы: `maven`, `npm`, `docker`, `nuget`, `pypi`.
    * `--registry-type` — [тип](../../concepts/registry.md#registry-types) реестра.
    * `--properties` — свойства реестра. Задаются строкой в формате `name1=value1,name2=value2`. Доступные свойства для удаленных реестров:

        * `source` — реестр-источник. Можно указать публичный источник или [пользовательский](../../concepts/registry.md#custom-registry). Доступные публичные источники:

            Формат реестра | Адреса публичных источников
            --- | ---
            `maven` | `@maven-central`<br/>`@gradle-plugin-portal`<br/>`@axiom`
            `npm` | `@npmjs`
            `docker` | `@docker-hub`
            `nuget` | `@nuget`
            `pypi` | `@pypi`<br/>`@pypi-test`

            {% note info %}

            Публичный источник `@axiom` доступен по запросу. Чтобы активировать доступ к `@axiom`, [создайте](https://center.yandex.cloud/support/tickets/create) обращение в службу технической поддержки.

            {% endnote %}

        * `authorizationType` — тип авторизации. Доступные типы авторизации: `none`, `basic`, `bearer`. Значение по умолчанию — `none`.

            {% note info %}

            Авторизация доступна для пользовательских источников и публичного источника `@docker-hub`. Для публичного источника `@docker-hub` доступен только тип авторизации `basic`.

            {% endnote %}

            Если вы указали `authorizationType` — `basic` или `bearer`:

            1. [Создайте](../../../lockbox/operations/secret-create.md) секрет Yandex Lockbox. В параметре `key` укажите `value`, в качестве значения ключа укажите:

                * пароль, если `authorizationType` — `basic`.
                * Bearer-токен, если `authorizationType` — `bearer`.

            1. Предоставьте [сервисному агенту](../../../iam/concepts/service-control.md#service-agent) сервиса Cloud Registry доступ к содержимому секрета, назначив ему на этот секрет [роль](../../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.

                Выполните команду, указав в ней идентификатор секрета Yandex Lockbox, содержащего пароль или Bearer-токен, и [идентификатор облака](../../../organization/operations/organization-get-id.md), в котором вы создаете реестр:

                ```bash
                yc lockbox secret add-access-binding \
                  --id <идентификатор_секрета> \
                  --role lockbox.payloadViewer \
                  --agent cloud-registry:data-plane \
                  --cloud-id <идентификатор_облака>
                ```

        * `authorizationSecretId` — идентификатор секрета пользователя, в котором хранится пароль или Bearer-токен. Требуется, если `authorizationType` — `basic` или `bearer`.
        * `authorizationUsername` — имя пользователя. Требуется, если `authorizationType` — `basic`.

    Результат:

    ```
    done (3s)
    id: cn1fsnc2dak********
    folder_id: b1gc1t4cb638********
    name: my-first-registry
    kind: DOCKER
    type: REMOTE
    status: ACTIVE
    description: docker
    created_at: "2024-11-30T16:11:12.901356Z"
    modified_at: "2024-11-30T16:11:16.243323Z"
    ```

- API {#api}

    Чтобы создать удаленный реестр, воспользуйтесь методом REST API [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Create](../../api-ref/grpc/Registry/create.md).

    В поле `type` укажите `REMOTE`.

{% endlist %}