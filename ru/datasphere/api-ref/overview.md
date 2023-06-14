---
title: "Обзор"
description: "Управление ресурсами Yandex DataSphere с помощью API. Основные методы для создания проекта, загрузки файлов и работы с ноутбуками."
---

# Обзор API {{ ml-platform-name }}

В {{ ml-platform-name }} все основные операции по работе с ресурсами и ноутбуками доступны не только из пользовательского интерфейса, но и через API. 

Для управления ресурсами в [API {{ yandex-cloud }}](https://github.com/yandex-cloud/cloudapi) определены наборы вызовов [gRPC](grpc/index.md) и методов [REST](index.md). Особенности их реализации и взаимодействия см. в [Документации API {{ yandex-cloud }}](../../api-design-guide/concepts/standard-methods.md).

## Работа с сообществом {#community}

Вызовы `CommunityService` и методы `Community` позволяют создать, обновить и удалить сообщество. Также вы можете просмотреть список сообществ в конкретной организации.

| Описание | gRPC | REST |
| --- | --- | --- |
| Создает новое сообщество в указанной организации | [Create](grpc/community_service.md#Create) | [create](Community/create.md) |
| Обновляет сообщество | [Update](grpc/community_service.md#Update) | [update](Community/update.md) |
| Удаляет сообщество | [Delete](grpc/community_service.md#Delete) | [delete](Community/delete.md) |
| Возвращает информацию о сообществе | [Get](grpc/community_service.md#Get) | [get](Community/get.md) |
| Возвращает список сообществ в указанной организации | [List](grpc/community_service.md#List) | [list](Community/list.md) |

{% list tabs %}

- gRPC

  **Пример**. Создание нового сообщества:

    ```bash
    grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"organization_id": "<идентификатор_организации>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v2.CommunityService/Create
    ```

  **Пример**. Вывод списка сообществ в организации:

    ```bash
    grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"organization_id": "<идентификатор_организации>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v2.CommunityService/List
    ```

  Подробную информацию о вызовах `CommunityService` см. в [API-документации](grpc/community_service.md).

- REST

  **Пример**. Создание нового сообщества:

    ```bash
    curl -H "Authorization: Bearer <IAM-токен>" \
      -X POST "https://datasphere.api.cloud.yandex.net/datasphere/v2/communities" \
      -d '{ "organizationId": "<идентификатор_организации>" }'
    ```

  **Пример**. Вывод списка сообществ в организации:

    ```bash
    curl -H "Authorization: Bearer <IAM-токен>" \
      -X GET "https://datasphere.api.cloud.yandex.net/datasphere/v2/communities" \
      -d '{ "organizationId": "<идентификатор_организации>" }'
    ```

  Подробную информацию о методах `Community` см. в [API-документации](Community/index.md).

{% endlist %}

## Работа с проектом {#project}

Вызовы `ProjectService` и методы `Project` позволяют создать, открыть, обновить и удалить проект. Также вы можете просмотреть список проектов в конкретном сообществе.

| Описание | gRPC | REST |
| --- | --- | --- |
| Создает новый проект в указанном сообществе | [Create](grpc/project_service.md#Create) | [create](Project/create.md) |
| Обновляет проект | [Update](grpc/project_service.md#Update) | [update](Project/update.md) |
| Удаляет проект | [Delete](grpc/project_service.md#Delete) | [delete](Project/delete.md) |
| Открывает проект | [Open](grpc/project_service.md#Open) | [open](Project/open.md) |
| Возвращает информацию о проекте | [Get](grpc/project_service.md#Get) | [get](Project/get.md) |
| Возвращает список проектов в указанном сообществе | [List](grpc/project_service.md#List) | [list](Project/list.md) |

{% list tabs %}

- gRPC

  **Пример**. Создание нового проекта:

    ```bash
    grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"community_id": "<идентификатор_сообщества>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v2.ProjectService/Create
    ```

  **Пример**. Вывод списка проектов в каталоге:

    ```bash
    grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"community_id": "<идентификатор_сообщества>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v2.ProjectService/List
    ```

  Подробную информацию о вызовах `ProjectService` см. в [API-документации](grpc/project_service.md).

- REST

  **Пример**. Создание нового проекта:

    ```bash
    curl -H "Authorization: Bearer <IAM-токен>" \
      -X POST "https://datasphere.api.cloud.yandex.net/datasphere/v2/projects" \
      -d '{ "communityId": "<идентификатор_сообщества>" }'
    ```

  **Пример**. Вывод списка проектов в каталоге:

    ```bash
    curl -H "Authorization: Bearer <IAM-токен>" \
      -X GET "https://datasphere.api.cloud.yandex.net/datasphere/v2/projects" \
      -d '{ "communityId": "<идентификатор_сообщества>" }'
    ```

  Подробную информацию о методах `Project` см. в [API-документации](Project/index.md).

{% endlist %}

## Работа с ноутбуком {#notebook}

Вызовы `ProjectService` и методы `Project` позволяют запустить ноутбук или конкретную ячейку, получить результаты выполнения определённой ячейки, получить значения переменных состояния ноутбука или метаданные.

| Описание | gRPC | REST |
| --- | --- | --- |
| Запускает заданную ячейку или ноутбук | [Execute](grpc/project_service.md#Execute) | [execute](Project/execute.md) |
| Возвращает значение переменных состояния ноутбука | [GetStateVariables](grpc/project_service.md#GetStateVariables) | [getStateVariables](Project/getStateVariables.md) |

{% list tabs %}

- gRPC

  **Пример**. Запуск конкретной ячейки ноутбука:

    ```bash
    grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"project_id": "<идентификатор_проекта>", "target": "cell_id", "cell_id": "<идентификатор_ячейки>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v2.ProjectService/Execute
    ```

  Подробную информацию о вызовах `ProjectService` см. в [API-документации](grpc/project_service.md).

- REST

  **Пример**. Запуск конкретной ячейки ноутбука:

    ```bash
    curl -H "Authorization: Bearer <IAM-токен>" \
      -X POST "https://datasphere.api.cloud.yandex.net/datasphere/v2/projects/<идентификатор_проекта>:execute" \
      -d '{ "cellId": "<идентификатор_ячейки>" }'
    ```

  Подробную информацию о методах `Project` см. в [API-документации](Project/index.md).

{% endlist %}

## Управление доступами {#access}

С помощью API вы можете настраивать доступ к проекту (`ProjectService`, `Project`) или сообществу (`CommunityService`, `Community`).

| Описание | gRPC | REST |
| --- | --- | --- |
| Возвращает список доступов к проекту | [ListAccessBindings](grpc/project_service.md#ListAccessBindings) | [listAccessBindings](Project/listAccessBindings.md) |
| Устанавливает доступ к проекту | [SetAccessBindings](grpc/project_service.md#SetAccessBindings) | [setAccessBindings](Project/setAccessBindings.md) |
| Обновляет доступ к проекту | [UpdateAccessBindings](grpc/project_service.md#UpdateAccessBindings) | [updateAccessBindings](Project/updateAccessBindings.md) |
| Возвращает список доступов к сообществу | [ListAccessBindings](grpc/community_service.md#ListAccessBindings) | [listAccessBindings](Community/listAccessBindings.md) |
| Устанавливает доступ к сообществу | [SetAccessBindings](grpc/community_service.md#SetAccessBindings) | [setAccessBindings](Community/setAccessBindings.md) |
| Обновляет доступ к сообществу | [UpdateAccessBindings](grpc/community_service.md#UpdateAccessBindings) | [updateAccessBindings](Community/updateAccessBindings.md) |

{% list tabs %}

- gRPC

  **Пример**. Вывод списка доступов к проекту:

    ```bash
    grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"resource_id": "<идентификатор_проекта>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v2.ProjectService/ListAccessBindings
    ```

  **Пример**. Вывод списка доступов к сообществу:

    ```bash
    grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"resource_id": "<идентификатор_сообщества>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v2.CommunityService/ListAccessBindings
    ```

  Подробную информацию о методах см. в API-документации [ProjectService](grpc/project_service.md) и [CommunityService](grpc/community_service.md).

- REST

  **Пример**. Вывод списка доуступов к проекту:

    ```bash
    curl -H "Authorization: Bearer <IAM-токен>" \
      -X GET "https://datasphere.api.cloud.yandex.net/datasphere/v2/projects/<идентификатор_ресурса>:accessBindings"
    ```

  **Пример**. Вывод списка доступов к сообществу:

    ```bash
    curl -H "Authorization: Bearer <IAM-токен>" \
      -X GET "https://datasphere.api.cloud.yandex.net/datasphere/v2/communities/<идентификатор_ресурса>:accessBindings"
    ```

  Подробную информацию о методах см. в API-документации [Project](Project/index.md) и [Community](Community/index.md).

{% endlist %}

## Управление ограничениями вычислений {#limits}

С помощью API вы можете настраивать ограничения вычислений для проекта (`ProjectService`, `Project`).

| Описание | gRPC | REST |
| --- | --- | --- |
| Возвращает баланс проекта | [GetUnitBalance](grpc/project_service.md#GetUnitBalance) | [getUnitBalance](Project/getUnitBalance.md) |
| Устанавливает баланс проекта | [SetUnitBalance](grpc/project_service.md#SetUnitBalance) | [setUnitBalance](Project/setUnitBalance.md) |

{% list tabs %}

- gRPC

  **Пример**. Получение баланса проекта:

    ```bash
    grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"project_id": "<идентификатор_проекта>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v2.ProjectService/GetUnitBalance
    ```

  Подробную информацию о вызовах `ProjectService` см. в [API-документации](grpc/project_service.md).

- REST

  **Пример**. Получение баланса проекта:

    ```bash
    curl -H "Authorization: Bearer <IAM-токен>" \
      -X GET "https://datasphere.api.cloud.yandex.net/datasphere/v2/projects/<идентификатор_проекта>:unitBalance"
    ```

  Подробную информацию о методах `Project` см. в [API-документации](Project/index.md).

{% endlist %}