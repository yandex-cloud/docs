# Пошаговые инструкции для DataSphere

## Управление сообществом {#community}

* [Создать сообщество](community/create.md)
* [Добавить пользователя в сообщество](community/add-user.md)
* [Управление метками сообщества](community/manage-community-labels.md)
* [Управление ограничениями сообщества](community/manage-community-config.md)
* [Создать сервисного агента](community/create-ssa.md)
* [Добавить ссылку для сообщества](community/link-channel.md)
* [Привязать платежный аккаунт](community/link-ba.md)
* [Посмотреть детализацию расходов DataSphere](community/billing-details.md)
* [Удалить сообщество](community/delete.md)
* [Удалить пользователя из сообщества](community/delete-user.md)

## Управление проектом {#project}

* [Создать пустой проект](projects/create.md)
* [Добавить пользователя в проект](projects/add-user.md)
* [Управление метками проекта](projects/manage-project-labels.md)
* [Выбрать версию Python](projects/python-version.md)
* [Изменить размер хранилища проекта](projects/storage-resize.md)
* [Изменить настройки проекта](projects/update.md)
* [Задать ограничения для проекта](projects/restrictions.md)
* [Удалить ноутбук или проект](projects/delete.md)
* [Удалить пользователя из проекта](projects/delete-user.md)
* [Использовать ресурс с совместным доступом](projects/use-shared-resource.md)
* [Решение проблем](projects/debugging-tools.md)

## DataSphere Notebook {#notebook}

* [Выбрать вычислительные ресурсы](projects/control-compute-resources.md)
* [Проверить загрузку GPU](projects/gpu-performance-check.md)
* [Получить идентификатор ноутбука](projects/get-notebook-cell-ids.md)
* [Установить зависимости](projects/install-dependencies.md)
* [Примеры кода в ноутбуке](projects/snippets.md)
* [Очистить вывод ячеек ноутбука](projects/clear-outputs.md)
* [Работа с Git](projects/work-with-git.md)
* [Настроить создание ноутбуков JupyterLab по шаблону](projects/templates.md)
* [Подключение к JupyterLab проекта из локальной IDE](projects/remote-connect.md)

## Работа с ресурсами {#resources}

* [Работа с секретами](data/secrets.md)
* [Работа с шаблонами Yandex Data Processing](data-processing-template.md)
* [Работа с Docker-образами](user-images.md)
* [Работа с датасетами](data/dataset.md)
* [Подключение к хранилищу S3](data/s3-connectors.md)
* [Работа с коннекторами Spark](data/spark-connectors.md)
* [Работа с моделями](data/models.md)
* [Работа с файловыми хранилищами](data/filestores.md)

## Подключение к источникам данных {#connections-to-data-sources}

* [Подключение к S3 с помощью библиотеки boto3](data/connect-to-s3.md)
* [Подключение к базе данных ClickHouse®](data/connect-to-clickhouse.md)
* [Подключение к базе данных PostgreSQL](data/connect-to-postgresql.md)
* [Подключение к Яндекс Диску](data/connect-to-ya-disk.md)
* [Подключение к Google Drive](data/connect-to-google-drive.md)

## DataSphere Inference {#deploy}

* [Создать ноду](deploy/node-create.md)
* [Изменить ноду](deploy/node-update.md)
* [Удалить ноду](deploy/node-delete.md)
* [Настроить окружение для развертывания самостоятельного сервиса](deploy/node-customization.md)
* [Отправить запрос в ноду](deploy/node-api.md)
* [Остановить или возобновить ноду](deploy/node-suspend-resume.md)
* [Создать алиас](deploy/alias-create.md)
* [Изменить алиас](deploy/alias-update.md)
* [Удалить алиас](deploy/alias-delete.md)
* [Отправить запрос в алиас](deploy/alias-api.md)

## DataSphere Jobs {#ds-jobs}

* [Аутентификация в DataSphere Jobs](projects/authentication.md)
* [Запуск заданий DataSphere Jobs](projects/work-with-jobs.md)
* [Работа с заданиями из Visual Studio Code](projects/jobs-toolkit.md)
* [Использование результатов работы выполненных заданий](projects/use-job-results.md)
* [Работа с сервисным агентом из задания](projects/jobs-with-ssa.md)

## Совместный доступ к ресурсам, проектам и результатам вычислений {#share}

* [Поделиться датасетом](data/dataset.md#share)
* [Поделиться файловым хранилищем](data/filestores.md#share)
* [Поделиться коннектором S3](data/s3-connectors.md#share)
* [Поделиться секретом](data/secrets.md#share)
* [Поделиться Docker-образом](user-images.md#share)
* [Поделиться шаблоном Yandex Data Processing](data-processing-template.md#share)
* [Опубликовать ноутбук](projects/publication.md)
* [Экспортировать проект](projects/export.md)
* [Открыть ноутбук в DataSphere](projects/open-in-datasphere.md)


## Дополнительные возможности DataSphere {#additional-feature}

* [Как перенести работу в новую версию DataSphere](migration.md)