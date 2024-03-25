# История изменений в {{ at-full-name }}

В разделе представлена история изменений сервиса {{ at-full-name }}.

## I квартал 2024 {#q1-2024}

* Добавлены новые события для сервисов:

  {% cut "{{ certificate-manager-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `UpdateDomainAccessBindings` | Изменение привязок прав доступа для домена

  {% endcut %}

  {% cut "{{ cloud-apps-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateCloudApplication` | Создание приложения
  `DeleteCloudApplication` | Удаление приложения
  `UpdateCloudApplication` | Изменение приложения

  {% endcut %}

  {% cut "{{ dns-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `UpdatePrivateNetworks` | Изменение приватных сетей

  {% endcut %}

  {% cut "{{ cloud-logging-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `ChangeLogGroupAccessBindings` | Изменение привязок прав доступа для лог-группы
  `CreateExport` | Создание выгрузки логов
  `CreateLogGroup` | Создание лог-группы
  `CreateSink` | Создание приемника логов
  `UpdateLogGroup` | Изменение лог-группы
  `DeleteExport` | Удаление выгрузки логов
  `DeleteLogGroup` | Удаление лог-группы
  `DeleteSink` | Удаление приемника логов
  `SetExportAccessBindings` | Назначение привязок прав доступа для выгрузки логов
  `SetLogGroupAccessBindings` | Назначение привязок прав доступа для лог-группы
  `SetSinkAccessBindings` | Назначение привязок прав доступа для приемника логов
  `UpdateExport` | Изменение выгрузки логов
  `UpdateExportAccessBindings` | Изменение привязок прав доступа для выгрузки логов
  `UpdateLogGroupAccessBindings` | Изменение привязок прав доступа для лог-группы
  `UpdateSink` | Изменение приемника логов
  `UpdateSinkAccessBindings` | Изменение привязок прав доступа для приемника логов

  {% endcut %}

  {% cut "{{ org-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateOsLoginProfile` | Создание профиля OS Login
  `CreateUserSshKey` | Создание SSH-ключа пользователя
  `UpdateOsLoginProfile` | Изменение профиля OS Login
  `UpdateOsLoginSettings` | Изменение настроек OS Login
  `UpdateUserSshKey` | Изменение SSH-ключа пользователя
  `SetDefaultProfile` | Назначение профиля по умолчанию
  `DeleteOsLoginProfile` | Удаление профиля OS Login
  `DeleteUserSshKey` | Удаление SSH-ключа пользователя

  {% endcut %}

  {% cut "{{ compute-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateHostGroup` | Создание группы выделенных хостов
  `DeleteHostGroup` | Удаление группы выделенных хостов
  `UpdateHostGroup` | Изменение группы выделенных хостов
  `serialssh.ConnectSerialPort` | Подключение к серийному порту инстанса

  {% endcut %}

  {% cut "{{ kms-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `asymmetricencryption.CancelAsymmetricEncryptionKeyDeletion` | Отмена удаления асимметричной ключевой пары шифрования
  `asymmetricsignature.CancelAsymmetricSignatureKeyDeletion` | Отмена удаления ключевой пары электронной подписи

  {% endcut %}

  {% cut "{{ load-testing-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateAgent` | Создание агента
  `CreateConfig` | Создание конфигурации
  `CreateMigration` | Создание миграции
  `CreateTest` | Создание теста
  `DeleteAgent` | Удаление агента
  `DeleteConfig` | Удаление конфигурации
  `DeleteTest` | Удаление теста
  `RestartAgent` | Перезапуск агента
  `StartAgent` | Запуск агента
  `StopAgent` | Остановка агента
  `StopTest` | Остановка теста
  `UpdateAgent` | Изменение агента
  `UpdateTest` | Изменение теста
  `UpgradeImageAgent` | Обновление образа агента

  {% endcut %}

  {% cut "{{ mgl-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateInstanceBackup` | Создание резервной копии инстанса
  `ReconfigureGitlab` | Изменение конфигурации GitLab
  `RescheduleMaintenance` | Перенос запланированного технического обслуживания
  `ScheduleUpgrade` | Назначение времени обновления инстанса

  {% endcut %}

  {% cut "{{ mch-short-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `UpdateClusterExternalDictionary` | Изменение внешнего словаря

  {% endcut %}

  {% cut "{{ mes-short-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `MoveCluster` | Перемещение кластера

  {% endcut %}

  {% cut "{{ mgp-short-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateHBARule` | Создание правила аутентификации пользователей
  `CreatePXFDatasource` | Создание подключения к внешней таблице
  `DeleteBackup` | Удаление резервной копии
  `DeleteHBARule` | Удаление правила аутентификации пользователей
  `DeletePXFDatasource` | Удаление подключения к внешней таблице
  `UpdateHBARule` | Изменение правила аутентификации пользователей
  `UpdatePXFDatasource` | Изменение подключения к внешней таблице

  {% endcut %}

  {% cut "{{ mmg-short-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteBackup` | Удаление резервной копии

  {% endcut %}

  {% cut "{{ mmy-short-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `DatabaseUserLogin` | Подключение пользователя к базе данных
  `DatabaseUserLogout` | Отключение пользователя от базы данных

  {% endcut %}

  {% cut "{{ mos-short-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `MoveCluster` | Перемещение кластера
  `UpdateDashboardsNodeGroup` | Изменение группы хостов типа `Dashboards`

  {% endcut %}

  {% cut "{{ mpg-short-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `DatabaseUserLogin` | Подключение пользователя к базе данных
  `DatabaseUserLogout` | Отключение пользователя от базы данных
  `StartClusterFailover` | Запуск переключения мастера для кластера

  {% endcut %}

  {% cut "{{ vpc-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `RelocateSubnet` | Перемещение облачной подсети в другую зону доступности

  {% endcut %}
* Исправлена ошибка, из-за которой события поставлялись с задержкой, когда трейл находился в статусе `Error`.

* Изменен механизм доставки событий управления базами данных и пользователями внутри баз данных от сервисов {{ mpg-full-name }}, {{ mmy-full-name }} и {{ mmg-full-name }}. Теперь они относятся к [событиям уровня сервисов](./concepts/format-data-plane.md).
