[Документация Yandex Cloud](../index.md) > Yandex SIEM > Yandex SIEM

# Yandex SIEM

Сервис Yandex SIEM — это собственная SIEM-система Yandex Cloud для мониторинга и анализа событий безопасности в облачной инфраструктуре. Yandex SIEM собирает данные с облачной инфраструктуры для выявления аномалий. При обнаружении аномалий Yandex SIEM создает <a href="../security-deck/concepts/alerts.md">алерты</a>, указывающие на потенциальный инцидент.

# Yandex SIEM

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Расследования

 - [Обзор](operations/investigations/index.md)

 - [Управление расследованиями](operations/investigations/manage-investigations.md)

 - [Работа со списком расследований](operations/investigations/investigations-list.md)

### Запросы

 - [Обзор](operations/queries/index.md)

 - [Управление запросами](operations/queries/manage-queries.md)

 - [Работа с шаблонами](operations/queries/work-with-templates.md)

 - [Работа со схемой базы и датасетами](operations/queries/work-with-schema-datasets.md)

 - [История запросов](operations/queries/query-history.md)

### Правила корреляции

 - [Обзор](operations/correlation-rules/index.md)

 - [Управление правилами корреляции](operations/correlation-rules/manage-rules.md)

 - [Работа со списком правил](operations/correlation-rules/rules-list.md)

### Исключения

 - [Обзор](operations/exceptions/index.md)

 - [Управление исключениями](operations/exceptions/manage-exceptions.md)

 - [Работа со списком исключений](operations/exceptions/exceptions-list.md)

## Концепции

 - [О сервисе Yandex SIEM](concepts/index.md)

 - [Расследования](concepts/investigations.md)

 - [Запросы](concepts/queries.md)

 - [Правила корреляции и исключения](concepts/correlation-rules.md)

 - [Справочник KQL](kql-reference.md)

## Справочник API

 - [Аутентификация](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](siem/api-ref/grpc/index.md)

#### Operation

 - [Overview](siem/api-ref/grpc/Operation/index.md)

 - [Get](siem/api-ref/grpc/Operation/get.md)

 - [Cancel](siem/api-ref/grpc/Operation/cancel.md)

#### Yandex Cloud SIEM Instances API

 - [Overview](instances/siem/api-ref/grpc/index.md)

##### SIEMInstance

 - [Overview](instances/siem/api-ref/grpc/SIEMInstance/index.md)

 - [List](instances/siem/api-ref/grpc/SIEMInstance/list.md)

 - [Get](instances/siem/api-ref/grpc/SIEMInstance/get.md)

#### Yandex Cloud SIEM Queries API

 - [Overview](queries/siem/api-ref/grpc/index.md)

##### Dataset

 - [Overview](queries/siem/api-ref/grpc/Dataset/index.md)

 - [GetNormalizateSchema](queries/siem/api-ref/grpc/Dataset/getNormalizateSchema.md)

 - [GetSchema](queries/siem/api-ref/grpc/Dataset/getSchema.md)

 - [GetRecords](queries/siem/api-ref/grpc/Dataset/getRecords.md)

##### Operation

 - [Overview](queries/siem/api-ref/grpc/Operation/index.md)

 - [Get](queries/siem/api-ref/grpc/Operation/get.md)

 - [Cancel](queries/siem/api-ref/grpc/Operation/cancel.md)

##### SearchLaunch

 - [Overview](queries/siem/api-ref/grpc/SearchLaunch/index.md)

 - [Get](queries/siem/api-ref/grpc/SearchLaunch/get.md)

 - [Create](queries/siem/api-ref/grpc/SearchLaunch/create.md)

 - [Cancel](queries/siem/api-ref/grpc/SearchLaunch/cancel.md)

##### Search

 - [Overview](queries/siem/api-ref/grpc/Search/index.md)

 - [Get](queries/siem/api-ref/grpc/Search/get.md)

 - [List](queries/siem/api-ref/grpc/Search/list.md)

 - [Create](queries/siem/api-ref/grpc/Search/create.md)

##### Session

 - [Overview](queries/siem/api-ref/grpc/Session/index.md)

 - [List](queries/siem/api-ref/grpc/Session/list.md)

 - [Get](queries/siem/api-ref/grpc/Session/get.md)

 - [Create](queries/siem/api-ref/grpc/Session/create.md)

### REST (англ.)

 - [Overview](siem/api-ref/index.md)

#### Operation

 - [Overview](siem/api-ref/Operation/index.md)

 - [Get](siem/api-ref/Operation/get.md)

 - [Cancel](siem/api-ref/Operation/cancel.md)

#### Yandex Cloud SIEM Instances API

 - [Overview](instances/siem/api-ref/index.md)

##### SIEMInstance

 - [Overview](instances/siem/api-ref/SIEMInstance/index.md)

 - [List](instances/siem/api-ref/SIEMInstance/list.md)

 - [Get](instances/siem/api-ref/SIEMInstance/get.md)

#### Yandex Cloud SIEM Queries API

 - [Overview](queries/siem/api-ref/index.md)

##### Dataset

 - [Overview](queries/siem/api-ref/Dataset/index.md)

 - [GetNormalizateSchema](queries/siem/api-ref/Dataset/getNormalizateSchema.md)

 - [GetSchema](queries/siem/api-ref/Dataset/getSchema.md)

 - [GetRecords](queries/siem/api-ref/Dataset/getRecords.md)

##### Operation

 - [Overview](queries/siem/api-ref/Operation/index.md)

 - [Get](queries/siem/api-ref/Operation/get.md)

 - [Cancel](queries/siem/api-ref/Operation/cancel.md)

##### SearchLaunch

 - [Overview](queries/siem/api-ref/SearchLaunch/index.md)

 - [Get](queries/siem/api-ref/SearchLaunch/get.md)

 - [Create](queries/siem/api-ref/SearchLaunch/create.md)

 - [Cancel](queries/siem/api-ref/SearchLaunch/cancel.md)

##### Search

 - [Overview](queries/siem/api-ref/Search/index.md)

 - [Get](queries/siem/api-ref/Search/get.md)

 - [List](queries/siem/api-ref/Search/list.md)

 - [Create](queries/siem/api-ref/Search/create.md)

##### Session

 - [Overview](queries/siem/api-ref/Session/index.md)

 - [List](queries/siem/api-ref/Session/list.md)

 - [Get](queries/siem/api-ref/Session/get.md)

 - [Create](queries/siem/api-ref/Session/create.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)