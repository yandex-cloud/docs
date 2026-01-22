# Развёртывание пользовательского (self-hosted) воркера SourceCraft на виртуальной машине Compute Cloud

[Пользовательские](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd#self-hosted-workers) (self-hosted) воркеры — личные серверы пользователей, как виртуальные, так и физические, на которых выполняются [CI/CD-процессы](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd) SourceCraft. В этом случае для процессов будет доступно окружение пользовательского сервера.

На пользовательские воркеры не действуют ограничения на [объем вычислительных ресурсов](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd#cloud-worker-resources), а также не расходуется [квота на суммарное время работы CI/CD-процессов](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/limits#ci-cd-quotas).

При наличии компьютера с подходящей конфигурацией, можно самостоятельно на нём [настроить пользовательский (self-hosted) воркер для SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/self-hosted-worker). В ином случае можно создать мощную виртуальную машину в Compute Cloud и на ней установить и настроить пользовательский воркер. Более того, можно автоматизировать не только процессы создания ВМ, установки, настройки и запуска на ней пользовательского воркера, но и процесс удаления ВМ после выполнения на ней [рабочего процесса](https://sourcecraft.dev/portal/docs/ru/sourcecraft/ci-cd-ref/workflows) CI/CD. Таким образом, можно удобно и оптимально использовать ресурсы Compute Cloud.

Для такой автоматизации отлично подойдут [CI/CD-процессы](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd) SourceCraft. Соответственно, понадобится репозиторий на SourceCraft, где будут запускаться эти процессы и будут храниться скрипты для них. Этот репозиторий должен находиться в той организации, чьи облако и каталог будут использоваться для виртуальной машины пользовательского воркера.

Чтобы развернуть пользовательский воркер SourceCraft на виртуальной машине Compute Cloud:
1. Подготовьте облако к работе.
2. Клонируйте репозиторий на SourceCraft.
3. Получите токен доступа (PAT).
4. Создайте сервисное подключение.
5. Настройте CI/CD-процесс.
6. Проверьте работу воркера.

Варианты использования пользовательского воркера:
* Использовать для рабочего процесса в том же репозитории, где непосредственно создаётся пользовательский воркер. В этом случае токен доступа (PAT) создаётся для этого репозитория. Пример рабочего процесса (`test-task-and-delete-vm-async`):

  ```yaml
  test-task-and-delete-vm-async:
    runs_on: self-hosted
    tasks:
      - test-task
      - name: delete
        uses: delete-vm-async
        needs: [test-task]
  ```

  Задание `test-task` выполняет полезную работу, например компиляцию проекта.

  Задание `delete` запускается только после выполнения `test-task` (параметр `needs: [test-task]`) и удаляет в асинхронном режиме виртуальную машину, на которой запускался пользовательский воркер.

  Перед запуском рабочего процесса `test-task-and-delete-vm-async` нужно запустить рабочий процесс `create-vm`, в котором будет создан пользовательский воркер.

  Сейчас нет возможности задать чёткую последовательность выполнения рабочих процессов в репозитории SourceCraft, поэтому рабочие процессы нужно **по одному** [запустить вручную](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually).

* Использовать воркер для выполнения рабочих процессов в другом репозитории SourceCraft. В таком случае токен доступа (PAT) создаётся для того (другого) репозитория. Удалять ВМ с пользовательским воркером в таком случае нужно вручную, запустив в этом репозитории рабочий процесс `delete-vm` или через [Консоль Yandex Cloud](https://console.yandex.cloud/).

## Необходимые платные ресурсы

В стоимость поддержки инфраструктуры пользовательского воркера входит:

* плата за диск и запущенную ВМ (см. [тарифы Yandex Compute Cloud](https://yandex.cloud/ru/docs/compute/pricing))
* плата за использование внешнего IP-адреса (см. [тарифы Yandex Virtual Private Cloud](https://yandex.cloud/ru/docs/vpc/pricing))

## Подготовьте облако к работе

### Создайте облачную сеть и подсеть

Создайте облачную [сеть](https://yandex.cloud/ru/docs/vpc/operations/network-create) и [подсеть](https://yandex.cloud/ru/docs/vpc/operations/subnet-create). Например, с названиями `default` и `default-ru-central1-d` (подсеть в зоне доступности `ru-central1-d`).

### Группа безопасности для ВМ

При создании ВМ с пользовательским воркером, ей будет назначена [группа безопасности](https://yandex.cloud/ru/docs/vpc/concepts/security-groups) по умолчанию (Default Security Group, DSG). Обычно это подразумевает, что для ВМ будет разрешён весь входящий и исходящий трафик.

## Клонируйте репозиторий на SourceCraft

[Репозиторий с кодом](https://sourcecraft.dev/examples/self-hosted-worker).

[Клонируйте](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/repo-clone) репозиторий или [создайте ответвление](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/fork-work#create-fork) (форк).

### Структура репозитория

```bash
├── .sourcecraft
│   └── ci.yaml                      # конфигурация CI/CD SourceCraft
├── .gitignore
├── compute-instance-create.sh       # скрипт для создания ВМ
├── compute-instance-delete-async.sh # скрипт для удаления ВМ в асинхронном режиме
├── compute-instance-delete.sh       # скрипт для удаления ВМ
├── metadata.yaml                    # метаданные для ВМ
└── README.md
```

## Создайте персональный токен доступа

[Создайте](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/pat#create) персональный токен (PAT) с [ролью](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/#src-repositories-admin) `Администратор репозитория` для того репозитория на SourceCraft, где будет использоваться пользовательский воркер. [Создайте](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/secrets#create-secret) секрет SourceCraft с названием **PAT** и положите туда токен.

## Создайте сервисное подключение

[Сервисные подключения](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/service-connections) — это безопасный способ интеграции ваших проектов SourceCraft с ресурсами Yandex Cloud.

[Создайте сервисное подключение](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/service-connections#create-service-connection) с названием `default-service-connection`, используйте для него сервисный аккаунт с ролью на каталог `editor`. Это параметры по умолчанию.

{% note warning %}

Действие [гранта от SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/grant), который выдаётся при создании сервисного подключения в персональной организации SourceCraft, **не** распространяется на сервисы **Yandex Compute Cloud** и **Yandex Virtual Private Cloud**.

{% endnote %}

## Настройте CI/CD-процесс

Настройте CI/CD-процесс для развёртывания пользовательского воркера.

### Конфигурация CI/CD

CI/CD-процесс [настраивается](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/ci-cd) в файле `.sourcecraft/ci.yaml`. [Конфигурация CI/CD](https://sourcecraft.dev/portal/docs/ru/sourcecraft/ci-cd-ref/) состоит из трёх [рабочих процессов](https://sourcecraft.dev/portal/docs/ru/sourcecraft/ci-cd-ref/workflows):
* `create-vm` - создаёт виртуальную машину с пользовательским воркером
* `delete-vm` - удаляет виртуальную машину с пользовательским воркером
* `test-task-and-delete-vm-async` - выполняет тестовую задачу на пользовательском воркере и удаляет виртуальную машину в асинхронном режиме

### Конфигурация ВМ

Конфигурация виртуальной машины для пользовательского воркера задаётся в блоке переменных `env` в файле `.sourcecraft/ci.yaml`:
* `COMPUTE_INSTANCE_NAME: "self-hosted-worker"` - название и hostname ВМ
* `VPC_SUBNET_NAME:       "default-ru-central1-d"` - подсеть, в которой будет создана ВМ
* `CREATE_BOOT_DISK:      "image-folder-id=standard-images,image-family=ubuntu-2204-lts"` - образ диска, из которого будет создана ВМ, в данном случае Ubuntu 22.04 LTS. [Получить список публичных образов](https://yandex.cloud/ru/docs/compute/operations/images-with-pre-installed-software/get-list)
* `PLATFORM:              "standard-v3"` - [платформа](https://yandex.cloud/ru/docs/compute/concepts/vm-platforms) ВМ
* `MEMORY:                64GB` - количество памяти
* `CORES:                 8` - количество ядер
* `CORE_FRACTION:         100` - гарантированная доля vCPU
* `PREEMPTIBLE:           false` - не прерываемая ВМ
* `SSH_PUB:               ${{ secrets.SSH_PUB }}` - публичная часть ssh-ключа для пользователя ВМ с логином `builder` берётся из секрета **SSH_PUB** ([создать секрет](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/secrets#create-secret)). На случай, если понадобится подключиться к ВМ с пользовательским воркером

Создание пользователя ВМ с логином `builder` происходит в файле с метаданными `metadata.yaml`:

```yaml
users:
- name: builder
  sudo: 'ALL=(ALL) NOPASSWD:ALL'
  shell: /bin/bash
  ssh_authorized_keys:
  - ${SSH_PUB}
```

### Установка пользовательского воркера и другого ПО в ВМ

Для установки исполняемого файла пользовательского воркера и другого программного обеспечения (например, Docker) используется файл с метаданными `metadata.yaml`:

```yaml
  - path: "/usr/local/etc/startup.sh"
    permissions: "755"
    content: |
      #!/bin/bash

      # install self-hosted-processor
      apt-get update
      apt-get install -y musl
      curl \
        --silent \
        --show-error \
        --location \
        https://storage.yandexcloud.net/src-processor-downloads/self-hosted-processor-latest/linux/amd64/self-hosted-processor \
        --output self-hosted-processor
      chmod +x self-hosted-processor
      mv self-hosted-processor /home/builder/sourcecraft
      chmod 777 -R /home/builder/sourcecraft

      # install docker
      apt install ca-certificates curl software-properties-common apt-transport-https -y
      install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      apt update
      apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
      usermod -aG docker builder
```

При создании ВМ, в ней создаётся и выполняется bash-скрипт `/usr/local/etc/startup.sh`, который устанавливает исполняемый файл пользовательского воркера и Docker.

### Конфигурация пользовательского воркера

[Конфигурационный файл воркера](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/self-hosted-worker#config-file) `config.yaml` так же настраивается в файле с метаданными `metadata.yaml`:

```yaml
write_files:
  - path: "/home/builder/sourcecraft/config.yaml"
    permissions: "644"
    content: |
      executor_type: shell
      self_hosted:
        root_dir: /home/builder/sourcecraft/tmp
        max_slots: 3
      logger_type: json
      logger_level: info
      endpoint:
        host: ci.sourcecraft.tech
        port: 443
        ssl_no_verify: false
      auth:
        pat: ${PAT}
```

## Проверка работы воркера

### Создайте ВМ с пользовательским воркером

[Вручную](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually) запустите рабочий процесс `create-vm`.

Процесс создания можно контролировать по логам [кубиков](https://sourcecraft.dev/portal/docs/ru/sourcecraft/ci-cd-ref/cubes). При успешном завершении рабочего процесса, созданную ВМ можно увидеть в [Консоли](https://console.yandex.cloud/) Yandex Cloud. Ссылка на Дашборд будет в логах кубика `create-vm`.

### Проверьте работу пользовательского воркера

[Вручную](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually) запустите рабочий процесс `test-task-and-delete-vm-async`.

Проверить логи кубиков `test-worker` и `test-docker` в задании `test-task`.

В логах кубика `test-worker` должны отобразиться результаты выполнения команд `uname -a` и `free -h`, запущенных непосредственно на воркере.

В логах кубика `test-docker` должна отобразиться версия утилиты YC CLI, которая будет запущена в Docker-образе.

После выполнения задания `test-task` запустится задание `delete` (`delete-vm-async`), в котором будет предпринята попытка удалить ВМ в асинхронном режиме. Результат удаления нужно проверить через Консоль, ссылка на Дашборд будет в логах кубика `delete-vm`.

### Удалите ВМ с пользовательским воркером

[Вручную](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually) запустите рабочий процесс `delete-vm`. Если ВМ с пользовательским воркером существует, то она будет удалена.

Процесс удаления можно контролировать по логам кубиков. При успехе, ВМ должна пропасть из [Консоли](https://console.yandex.cloud/) Yandex Cloud.

## Как удалить созданные ресурсы

Чтобы перестать платить за созданные ресурсы нужно [запустить рабочий процесс](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually) `delete-vm` или другим способом [удалить ВМ](https://yandex.cloud/ru/docs/compute/operations/vm-control/vm-delete) с пользовательским воркером.

При необходимости удалите [сеть](https://yandex.cloud/ru/docs/vpc/operations/network-delete) и [подсеть](https://yandex.cloud/ru/docs/vpc/operations/subnet-delete).

## См. также

[Настроить пользовательский (self-hosted) воркер для SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/self-hosted-worker)

[Создать виртуальную машину с пользовательским скриптом конфигурации](https://yandex.cloud/ru/docs/compute/operations/vm-create/create-with-cloud-init-scripts)

[Получить список публичных образов](https://yandex.cloud/ru/docs/compute/operations/images-with-pre-installed-software/get-list)

[Платформы](https://yandex.cloud/ru/docs/compute/concepts/vm-platforms)

[Уровни производительности vCPU](https://yandex.cloud/ru/docs/compute/concepts/performance-levels)
