[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных и аналитика > Managed Service for Trino > Создать кластер Trino

# Создать кластер Managed Service for Trino

Кластер [Trino](../../concepts/components/trino.md) создается в пространстве имен внутри [проекта](../projects/create-project.md). Если у вас уже есть проект и пространство имен в нем, в этом пространстве имен вы можете создать кластер.

## Через CLI {#cli}

1. Убедитесь, что в проекте создано пространство имен. Если нет, [создайте его](../projects/manage-namespaces.md#create-namespace).
1. Создайте файл ресурса `TrinoCluster`. Например, с помощью команды `touch trinocluster.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    {% list tabs %}

    - Минимальная конфигурация

        ```yaml
        apiVersion: trino.stackland.yandex.cloud/v1alpha1
        kind: TrinoCluster
        metadata:
          name: trino-min
        spec:
          version: "483"
          coordinator:
            resources:
              requests:
                cpu: 500m
                memory: 1Gi
              limits:
                cpu: "1"
                memory: 2Gi
          worker:
            replicas: 1
            resources:
              requests:
                cpu: 500m
                memory: 1Gi
              limits:
                cpu: "1"
                memory: 2Gi
        ```

    - Конфигурация с настройками и правилами доступа

        Пример с настройками логирования (`spec.config`) и правилами доступа к каталогам, схемам и таблицам (`spec.accessControl`). Подробнее о правилах доступа см. в разделе [Управление доступом](../../concepts/components/trino.md#access-control).

        ```yaml
        apiVersion: trino.stackland.yandex.cloud/v1alpha1
        kind: TrinoCluster
        metadata:
          name: trino-full
        spec:
          version: "483"
          deletionProtection: false
          coordinator:
            resources:
              requests:
                cpu: 500m
                memory: 1Gi
              limits:
                cpu: "1"
                memory: 2Gi
          worker:
            replicas: 3
            resources:
              requests:
                cpu: 500m
                memory: 1Gi
              limits:
                cpu: "1"
                memory: 2Gi
          config:
            io.trino: INFO
            io.trino.plugin.iceberg: DEBUG
          accessControl:
            catalogs:
              - user: admin@stackland
                catalog: ".*"
                privileges: all
            schemas:
              - user: analyst@stackland
                catalog: ".*"
                schema: ".*"
                owner: false
            tables:
              - user: analyst@stackland
                catalog: ".*"
                schema: public
                table: ".*"
                privileges:
                  - SELECT
        ```

    {% endlist %}

1. Примените манифест: `kubectl apply -f trinocluster.yaml -n <пространство_имен>`. При необходимости можно прописать пространство имен в параметр ресурса `metadata.namespace` и не использовать его в команде.

## Через консоль управления {#console}

1. Если вы еще не открыли проект, выберите проект.
1. Выберите пространство имен, в котором нужно создать кластер.
1. В левом меню выберите **Trino** → **Кластеры**.
1. Нажмите **Создать кластер**.
1. Заполните поля:

    **Основные параметры**

    * **Имя** — название кластера. Записывается в `metadata.name`.
    * **Версия Trino** — версия Trino. Список значений формируется из `TrinoImageCatalog` оператора.
    * **Защита от удаления** — переключатель защиты от случайного удаления кластера. По умолчанию выключена.

    **Конфигурация координатора**

    * **Запрошенный CPU** — гарантированное количество CPU для пода координатора.
    * **Запрошенная память** — гарантированный объем памяти для пода координатора.
    * **Лимит CPU** — максимальное количество CPU для пода координатора.
    * **Лимит памяти** — максимальный объем памяти для пода координатора.

    **Конфигурация воркеров**

    * **Количество воркеров** — число подов воркеров. Минимум `1`.
    * **Запрошенный CPU** — гарантированное количество CPU для пода воркера.
    * **Запрошенная память** — гарантированный объем памяти для пода воркера.
    * **Лимит CPU** — максимальное количество CPU для пода воркера.
    * **Лимит памяти** — максимальный объем памяти для пода воркера.

    **Дополнительные настройки** (необязательно)

    Раздел для добавления настроек Trino в формате «Ключ–Значение». Каждый ключ можно добавить только один раз.

    **Настройки доступа** (необязательно)

    Раздел для правил доступа к ресурсам Trino. Подсекции:

    * **Правила каталогов** — `user`, `catalog`, `privileges` (`all`, `read-only`, `none`).
    * **Правила схем** — `user`, `catalog`, `schema`, `owner`.
    * **Правила таблиц** — `user`, `catalog`, `schema`, `table`, `privileges` (`SELECT`, `INSERT`, `DELETE`, `UPDATE`, `OWNERSHIP`, `GRANT_SELECT`), а также фильтр строк и ограничения по столбцам.
    * **Правила функций** — `user`, `catalog`, `schema`, `function`, `privileges` (`EXECUTE`, `GRANT_EXECUTE`, `OWNERSHIP`).
    * **Правила процедур** — `user`, `catalog`, `schema`, `procedure`, `privileges` (`EXECUTE`, `GRANT_EXECUTE`).
    * **Правила запросов** — `user`, `queryOwner`, `privileges` (`execute`, `view`, `kill`). Если задан `queryOwner`, привилегия `execute` недоступна.

    В поле «Пользователь» значение можно ввести как регулярное выражение или выбрать из Identity and Access Management. Для сервисного аккаунта укажите имя ресурса `ServiceAccount` в Kubernetes, а не идентификатор субъекта IAM. Если поле сопоставления (например, «Каталог», «Схема» или «Таблица») оставлено пустым, Trino подставляет `.*`.

1. Нажмите **Создать**.

Готово, кластер появился в списке **Кластеры**. После создания статус кластера отображается в колонке **Статус**. Перейдите в карточку кластера, чтобы увидеть подробную информацию.

## Подключение к кластеру {#connect}

После того как кластер перешел в состояние `Running`, к нему можно подключиться по адресу координатора.

### Получение адресов для подключения {#get-connection-addresses}

{% list tabs %}

- CLI

    Выполните команду:

    ```bash
    kubectl get trinocluster <имя_кластера> -n <пространство_имен> -o jsonpath='{.status.fqdn}'
    ```

    Структура ответа:

    * `external` — внешний адрес координатора для подключения через клиенты Trino (CLI, JDBC), полный URL вида `https://...`.
    * `webUI` — адрес Trino UI, полный URL вида `https://...`.

- Консоль управления

    1. Откройте проект.
    1. В левом меню выберите **Trino** → **Кластеры**.
    1. Выберите кластер.
    1. На вкладке **Обзор** найдите адреса для подключения. Чтобы посмотреть подробную информацию о подключении, нажмите **Подключиться**.

{% endlist %}

### Trino CLI {#trino-cli}

Для подключения по внешнему адресу используются TLS и вход в Identity and Access Management через браузер. Для Trino CLI подготовьте хранилище доверенных сертификатов — truststore. Ниже приведены команды для Linux и macOS.

{% note tip %}

Готовые команды для создания truststore и подключения доступны в консоли управления: откройте карточку кластера и нажмите **Подключиться**.

{% endnote %}

#### Вход пользователя IAM {#trino-cli-user}

1. Установите Trino CLI согласно [официальной инструкции](https://trino.io/docs/current/client/cli.html). Для создания truststore понадобится утилита `keytool` из JDK.
1. Получите сертификат удостоверяющего центра (CA) и создайте truststore. Если truststore уже настроен для этого кластера, используйте его при подключении.

    Сохраните сертификат CA из ресурса Secret `<имя_кластера>-trino-ingress-tls` в пространстве имен кластера:

    ```bash
    mkdir -p ~/.trino
    kubectl get secret <имя_кластера>-trino-ingress-tls -n <пространство_имен> \
      -o jsonpath='{.data.ca\.crt}' | base64 -d > ~/.trino/stackland-ca.crt
    ```

    Если у вас нет доступа к Secret, получите сертификат CA у администратора Stackland и сохраните его в `~/.trino/stackland-ca.crt`.

    Импортируйте сертификат в truststore:

    ```bash
    keytool -importcert -trustcacerts -noprompt \
      -alias stackland \
      -file ~/.trino/stackland-ca.crt \
      -keystore ~/.trino/truststore.jks \
      -storetype JKS \
      -storepass stackland
    ```

    В примере пароль truststore — `stackland`; при подключении укажите тот же пароль.

1. Добавьте сертификат CA в доверенные сертификаты ОС для входа через браузер:

    {% list tabs %}

    - Linux (Debian, Ubuntu)

        ```bash
        sudo cp ~/.trino/stackland-ca.crt /usr/local/share/ca-certificates/stackland.crt
        sudo update-ca-certificates
        ```

    - Linux (RHEL, Fedora)

        ```bash
        sudo cp ~/.trino/stackland-ca.crt /etc/pki/ca-trust/source/anchors/stackland.crt
        sudo update-ca-trust
        ```

    - macOS

        ```bash
        sudo security add-trusted-cert -d -r trustRoot \
          -k /Library/Keychains/System.keychain ~/.trino/stackland-ca.crt
        ```

    {% endlist %}

    Если браузер использует собственное хранилище сертификатов, добавьте CA и в него. Перезапустите браузер.

1. Подключитесь к кластеру. В `--server` укажите значение `status.fqdn.external` — полный URL координатора вида `https://...`:

    ```bash
    trino --server https://<FQDN_координатора> \
      --external-authentication \
      --truststore-path ~/.trino/truststore.jks \
      --truststore-password stackland
    ```

    Когда CLI предложит пройти аутентификацию, откройте указанную ссылку в браузере и войдите в Identity and Access Management. Значение `current_user` соответствует логину IAM, который вы использовали при аутентификации OAuth. Параметр `--user` необязателен. При необходимости передайте `--user '<логин_IAM>'` как подсказку для формы входа или для выполнения запросов от имени другого пользователя, если это разрешено правилами в `spec.accessControl`.

1. Для проверки подключения выполните запрос в Trino CLI:

    ```sql
    SELECT current_user, version();
    ```

    В колонке `current_user` должен отображаться IAM-логин, под которым вы вошли.

#### Вход сервисного аккаунта {#trino-cli-service-account}

Для автоматизации и CI подключайтесь с IAM-токеном сервисного аккаунта (`t1.*`) вместо аутентификации OAuth через браузер.

1. Создайте сервисный аккаунт в пространстве имен кластера:

    ```bash
    kubectl create serviceaccount <имя_сервисного_аккаунта> -n <пространство_имен>
    ```

    Дождитесь появления идентификатора сервисного аккаунта IAM в аннотации `iam.stackland.yandex.cloud/service-account-id`.

1. Добавьте правила в `spec.accessControl` кластера. В поле `user` укажите имя ресурса `ServiceAccount` в Kubernetes, а не идентификатор субъекта IAM. Подробнее — в разделе [Управление доступом](../../concepts/components/trino.md#access-control).
1. Получите IAM-токен сервисного аккаунта (формат `t1.*`) через IAM API.
1. Подготовьте truststore (шаги 1–2 раздела [Вход пользователя IAM](#trino-cli-user)). Добавлять CA в доверенные сертификаты ОС для браузерного входа не требуется.
1. Подключитесь к кластеру. В `--server` укажите `status.fqdn.external`:

    ```bash
    trino --server https://<FQDN_координатора> \
      --access-token '<IAM-токен>' \
      --truststore-path ~/.trino/truststore.jks \
      --truststore-password stackland
    ```

1. Проверьте подключение:

    ```sql
    SELECT current_user, version();
    ```

    В `current_user` должно отображаться имя ресурса `ServiceAccount` из `spec.accessControl`.

### JDBC {#jdbc}

Используйте JDBC-драйвер Trino с URL вида:

```
jdbc:trino://<FQDN_координатора>:443
```

Значение `<FQDN_координатора>` получите из `status.fqdn.external` (часть URL без схемы `https://`).