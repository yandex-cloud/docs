[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных > Iceberg REST Catalog > Создать пользователя каталога

# Создать пользователя каталога

Пользователь каталога [Iceberg REST Catalog](../../concepts/components/rest-catalog.md) — это учетная запись с доступом по протоколу OAuth2. Создайте пользователя в проекте с уже существующим каталогом.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте файл ресурса `RestCatalogPrincipal`. Например, с помощью команды `touch restcatalogprincipal.yaml`.
  1. Откройте файл и вставьте конфигурацию ниже. Создайте вместе с пользователем секрет с учетными данными OAuth2:

      ```yaml
      apiVersion: restcatalog.stackland.yandex.cloud/v1alpha1
      kind: RestCatalogPrincipal
      metadata:
        name: analytics-service-account    # Имя пользователя каталога; уникально в пределах кластера
      spec:
        catalog: analytics                 # Имя каталога (RestCatalog.metadata.name) в этом же проекте
        principalRoles:                    # Имена групп пользователей из declaredPrincipalRoles каталога
          - analytics-admin
        credentialsSecretRef:
          name: analytics-principal-credentials   # Ссылка на секрет с учетными данными OAuth2
      ---
      apiVersion: v1
      kind: Secret
      metadata:
        name: analytics-principal-credentials
      type: Opaque
      stringData:
        clientId: analytics-service-account       # Совпадает с именем пользователя каталога
        clientSecret: <секрет_клиента>            # Задает администратор
      ```

      Учитывайте требования:

      * параметр `spec.catalog` должен ссылаться на существующий каталог `RestCatalog` в том же проекте;
      * имена в параметре `spec.principalRoles` должны входить в список групп пользователей `spec.declaredPrincipalRoles` этого каталога.

  1. Примените манифест: `kubectl apply -f restcatalogprincipal.yaml -n <название проекта>`. При необходимости можно прописать название проекта в параметр ресурса `metadata.namespace` и не использовать в команде.


- Консоль управления {#console}

  1. Если вы еще не открыли проект, выберите проект.
  1. В левом меню выберите **Iceberg REST Catalog**.
  1. На вкладке **Каталоги** выберите каталог.
  1. Перейдите на вкладку **Пользователи**.
  1. Нажмите **Создать пользователя**.
  1. Заполните поля:

      * **Имя** — имя пользователя каталога. После создания имя не меняется.
      * **Идентификатор клиента** — совпадает с именем пользователя и недоступен для изменения.
      * **Секрет клиента** — задайте секрет OAuth2.
      * **Список ролей** — выберите одну или несколько групп пользователей каталога.

  1. Нажмите **Создать**.

{% endlist %}