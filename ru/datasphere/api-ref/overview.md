---
title: Обзор API {{ ml-platform-name }}
description: Управление ресурсами {{ ml-platform-full-name }} с помощью API. Основные методы для создания проекта, загрузки файлов и работы с ноутбуками.
---

# Обзор API {{ ml-platform-name }}

В {{ ml-platform-name }} все основные операции по работе с ресурсами и ноутбуками доступны не только из пользовательского интерфейса, но и через API.

Для управления ресурсами в [API {{ yandex-cloud }}](https://github.com/yandex-cloud/cloudapi) определены наборы вызовов [gRPC](grpc/index.md) и методов [REST](index.md). Особенности их реализации и взаимодействия см. в [Документации API {{ yandex-cloud }}](../../api-design-guide/concepts/standard-methods.md).

## Работа с сообществом {#community}

Вызовы `CommunityService` и методы `Community` позволяют создать, обновить и удалить сообщество. Также вы можете просмотреть список сообществ в конкретной организации.

| Описание | gRPC | REST |
| --- | --- | --- |
| Создает новое сообщество в указанной организации | [Create](grpc/Community/create.md) | [create](Community/create.md) |
| Обновляет сообщество | [Update](grpc/Community/update.md) | [update](Community/update.md) |
| Удаляет сообщество | [Delete](grpc/Community/delete.md) | [delete](Community/delete.md) |
| Возвращает информацию о сообществе | [Get](grpc/Community/get.md) | [get](Community/get.md) |
| Возвращает список сообществ в указанной организации | [List](grpc/Community/list.md) | [list](Community/list.md) |

{% list tabs group=api_type %}

- gRPC {#grpc-api}

  **Пример**. Создание нового сообщества:

    ```bash
    grpcurl \
      -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"organization_id": "<идентификатор_организации>"}' \
      datasphere.{{ api-host }}:443 \
      yandex.cloud.datasphere.v2.CommunityService/Create
    ```

  **Пример**. Вывод списка сообществ в организации:

    ```bash
    grpcurl \
      -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"organization_id": "<идентификатор_организации>"}' \
      datasphere.{{ api-host }}:443 \
      yandex.cloud.datasphere.v2.CommunityService/List
    ```

  Подробную информацию о вызовах `CommunityService` см. в [API-документации](grpc/Community/index.md).

- REST {#rest-api}

  **Пример**. Создание нового сообщества:

    ```bash
    curl \
      --header "Authorization: Bearer <IAM-токен>" \
      --request POST \
      "https://datasphere.{{ api-host }}/datasphere/v2/communities" \
      --data '{ "organizationId": "<идентификатор_организации>" }'
    ```

  **Пример**. Вывод списка сообществ в организации:

    ```bash
    curl \
      --header "Authorization: Bearer <IAM-токен>" \
      --request GET \
      "https://datasphere.{{ api-host }}/datasphere/v2/communities" \
      --data '{ "organizationId": "<идентификатор_организации>" }'
    ```

  Подробную информацию о методах `Community` см. в [API-документации](Community/index.md).

{% endlist %}

## Работа с проектом {#project}

Вызовы `ProjectService` и методы `Project` позволяют создать, открыть, обновить и удалить проект. Также вы можете просмотреть список проектов в конкретном сообществе.

| Описание | gRPC | REST |
| --- | --- | --- |
| Создает новый проект в указанном сообществе | [Create](grpc/Project/create.md) | [create](Project/create.md) |
| Обновляет проект | [Update](grpc/Project/update.md) | [update](Project/update.md) |
| Удаляет проект | [Delete](grpc/Project/delete.md) | [delete](Project/delete.md) |
| Открывает проект | [Open](grpc/Project/open.md) | [open](Project/open.md) |
| Возвращает информацию о проекте | [Get](grpc/Project/get.md) | [get](Project/get.md) |
| Возвращает список проектов в указанном сообществе | [List](grpc/Project/list.md) | [list](Project/list.md) |

{% list tabs group=api_type %}

- gRPC {#grpc-api}

  **Пример**. Создание нового проекта:

    ```bash
    grpcurl \
      -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"community_id": "<идентификатор_сообщества>"}' \
      datasphere.{{ api-host }}:443 \
      yandex.cloud.datasphere.v2.ProjectService/Create
    ```

  **Пример**. Вывод списка проектов в каталоге:

    ```bash
    grpcurl \
      -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"community_id": "<идентификатор_сообщества>"}' \
      datasphere.{{ api-host }}:443 \
      yandex.cloud.datasphere.v2.ProjectService/List
    ```

  Подробную информацию о вызовах `ProjectService` см. в [API-документации](grpc/Project/index.md).

- REST {#rest-api}

  **Пример**. Создание нового проекта:

    ```bash
    curl \
      --header "Authorization: Bearer <IAM-токен>" \
      --request POST \
      "https://datasphere.{{ api-host }}/datasphere/v2/projects" \
      --data '{ "communityId": "<идентификатор_сообщества>" }'
    ```

  **Пример**. Вывод списка проектов в сообществе:

    ```bash
    curl \
      --header "Authorization: Bearer <IAM-токен>" \
      --request GET \
      "https://datasphere.{{ api-host }}/datasphere/v2/projects" \
      --data '{ "communityId": "<идентификатор_сообщества>" }'
    ```

  Подробную информацию о методах `Project` см. в [API-документации](Project/index.md).

{% endlist %}

## Работа с ноутбуком {#notebook}

Вызов `Execute` и метод `execute` сервиса `ProjectService` позволяют запустить ноутбук для исполнения.

| Описание | gRPC | REST |
| --- | --- | --- |
| Запускает заданный ноутбук | [Execute](grpc/Project/execute.md) | [execute](Project/execute.md) |


{% list tabs group=api_type %}

- gRPC {#grpc-api}

  **Пример**. Запуск всего ноутбука:

    ```bash
    grpcurl \
      -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"project_id": "<идентификатор_проекта>", "target": "notebook_id", "notebook_id": "<идентификатор_ноутбука>"}' \
      datasphere.{{ api-host }}:443 \
      yandex.cloud.datasphere.v2.ProjectService/Execute
    ```

  Чтобы получить идентификатор ноутбука, воспользуйтесь инструкцией [{#T}](../operations/projects/get-notebook-cell-ids.md).

  Подробную информацию о вызовах `ProjectService` см. в [API-документации](grpc/Project/index.md).

- REST {#rest-api}

  **Пример**. Запуск всего ноутбука:

    ```bash
    curl \
      --header "Authorization: Bearer <IAM-токен>" \
      --request POST \
      "https://datasphere.{{ api-host }}/datasphere/v2/projects/<идентификатор_проекта>:execute" \
      --data '{ "notebook_id": "<идентификатор_ноутбука>" }'
    ```

  Чтобы получить идентификатор ноутбука, воспользуйтесь инструкцией [{#T}](../operations/projects/get-notebook-cell-ids.md).

  Подробную информацию о методах `Project` см. в [API-документации](Project/index.md).

{% endlist %}

## Работа с ресурсами {#resources}

### Активация и деактивация ресурсов {#activate-deactivate}

В {{ ml-platform-name }} для каждого ресурса реализована своя группа методов API. С помощью вызовов методов `Activate` и `Deactivate` соответствующей группы в проекте  можно активировать и деактивировать необходимые ресурсы.

| Описание | gRPC | REST |
| --- | --- | --- |
| Активирует датасет | [Activate](grpc/Dataset/activate.md) | [activate](Dataset/activate.md) |
| Деактивирует датасет | [Deactivate](grpc/Dataset/deactivate.md) | [deactivate](Dataset/deactivate.md) |
| Активирует коннектор S3 | [Activate](grpc/S3/activate.md) | [activate](S3/activate.md) |
| Деактивирует коннектор S3 | [Deactivate](grpc/S3/deactivate.md) | [deactivate](S3/deactivate.md) |
| Активирует Docker-образ | [Activate](grpc/DockerImage/activate.md) | [activate](DockerImage/activate.md) |

{% list tabs group=api_type %}

- gRPC {#grpc-api}

  **Пример**. Активация датасета:

    ```bash
    grpcurl \
      -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d "{\"project_id\": \"<идентификатор_проекта>\", \"dataset_id\": \"<идентификатор_датасета>\"}" \
      datasphere.{{ api-host }}:443 \
      yandex.cloud.datasphere.v2.DatasetService/Activate
    ```

  **Пример**. Деактивация датасета:

    ```bash
    grpcurl \
      -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d "{\"project_id\": \"<идентификатор_проекта>\", \"dataset_id\": \"<идентификатор_датасета>\"}" \
      datasphere.{{ api-host }}:443 \
      yandex.cloud.datasphere.v2.DatasetService/Deactivate
    ```

  Подробную информацию о вызовах `DatasetService` см. в [API-документации](grpc/Dataset/index.md).

- REST {#rest-api}

  **Пример**. Активация датасета:

    ```bash
    curl \
      --header "Authorization: Bearer <IAM-токен>" \
      --request POST \
      "https://datasphere.{{ api-host }}/datasphere/v2/dataset/activate" \
      --data "{ \"datasetId\": \"<идентификатор_датасета>\", \"projectId\": \"<идентификатор_проекта>\" }"
    ```

  **Пример**. Деактивация датасета:

    ```bash
    curl \
      --header "Authorization: Bearer <IAM-токен>" \
      --request POST \
      "https://datasphere.{{ api-host }}/datasphere/v2/dataset/deactivate" \
      --data "{ \"datasetId\": \"<идентификатор_датасета>\", \"projectId\": \"<идентификатор_проекта>\" }"
    ```

  Подробную информацию о методах `Dataset` см. в [API-документации](Dataset/index.md).

{% endlist %}

### Добавление и удаление ресурсов {#add-remove}

С помощью API вы можете добавлять и удалять ресурсы в проект (`ProjectService`, `Project`) или сообществ (`CommunityService`, `Community`).

Чтобы в своем проекте использовать ресурсы другого проекта, нужно [поделиться](../operations/index.md#share) ресурсом в сообществе и добавить его в свой проект.

| Описание | gRPC | REST |
| --- | --- | --- |
| Добавляет ресурс в сообщество | [AddResource](grpc/Community/addResource.md) | [addResource](Community/addResource.md) |
| Удаляет ресурс из сообщества | [RemoveResource](grpc/Community/removeResource.md) | [removeResource](Community/removeResource.md) |
| Добавляет ресурс в проект | [AddResource](grpc/Project/addResource.md) | [addResource](Project/addResource.md) |
| Удаляет ресурс из проекта | [RemoveResource](grpc/Project/removeResource.md) | [removeResource](Project/removeResource.md) |

{% list tabs group=api_type %}

- gRPC {#grpc-api}

  **Пример**. Добавление ресурса в проект:

    ```bash
    grpcurl \
      -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d "{\"project_id\": \"<идентификатор_проекта>\", \"resource_id\": \"<идентификатор_ресурса>\"}" \
      datasphere.{{ api-host }}:443 \
      yandex.cloud.datasphere.v2.ProjectService/AddResource
    ```

  **Пример**. Удаление ресурса из проекта:

    ```bash
    grpcurl \
      -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d "{\"project_id\": \"<идентификатор_проекта>\", \"resource_id\": \"<идентификатор_ресурса>\"}" \
      datasphere.{{ api-host }}:443 \
      yandex.cloud.datasphere.v2.ProjectService/RemoveResource
    ```

  Подробную информацию о вызовах `ProjectService` см. в [API-документации](grpc/Project/index.md).

- REST {#rest-api}

  **Пример**. Добавление ресурса в проект:

    ```bash
    curl \
      --header "Authorization: Bearer <IAM-токен>" \
      --request POST \
      "https://datasphere.{{ api-host }}/datasphere/v2/projects/<идентификатор_ресурса>:addResource" \
      --data "{ \"projectId\": \"<идентификатор_проекта>\" }"
    ```

  **Пример**. Удаление ресурса из проекта:

    ```bash
    curl \
      --header "Authorization: Bearer <IAM-токен>" \
      --request POST \
      "https://datasphere.{{ api-host }}/datasphere/v2/projects/<идентификатор_ресурса>:removeResource" \
      --data "{ \"projectId\": \"<идентификатор_проекта>\" }"
    ```

  Подробную информацию о методах `Project` см. в [API-документации](Project/index.md).

{% endlist %}

## Управление доступами {#access}

С помощью API вы можете настраивать доступ к проекту (`ProjectService`, `Project`) или сообществу (`CommunityService`, `Community`).

| Описание | gRPC | REST |
| --- | --- | --- |
| Возвращает список доступов к проекту | [ListAccessBindings](grpc/Project/listAccessBindings.md) | [listAccessBindings](Project/listAccessBindings.md) |
| Устанавливает доступ к проекту | [SetAccessBindings](grpc/Project/setAccessBindings.md) | [setAccessBindings](Project/setAccessBindings.md) |
| Обновляет доступ к проекту | [UpdateAccessBindings](grpc/Project/updateAccessBindings.md) | [updateAccessBindings](Project/updateAccessBindings.md) |
| Возвращает список доступов к сообществу | [ListAccessBindings](grpc/Community/listAccessBindings.md) | [listAccessBindings](Community/listAccessBindings.md) |
| Устанавливает доступ к сообществу | [SetAccessBindings](grpc/Community/setAccessBindings.md) | [setAccessBindings](Community/setAccessBindings.md) |
| Обновляет доступ к сообществу | [UpdateAccessBindings](grpc/Community/updateAccessBindings.md) | [updateAccessBindings](Community/updateAccessBindings.md) |

{% list tabs group=api_type %}

- gRPC {#grpc-api}

  **Пример**. Вывод списка доступов к проекту:

    ```bash
    grpcurl \
      -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"resource_id": "<идентификатор_проекта>"}' \
      datasphere.{{ api-host }}:443 \
      yandex.cloud.datasphere.v2.ProjectService/ListAccessBindings
    ```

  **Пример**. Вывод списка доступов к сообществу:

    ```bash
    grpcurl \
      -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"resource_id": "<идентификатор_сообщества>"}' \
      datasphere.{{ api-host }}:443 \
      yandex.cloud.datasphere.v2.CommunityService/ListAccessBindings
    ```

  Подробную информацию о методах см. в API-документации [ProjectService](grpc/Project/index.md) и [CommunityService](grpc/Community/index.md).

- REST {#rest-api}

  **Пример**. Вывод списка доступов к проекту:

    ```bash
    curl \
      --header "Authorization: Bearer <IAM-токен>" \
      --request GET \
      "https://datasphere.{{ api-host }}/datasphere/v2/projects/<идентификатор_ресурса>:accessBindings"
    ```

  **Пример**. Вывод списка доступов к сообществу:

    ```bash
    curl \
      --header "Authorization: Bearer <IAM-токен>" \
      --request GET \
      "https://datasphere.{{ api-host }}/datasphere/v2/communities/<идентификатор_ресурса>:accessBindings"
    ```

  Подробную информацию о методах см. в API-документации [Project](Project/index.md) и [Community](Community/index.md).

{% endlist %}

## Управление ограничениями вычислений {#limits}

С помощью API вы можете настраивать ограничения вычислений для проекта (`ProjectService`, `Project`).

| Описание | gRPC | REST |
| --- | --- | --- |
| Возвращает баланс проекта | [GetUnitBalance](grpc/Project/getUnitBalance.md) | [getUnitBalance](Project/getUnitBalance.md) |
| Устанавливает баланс проекта | [SetUnitBalance](grpc/Project/setUnitBalance.md) | [setUnitBalance](Project/setUnitBalance.md) |

{% list tabs group=api_type %}

- gRPC {#grpc-api}

  **Пример**. Получение баланса проекта:

    ```bash
    grpcurl \
      -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"project_id": "<идентификатор_проекта>"}' \
      datasphere.{{ api-host }}:443 \
      yandex.cloud.datasphere.v2.ProjectService/GetUnitBalance
    ```

  Подробную информацию о вызовах `ProjectService` см. в [API-документации](grpc/Project/index.md).

- REST {#rest-api}

  **Пример**. Получение баланса проекта:

    ```bash
    curl \
      --header "Authorization: Bearer <IAM-токен>" \
      --request GET \
      "https://datasphere.{{ api-host }}/datasphere/v2/projects/<идентификатор_проекта>:unitBalance"
    ```

  Подробную информацию о методах `Project` см. в [API-документации](Project/index.md).

{% endlist %}
