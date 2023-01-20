---
title: "Обзор"
description: "Управление ресурсами Yandex DataSphere с помощью API. Основные методы для создания проекта, загрузки 
файлов и работы с ноутбуками."
---

# Обзор API {{ ml-platform-name }}

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

В {{ ml-platform-name }} все основные операции по работе с ресурсами и ноутбуками доступны не только из пользовательского интерфейса, но и через API. 

Для управления ресурсами в [API {{ yandex-cloud }}](https://github.com/yandex-cloud/cloudapi) определены наборы методов [gRPC](grpc/index.md) и [REST](rest/index.md). Особенности их реализации и взаимодействия см. в [Документации API {{ yandex-cloud }}](../../api-design-guide/concepts/standard-methods.md).

## Работа с проектом {#project}

Методы `ProjectService` позволяют создать, открыть, обновить и удалить проект. Также вы можете просмотреть список проектов в конкретном каталоге.

Метод | Описание                                   
------------ |--------------------------------------------
[Create](grpc/project_service#Create) | Создает новый проект в указанном каталоге. 
[Update](grpc/project_service#Update) | Обновляет проект.                          
[Delete](grpc/project_service#Delete) | Удаляет проект.                            
[Open](grpc/project_service#Open) | Открывает проект.                          
[Get](grpc/project_service#Get) | Возвращает информацию о проекте.
[List](grpc/project_service#List) | Возвращает список проектов в указанном каталоге.

**Пример**. Создание нового проекта:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"folder_id": "<folder_id>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v1.ProjectService/Create
  ```

**Пример**. Вывод списка проектов в каталоге:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"folder_id": "<folder_id>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v1.ProjectService/List
  ```

Подробную информацию о методах `ProjectService` см. в [API-документации](grpc/project_service.md).

## Работа с данными проекта {#data}

Методы `ProjectDataService` позволяют загружать файлы из проекта и в проект.

Метод | Описание
------------ |--------------------------------------------
[UploadFile](grpc/project_data_service#UploadFile) | Загружает файл в указанный проект.
[DownloadFile](grpc/project_data_service#DownloadFile) | Загружает файл из указанный проекта.

**Пример**. Загрузка файла из проекта:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"project_id": "<project_id>", "file_path": "<file_path>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v1.ProjectDataService/DownloadFile
  ```
Подробную информацию о методах `ProjectDataService` см. в [API-документации](grpc/project_data_service.md).

## Работа с ноутбуком {#notebook}

Методы `ProjectService` позволяют запустить ноутбук или конкретную ячейку, получить результаты выполнения определённой ячейки, получить значения переменных состояния ноутбука или метаданные.

Метод | Описание
------------ |--------------------------------------------
[Execute](grpc/project_service#Execute) | Запускает заданную ячейку или ноутбук.
[GetCellOutputs](grpc/project_service#GetCellOutputs) | Возвращает результаты выполнения ячейки.
[GetStateVariables](grpc/project_service#GetStateVariables) | Возвращает значение переменных состояния ноутбука.
[GetNotebookMetadata](grpc/project_service#GetNotebookMetadata) | Возвращает информацию о метаданных ноутбука.

**Пример**. Запуск конкретной ячейки ноутбука:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"project_id": "<project_id>", "target": "cell_id", "cell_id": "<cell_id>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v1.ProjectService/Execute
  ```

**Пример**. Вывод результатов выполнения конкретной ячейки ноутбука:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"project_id": "<project_id>", "cell_id": "<cell_id>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v1.ProjectService/GetCellOutputs
  ```

Подробную информацию о методах `ProjectService` см. в [API-документации](grpc/project_service.md).

## Управление ограничениями вычислений {#limits}

С помощью API-методов вы можете настраивать ограничения вычислений для проекта (`ProjectService`) или каталога (`FolderBudgetService`).

Метод | Описание
------------ |--------------------------------------------
[GetUnitBalance](grpc/project_service#GetUnitBalance) | Возвращает баланс проекта.
[SetUnitBalance](grpc/project_service#SetUnitBalance) | Устанавливает баланс проекта.
[Get](grpc/folder_budget_service#Get) | Возвращает баланс каталога.
[Set](grpc/folder_budget_service#Set) | Устанавливает баланс каталога.

**Пример**. Получение баланса проекта:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"project_id": "<project_id>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v1.ProjectService/GetUnitBalance
  ```      

**Пример**. Получение баланса каталога:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
      -d '{"folder_id": "<folder_id>"}' \
      datasphere.api.cloud.yandex.net:443 \
      yandex.cloud.datasphere.v1.FolderBudgetService/Get
  ```  

Больше примеров см. в пошаговых инструкциях:

* [Настроить ограничения вычислений для проекта](../operations/projects/custom-limits.md)
* [Настроить ограничения вычислений для каталога](../operations/projects/set-ds-budget.md)

Подробную информацию о методах см. в API-документации [ProjectService](grpc/project_service.md) и [FolderBudgetService](grpc/folder_budget_service.md).

Кроме перечисленных методов, вы сможете воспользоваться другими сервисными методами для работы с операциями, нодами и управлением токенами:

* [AppTokenService/Validate](grpc/app_token_service)
* [OperationService/Get](grpc/operation_service#Get)
* [OperationService/Cancel](grpc/operation_service#Cancel)
* [NodeService/Execute](grpc/app_token_service)