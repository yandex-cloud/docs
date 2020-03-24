# Релизы YC CLI

## Версия 0.54.0 (24.03.20) {#latest-release}

**Улучшено**

- Стали более понятными сообщения, при ошибках ввода команд и флагов.

### Изменения в сервисах Облака {#services}

### {{ managed-k8s-name }} {#k8s}
- Команда `yc managed-kubernetes cluster create`.

  Добавлен флаг `--node_ipv4_cidr_mask_size` для создания кластера Kubernetes

  Добавлены флаги `--kms-key-id` и `--kms-key-name` для создания кластера Kubernetes с шифрованием секретов в KMS

## Предыдущие релизы {#previous-releases}

### Версия 0.53.0 (04.03.20) {#version0.53.0}

#### Изменения в CLI {#cli}

**Улучшено**

- При запуске `yc` на виртуальной машине внутри Облака, если в конфиге `yc` не указан `folder-id`, то будет использоваться каталог, в котором создана виртуальная машина.

- Добавлен флаг `--version`, в дополнение к команде `yc version`.

**Исправлено**

- Исправлено обновление через `yc components update` на WSL 1.

- Исправлено аварийное завершение при вызове команды `yc help`.

#### Изменения в сервисах Облака {#services}

##### {{ managed-k8s-name }} {#k8s}

- Команда `yc managed-kubernetes cluster get-credentials`

  Добавлена проверка и выдача предупреждения, если у пользователя установлена утилитита `kubectl` версии ниже 1.11, такие версии не поддерживают способ аутентификации, который задаётся данной командой.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

- Команды `{{ yc-mdb-ch }} user`

  Добавлена возможность управлять квотами пользователей.

- Команды `{{ yc-mdb-ch }} cluster`

  Добавлены флаги `metrica-access`, `datalens-access` и `websql-access` в команды создания, восстановления и редактирования кластеров.

- Добавлены команды `{{ yc-mdb-ch }} ml-model`

  Позволяет управлять ML моделями в кластере Clickhouse.

**{{ mmg-name }}, {{ mpg-name }}, {{ mmy-name }}, {{ mrd-name }}**

- Команды `yc <имя сервиса управляемой БД> cluster create`, `yc <имя сервиса управляемой БД> cluster update`, `yc <имя сервиса управляемой БД> cluster restore`.

  Добавлен флаг `datalens-access`, регулирующий доступ Yandex.DataLens к кластеру.

### Версия 0.52.1 (21.02.20) {#version0.52.1}

#### Изменения в CLI {#cli}

**Исправлено**

- При установке не пишется WARN о, на самом деле, несуществующей проблеме.

### Версия 0.52.0 (21.02.20) {#version0.52.0}

#### Изменения в CLI {#cli}

**Улучшено**

- При запуске `yc` с флагом `--help` или `-h`, помощь открывается в интерактивном режиме:
  в `less` (`$PAGER`) на linux и macOS, в `more` на windows. Это убирает необходимость отматывать вывод помощи наверх.

- Debug логи выполнения и взаимодействия с API теперь сохраняются не в директорию установки, а в директорию конфигурации
  `$HOME/.config/yandex-cloud/logs`. Это устраняет проблему, когда `yc`, установленный как отдельный бинарный файл,
  неожиданно сохранял лог рядом и мог не иметь на это прав.
- Debug логи сохраняются и в случае успешных запросов. В случае обращения в поддержку по поводу проблемы возникшей
  в процессе выполнения команды `yc`, вероятно, мы сможем помочь быстрее, если вы приложите сохраненный лог.

**Исправлено**
- Во время выполнения команд `yc components ...` не выводится предложение обновиться.


#### Изменения в сервисах Облака {#services}

#### {{ compute-name }} {#compute}

- Команда `yc compute instance create`.

  В флаг `--network-interface` добавлен параметр `nat-address`, позволяющий указать создаваемому инстансу конкретный NAT-адрес.

- Добавлены команды `yc compute instance add-one-to-one-nat` и `yc compute instance remove-one-to-one-nat`.

  Команды позволяют управлять NAT на уже созданных инстансах.

- Команды `yc compute instance create` и `yc compute instance create`.

  Добавлен флаг `--network-settings`, с помощью которого можно изменить тип сети на `Software accelerated` и обратно в `Standard`.

#### {{ kms-name }} {#kms}

- Команда `yc kms symmetric-key`.

  Добавлены команды, позволяющие управлять ролями на отдельные ключи:
  `list-access-bindings`, `set-access-bindings`, `add-access-binding`, `remove-access-binding`.

#### {{ managed-k8s-name }} {#k8s}
- Команда `yc managed-kubernetes cluster create`.

  Добавлен флаг `--enable-network-policy` для создания кластера Kubernetes с поддержкой
  [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

- Команда `yc k8s cluster get-credentials`.

  Добавлен флаг `--context-name`, позволяющий пользователю указать имя создаваемого `context` в `kubeconfig`.

  Имя создаваемого контекста по умолчанию стало более понятным: `yc-<cluster-name>`.

  Выводится пояснение результата выполнения.


### Версия 0.51.0 (12.02.20) {#version0.51.0}

#### Изменения в CLI {#cli}

**Улучшено**

- Команды `yc <сервис> <ресурс> create`.

  Добавлена возможность передавать имя ресурса как аргумент команды. Теперь команды вида `yc <сервис> <ресурс> create --name <имя ресурса>` и `yc <сервис> <ресурс> create <имя ресурса>` равнозначны.

  Например, вместо команды `yc managed-kubernetes cluster create --name my-cluster ...` теперь можно использовать команду `yc managed-kubernetes cluster create my-cluster ...`.

- Команды `yc <сервис> <ресурс> set-access-binding`.

  Добавлено предупреждение, что команда удаляет назначеные роли. Если команда вызвана пользователем напрямую (а не с помощью другой команды или скрипта), будет запрошено подтверждение.

**Исправлено**

- Команда `yc init`.

  Теперь значения флагов `--cloud-id`, `--folder-id` и `--folder-name` учитываются корректно.

- Отключены сообщения о наличии новой версии `yc` при неинтерактивном вызове команды.

#### Изменения в сервисах Облака {#services}

#### {{iam-name}} {#iam}
- Добавлены команды для создания и управления SAML-совместимыми федерациями удостоверений и сертификатами к ним: `yc iam federation` и `yc iam certificate`. Подробнее про SAML-совместимые федерации удостоверений можно узнать в [документации](https://cloud.yandex.ru/docs/iam/concepts/users/identity-federations).

### Версия 0.50.0 (27.01.20) {#version0.50.0}

#### Изменения в сервисах Облака {#services}

- Для [ресурсов, на которые можно назначать роли](../iam/concepts/access-control/resources-with-access-control.md).

    Добавлены альтернативы флагу `--subject` для команд управления ролями: `--service-account-id`, `--service-account-name`, `--user-account-id`, `--user-yandex-login` и `--all-authenticated-users`.

#### {{ managed-k8s-name }} {#k8s}

- Команда `yc managed-kubernetes node-group create`.

    Добавлен флаг `--auto-scale`, позволяющий создать группу узлов динамического размера под управлением [Cluster Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler#cluster-autoscaler).

#### {{ compute-name }} {#compute}

- Команда `yc compute instance create`.

  При указании флага `--gpus` автоматически выбирается платформа `gpu-standard-v1`.

### Версия 0.49.0 (21.01.20) {#version0.49.0}

#### Изменения в CLI {#cli}

**Улучшено**

- При запуске YC CLI с флагом `--debug`, строка лога ответа API-вызова теперь выводит не только gRPC-код статуса, но и его описание.

#### Изменения в сервисах Облака {#services}

#### {{ kms-name }} {#kms}

Появилась поддержка сервиса для управления криптографическими ключами: {{ kms-full-name }}.

{{ kms-full-name }} (KMS) позволяет создавать ключи шифрования и организовывать схемы защиты данных в ваших приложениях и сервисах.
Используйте ключи, чтобы защитить секреты, личные данные и другую конфиденциальную информацию, которую вы храните в облаке.

Сервис {{ kms-full-name }} находится на стадии Preview. Подробнее про сервис читайте в [документации](https://cloud.yandex.ru/docs/kms/).

### Версия 0.48.0 (27.12.19) {#version0.48.0}

#### Изменения в CLI {#cli}

**Улучшено**
- При обновлении YC CLI теперь выводится текущая устанавливаемая версия.

#### Изменения в сервисах Облака {#services}

#### {{ compute-name }} {#compute}

- Добавлена возможность работы с группой размещения `yc compute placement-group --help`.
- Команды `yc compute instance create` и `yc compute instance update`.

    Флаг для указания платформы переименован с `--platform-id` на `--platform`. Старое именование продолжает поддерживаться.
- Команда `yc compute instance create`.

    SSH-ключ, добавленный с помощью флага `--ssh-key`, записывается в метаданные с ключом `ssh-keys` вместо `ec2-user-data`.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mmy-name }}**

- Добавлена поддержка создания кластера с версией {{ MY }} 8.0.
- Добавлена команда для ручного переключения мастера для указанного кластера {{ MY }} `{{ yc-mdb-my }} cluster start-failover`.
- Команда `{{ yc-mdb-my }} cluster update`.

    Добавлена возможность переименовать кластер с помощью флага `--new-name`.

**{{ mpg-name }}**

- Добавлена команда для ручного переключение мастера для указанного кластера {{ PG }} `{{ yc-mdb-pg }} cluster start-failover`.
- Команда `{{ yc-mdb-pg }} cluster update`.

    Добавлена возможность переименовать кластер с помощью флага `--new-name`.

**{{ mch-name }}**

- Команда `{{ yc-mdb-ch }} cluster update`.

    Добавлена возможность переименовать кластер с помощью флага `--new-name`.

**{{ mrd-name }}**

- Команда `{{ yc-mdb-rd }} cluster update`.

    Добавлена возможность переименовать кластер с помощью флага `--new-name`.

### Версия 0.47.0 (17.12.19) {#version0.47.0}

#### Изменения в CLI {#cli}
**Улучшено**

- Добавлена возможность [аутентификации с помощью федерации](operations/authentication/federated-user.md) при вызове `yc` в неинтерактивном режиме. Этот режим используется, когда CLI запускается пользователем не напрямую, например в скрипте или в `kubectl` при работе с [кластером Kubernetes](../managed-kubernetes/concepts/index.md#kubernetes-cluster) в {{ managed-k8s-name }}.

### Версия 0.46.0 (13.12.19) {#version0.46.0}

#### Изменения в CLI {#cli}

**Улучшено**
- Для ускорения диагностики проблем авторизации, в журнал отладки запроса пишется CRC32 отправляемого [IAM-токена](../iam/concepts/authorization/iam-token.md).

#### Изменения в сервисах Облака {#services}

#### {{ sf-name }} {#serverless-functions}

- Добавлена команда `yc serverless trigger create object-storage` для подписки на изменения бакета в {{ objstorage-name }}.

### Версия 0.45.0 (03.12.19) {#version0.45.0}

#### Изменения в CLI {#cli}

**Улучшено**

- Увеличено время между повторными попытками подключения в случае недоступности любого ресурса, задействованного в выполнении команды.

#### Изменения в сервисах Облака {#services}

#### {{ iot-name }} {#iot}

- Добавлены команды для управления паролями: `yc iot registry password` и `yc iot device password`.
- Команды `yc iot registry create` и `yc iot device create`.

    Добавлены флаги для поддержки авторизации по логину и паролю: `--password`, `--read-password` и `--generate-password`.
- Команды `yc iot mqtt publish` и `yc iot mqtt subscribe`.

    Добавлены флаги для поддержки авторизации по логину и паролю: `--username` и `--password`.

### Версия 0.44.0 (19.11.19) {#version0.44.0}

#### Изменения в сервисах Облака {#services}

#### {{ sf-name }} {#serverless-functions}

* Добавлена команда `yc serverless trigger create timer` для вызова функций по таймеру.

#### Изменения в CLI {#cli}

**Исправлено**

* Исправлена ошибка, которая в редких случаях приводила к попаданию в `stdout` нескольких строк `debug`-лога.

**Улучшено**

* Отключен показ поля `Status.details` для gRPC-ошибок — информация из него дублируется в поле `Status.message`, которое показывается как основное сообщение об ошибке.

### Версия 0.43.1 (14.11.19)

#### Изменения в CLI {#cli}

**Исправлено**

- Для Windows Subsystem for Linux (WSL) при авторизации в CLI с помощью [SAML-совместимых федераций удостоверений](../iam/concepts/users/identity-federations.md) теперь корректно происходит переход в браузер.

### Версия 0.43.0 (11.11.19) {#version0.43.0}

#### Изменения в CLI {#cli}

* Добавлена возможность авторизации в CLI с помощью [SAML-совместимых федераций удостоверений](../iam/concepts/users/identity-federations.md).

    Для этого выполните команду `yc init --federation-id=<FEDERATION_ID>`, после чего можно использовать CLI для работы от имени пользователя этой федерации.

#### Изменения в сервисах Облака {#services}

#### {{ compute-name }} {#compute}

* Добавлены подробности в лог и в текст об ошибке при [авторизации изнутри виртуальной машины](../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) (с помощью IAM-токена из метаданных).

#### Изменения в сервисах управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Добавлена поддержка создания баз {{ PG }} версии 12.

**{{ mmg-name }}**

* Добавлена поддержка создания кластера с версией {{ MG }} 4.2.

### Версия 0.42.0 (21.10.19) {#version0.42.0}

#### Изменения в сервисах Облака {#services}

#### {{ compute-name }} {#compute}

* Добавлены команды `yc compute instance-group start`, `yc compute instance-group stop` для запуска и остановки группы виртуальных машин.

#### {{ container-registry-name }} {#container-registry}

* Команды `yc compute instance create-with-container` и `yc compute instance update-container`.

   Для значений "always", "never", "on-failure" флага `--container-restart-policy` добавлено альтернативное написание: "Always", "Never", "OnFailure".

#### {{ managed-k8s-name }} {#k8s}

- Команда `yc managed-kubernetes cluster create`.

    Удален флаг `--default-gateway-v4-address`.

#### Изменения в сервисах управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore`.

   Для флага `--postgresql-version string` добавлено значение `10_1с` для создания кластера {{ PG }} версии 10-1с.

### Версия 0.41.1 (26.09.19) {#version0.41.1}

- Небольшие исправления и обновления.

### Версия 0.41.0 (25.09.19) {#version0.41.0}

#### Изменения в сервисах Облака {#services}

#### {{ container-registry-name }} {#container-registry}

- Команда `yc compute instance create-with-container`.

    Из флага `--create-boot-disk` удалена поддержка параметров `snapshot-*`.

#### {{ managed-k8s-name }} {#k8s}

- Команда `yc managed-kubernetes cluster create`.

    Добавлены флаги для управления типом мастера: `--regional`, `--region` и `--master-location`.

- Команды `yc managed-kubernetes cluster create` и `yc managed-kubernetes cluster update`.

    Добавлены флаги для управления политикой обслуживания: `--auto-upgrade`, `--anytime-maintenance-window`, `--daily-maintenance-window` и `--weekly-maintenance-window`.

- Команда `yc managed-kubernetes node-groups update`.

    Добавлены флаги для управления политикой обслуживания: `--auto-upgrade`, `--auto-repair`, `--anytime-maintenance-window`, `--daily-maintenance-window` и `--weekly-maintenance-window`.


### Версия 0.40.0 (20.09.19) {#version0.40.0}

#### Изменения в сервисах Облака {#services}

#### {{ container-registry-name }} {#container-registry}

- Добавлена команда для получения подробной информации о реестре: `yc container registry repository get`,
- Команда `yc container registry repository list`.

    Добавлен вывод уникального идентификатора реестра.

#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

- Команда `yc <имя сервиса управляемой БД> create clusters`.

    Для флагов `--*resource-preset` добавлено значение по умолчанию: s2.micro.

**{{ mmg-name }}**

- Команда `{{ yc-mdb-mg }} create clusters`.

    Для флага `--mongodb-version` изменено значение по умолчанию: с 3.6 на 4.0.

### Версия 0.39.0 (16.09.19) {#version0.39.0}

#### Изменения в сервисах Облака {#services}

#### {{ container-registry-name }} {#container-registry}

- Команда `yc container registry`.

    Добавлена возможность устанавливать и просматривать список ролей для реестра Docker-образов: `list-access-bindings`, `set-access-bindings`, `add-access-binding` и `remove-access-binding`.

#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

- Команда `yc <имя сервиса управляемой БД> users list`.

    При просмотре списка пользователей больше не отображается уникальный идентификатор кластера.

### Версия 0.38.0 (09.09.19) {#version0.38.0}

#### Изменения в CLI {#cli}

**Улучшено**

- Улучшен вывод полей при просмотре списка API-ключей.

### Версия 0.37.0 (06.09.19) {#version0.37.0}

#### Изменения в CLI {#cli}

**Улучшено**

- Добавлена проверка доступности эндпоинтов API {{ iam-short-name }}, {{ resmgr-short-name }}, {{ compute-short-name }}. Если эндпоинт недоступен, выдается ошибка.
- Добавлено отображение деталей ошибок.

#### Изменения в сервисах Облака {#services}

#### {{ container-registry-name }} {#container-registry}

**Улучшено**

- Добавлена поддержка ОС Windows для работы с Docker Credential helper.
- Добавлена подробная ошибка при использовании `docker login` одновременно с Docker Credential helper.

#### {{ ig-name }} {#instance-groups}

- Добавлены команды для управления метаданными группы виртуальных машин: `yc compute instance-group add-metadata` и `yc compute instance-group remove-metadata`.

#### {{ managed-k8s-name }} {#k8s}

- Команда `yc managed-kubernetes cluster update`.

    Добавлены флаги `--node-service-account-id` и `--node-service-account-name`, позволяющие добавить или изменить сервисный аккаунт для узлов у существующего кластера {{ k8s }}.

- Команда `yc managed-kubernetes node-group update`.

    Добавлены флаги для изменения параметров существующей группы узлов: `--metadata`, `--metadata-from-file`, `--platform-id`, `--memory`, `--cores`, `--core-fraction`, `--disk-type`, `--disk-size`, `--preemptible`.

- Добавлены команды для управления метками: `yc managed-kubernetes node-group add-labels` и `yc managed-kubernetes node-group remove-labels`.

- Добавлены команды для управления метаданными группы узлов: `yc managed-kubernetes node-group add-metadata` и `yc managed-kubernetes node-group remove-metadata`.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

- Команда `{{ yc-mdb-pg }} cluster update`.

    Добавлен флаг `--connection-pool-discard` для отключения менеджера подключений.

- Команды `{{ yc-mdb-pg }} user create` и `yc managed-postgresql user update`.

    Добавлена возможность указать логин и задать права доступа для пользователя с помощью флагов `--login` и `--grants`.

### Версия 0.36.0 (27.08.19) {#version0.36.0}

#### Изменения в сервисах Облака {#services}

#### {{ resmgr-name }} {#resmgr}

- Команда `yc resource-manager cloud update`.

    Добавлена возможность переименовать облако.

### Версия 0.35.1 (16.08.19) {#version0.35.1}

#### Изменения в сервисах Облака {#services}

#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

- Команда `yc <имя сервиса управляемой БД> cluster create`.

    Переименованы типы дисков по умолчанию: `network-nvme` на `network-ssd`, `local-nvme` на `local-ssd`.

### Версия 0.35.0 (09.08.19) {#version0.35.0}

#### Изменения в CLI {#cli}

**Улучшено**

- В сообщение о новой версии CLI добавлена ссылка на документацию с описанием релизов.

#### Изменения в сервисах Облака {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

- Команда `{{ yc-mdb-pg }} cluster create`.

    Для флага `--user` добавлены параметры: `permission`, `conn-limit`, `default-transaction-isolation`, `lock-timeout`, `log-min-duration-statement`, `synchronous-commit`, `temp-file-limit`, `log-statement`.

### Версия 0.34.0 (26.07.19) {#version0.34.0}

#### Изменения в сервисах Облака {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mrd-name }}**

- Команда `{{ yc-mdb-rd }} shards`.

    Добавлена поддержка шардов для Redis-кластеров.

**{{ mch-name }}**

- Команда `{{ yc-mdb-ch }} cluster add-external-dictionary`.

    Добавлена поддержка словарей PostgreSQL. Флаги для работы со словарями: `--postgresql-source`, `--postgresql-source-hosts` и `--postgresql-invalidate-query`.

**{{ mmy-name }}**

- Команда `{{ mmy-name }} cluster update-config --set`

    Добавлена возможность глобально задать режим SQL с помощью параметра `sql_mode`.

### Версия 0.33.0 (19.07.19) {#version0.33.0}

#### Изменения в CLI {#cli}

**Улучшено**

- Индикатор прогресса выполнения команды изменен с точек на [троббер](https://ru.wikipedia.org/wiki/Троббер).

#### Изменения в сервисах Облака {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

- Команды `{{ yc-mdb-pg }} user create` и `{{ yc-mdb-pg }} user update`.

    Добавлена настройка параметров пользователя с помощью флагов `--lock_timeout`, `--log_min_duration_statement` и т. д.

### Версия 0.32.0 (05.07.19) {#version0.32.0}

#### Изменения в CLI {#cli}

**Улучшено**

- Команды для отображения списка элементов `yc <сервис> <ресурс> list`.

   Увеличено максимальное число элементов в выводе со 100 до 1000.

#### Изменения в сервисах Облака {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mmg-name }}**

- Команды  `{{ yc-mdb-mg }} cluster update` и `{{ yc-mdb-mg }} cluster update-config`.

    Для [шардированных](../managed-mongodb/concepts/sharding.md) клаcтеров появилась возможность изменять параметры компонентов `mongos` и `mongocfg`.

### Версия 0.31.0 (01.07.19) {#version0.31.0}

#### Изменения в CLI {#cli}

**Улучшено**

- При использовании CLI на виртуальной машине, запущенной от имени сервисного аккаунта, по умолчанию CLI будет авторизовываться от имени этого сервисного аккаунта.

**Исправлено**

- Попытка получить ресурс, указав его уникальный идентификатор, завершалась с ошибкой, если в конфигурации CLI не был задан параметр `folder-id`.

- Попытка получить каталог, указав его уникальный идентификатор, завершалась с ошибкой, если у пользователя не было роли `viewer` на каталог в Облаке.

- Команда `yc init` завершалась с ошибкой, если у пользователя не было роли `viewer` в Облаке.

#### Изменения в сервисах Облака {#services}

#### {{ load-balancer-name }} {#load-balancer}

- Команды `yc load-balancer network-load-balancer create` и `yc load-balancer network-load-balancer update`.

    Для флага `--listener`  появилась возможность задать параметр `target-port`, позволяющий настроить NAT так, чтобы целевые ресурсы принимали трафик на порту, отличном от порта `listener`.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

- Команды `{{ yc-mdb-ch }} user create` и `{{ yc-mdb-ch }} user update`.

    Добавлен флаг `--settings`, позволяющий задать пользовательские настройки.

### Версия 0.30.0 (18.06.19) {#version0.30.0}

#### Изменения в сервисах Облака {#services}

#### {{ compute-name }} {#compute}

- Команда `yc compute instance update`.

    Добавлены флаги `--service-account-id` и `--service-account-name`, позволяющие добавить или изменить сервисный аккаунт для существующей виртуальной машины.

- Команда `yc compute instance create`.

    Изменено количество ядер, используемое по умолчанию при создании виртуальной машины с платформой Intel Cascade Lake (`standard-v2`). Теперь `cores: 2`.

#### {{ managed-k8s-name }} {#k8s}

- Команда `yc managed-kubernetes cluster update`.

    Добавлен флаг `--default-gateway-v4-address`, позволяющий обновить адрес шлюза для существующего {{ k8s }} кластера.

### Версия 0.29.0 (11.06.19) {#version0.29.0}

- Небольшие исправления и обновления.

### Версия 0.28.0 (05.06.19) {#version0.28.0}

#### Изменения в CLI {#cli}

- Добавлено автоматическое повторное подключение в случае недоступности любого ресурса, задействованного в выполнении команды. CLI повторит попытку соединения 5 раз, частота повтора вычисляется с помощью экспоненциального откладывания (exponential backoff).

#### Изменения в сервисах Облака {#services}

####  {{ compute-name }} {#compute-cloud}

- Команда `yc compute instance create`.

    Добавлен флаг `--gpus`, позволяющий указать количество графических процессоров у виртуальной машины.

#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

- Команда `yc <имя сервиса управляемой БД> cluster get`.

    Улучшен вывод информации о кластере.

- Команда `yc <имя сервиса управляемой БД> cluster create`.

    Добавлен флаг `--backup-window-start`, позволяющий при создании кластера настроить время его ежедневного резервного копирования.

**{{ mch-name }}**

- Команда `{{ yc-mdb-ch }} cluster add-zookeeper`.

    Добавлена возможность добавлять хосты ZooKeeper.

- Команда: `{{ yc-mdb-ch }} shards add`.

    Изменена логика создания шардов:
    - Если не указан флаг `--host`, параметры для шарда копируются из самого старого шарда.
    - Если указан флаг `--host`, требуется введение всех параметров.
    - Если шарды отсутствуют, для создания шарда также требуется введение всех параметров.
