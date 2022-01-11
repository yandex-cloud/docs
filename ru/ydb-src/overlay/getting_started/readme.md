create db:

# Current state

## Yandex.Cloud

### _includes/create-db-via-console.md
Includable блок контента о создании БД в Yandex.Cloud через UI.
No CLI!
Confitional includes cloud specs inline... (tariffs...)

### operations/create_manage_database.md
Операции с БД в Yandex.Cloud: создание, изменение, удаление
No preconditions!
includes _includes/create-db-via-console.md
Далее контент про получение списка, изменение, удаление, для UI + YC CLI.

### quickstart/create_db.md
Создание БД в Yandex.Cloud
Preconditions + _includes/create-db-via-console.md
No CLI!
Contains some internal text which is never shown, as this file is included only in "external" TOC

## Internal

### getting_started/create_manage_database.md
Создание БД на внутренних кластерах YDB в Yandex через внутренний UI весьма похожий на облачный.
Просмотр списка БД через внутренний UI.
Добавление про то что поменять и удалить можно только через заявку.

### getting_started/ydb_recipe.md
"Рецепт YDB" -- сборка YDB в однонодном режиме, и запуск на локальной машине getting_started/ydb_recipe.md

### getting_started/start_local_cluster.md
Сборка и запуск Kikimr из Аркадии. Невалидные ссылки (local_kikimr.sh)

### operations/internal/create_manage_database.md
Разные операции с внутренними БД Yandex (создание, просмотр, изменение, удаление)
Старый UI, контент устарел, все операции кроме создания "заполните заявку" в виде тикета в YDBREQUESTS, т.е. тоже в устаревшем виде.
Весь файл -- в топку.
## OSS 

### solutions/ydb_docker.md
Развертывание однонодового образа с одной БД в docker

### deploy/orchestrated
Развертывание в k8s с помощью оператора и helm-chart, многонодовая + можно создать несколько БД.

# Target

Начало работы / Создание <облачной?> БД 
  - cloud: Yandex.Cloud
  - internal: Внутренняя БД Yandex
- Рецепт Arcadia (internal only)
- Docker -- перенести ydb_docker.md сюда, а в getting_started оставить перенаправлялку
- Развертывание в Kubernetes 

Обслуживание
- Управление <облачной?> БД - Yandex.Cloud
- Управление самостоятельно развернутой БД (k8s, docker) Средства интроспекции сюда

Сборка
- Binary
- Docker-image
- K8s-image

More ways in OSS:
- download binary
- build from source

1. Объединить разделы Начало работы в одном подменю
2.
