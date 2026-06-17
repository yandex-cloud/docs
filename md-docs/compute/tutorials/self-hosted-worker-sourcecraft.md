# Развертывание пользовательского (self-hosted) воркера SourceCraft на виртуальной машине Yandex Compute Cloud

[Пользовательские (self-hosted) воркеры](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd#self-hosted-workers) — личные серверы пользователей, как виртуальные, так и физические, на которых выполняются [CI/CD-процессы](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd) SourceCraft. В этом случае для процессов будет доступно окружение пользовательского сервера.

На пользовательские воркеры не действуют ограничения на [объем вычислительных ресурсов](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd#cloud-worker-resources), а также не расходуется [квота на суммарное время работы CI/CD-процессов](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/limits#ci-cd-quotas).

При наличии компьютера с подходящей конфигурацией, можно самостоятельно на нем [настроить пользовательский воркер для SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/self-hosted-worker). В ином случае можно создать виртуальную машину в Compute Cloud и установить пользовательский воркер на ней. Более того, можно автоматизировать не только процессы создания ВМ, установки, настройки и запуска пользовательского воркера, но и процесс удаления ВМ после выполнения [рабочего процесса](https://sourcecraft.dev/portal/docs/ru/sourcecraft/ci-cd-ref/workflows) CI/CD. Таким образом, можно оптимально использовать ресурсы Compute Cloud.

В руководстве рассматривается пример, как реализовать такую автоматизацию с помощью CI/CD-процессов SourceCraft с использованием [сервисного подключения](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/service-connections).

Варианты использования пользовательского воркера:
* В том же репозитории, из которого воркер был создан. Для такого случая предусмотрено автоматическое удаление ВМ после выполнения рабочего процесса.

  {% cut "Пример рабочего процесса test-task-and-delete-vm-async" %}

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

  Задание `delete` запускается только после выполнения `test-task` (параметр `needs: [test-task]`) и удаляет в асинхронном режиме ВМ, на которой запускался пользовательский воркер.

  Перед запуском рабочего процесса `test-task-and-delete-vm-async` нужно запустить рабочий процесс `create-vm`, в котором будет создан пользовательский воркер.

  {% note info %}

  Нельзя задать четкую последовательность выполнения рабочих процессов, поэтому рабочие процессы нужно по одному [запустить вручную](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually).

  {% endnote %}

  {% endcut %}

* В любом другом репозитории [организации](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#org). Удалять ВМ с пользовательским воркером в таком случае нужно [вручную](#clear-out).

Чтобы развернуть пользовательский воркер SourceCraft на ВМ Compute Cloud:
1. [Подготовьтесь к работе](#prepare).
1. [Разверните инфраструктуру](#infra).
1. [Создайте репозиторий с конфигурацией CI/CD](#clone-repo).
1. [Создайте секреты](#secrets).
1. [Настройте сервисное подключение](#service-connection).
1. [Настройте CI/CD-процесс](#configure-ci-cd).
1. [Проверьте работу воркера](#check-worker).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьтесь к работе {#prepare}

1. Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
   1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
   1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.
   
   Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).
   
   [Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).
1. Аутентифицируйтесь в SourceCraft на [главной странице](https://sourcecraft.dev) сервиса или [зарегистрируйтесь](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/registration).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры пользовательского воркера входят:
* плата за диск и запущенную ВМ ([тарифы Yandex Compute Cloud](../pricing.md));
* плата за использование внешнего IP-адреса ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).

## Разверните инфраструктуру {#infra}

1. Если у вас еще нет сетевой инфраструктуры в каталоге Yandex Cloud, в котором вы хотите разместить ВМ с пользовательским воркером, создайте облачную [сеть](../../vpc/operations/network-create.md), например `default`, и [подсеть](../../vpc/operations/subnet-create.md), например `default-ru-central1-d`.

    {% note info %}

    В предложенном в руководстве примере конфигурации CI/CD используются сеть с названиями `default` и подсеть `default-ru-central1-d`.

    {% endnote %}

1. В предложенном примере для ВМ используется [группа безопасности](../../vpc/concepts/security-groups.md) по умолчанию. [Добавьте](../../vpc/operations/security-group-add-rule.md) в нее следующие правила:

    <br>

    #|
    || **Направление**
    **трафика**
    | **Описание** 
    | **Диапазон портов**
    | **Протокол**
    | **Источник** /
    **Назначение**
    | **CIDR блоки** ||
    || Входящий
    | `Доступ к ВМ из`
    `интернета`
    | `0-65535`
    | `Любой`
    | `CIDR`
    | `0.0.0.0/0` ||
    || Исходящий
    | `Доступ ВМ в`
    `интернет`
    | `0-65535`
    | `Любой`
    | `CIDR`
    | `0.0.0.0/0` ||
    |#

1. В каталоге Yandex Cloud, в котором вы хотите разместить ВМ с пользовательским воркером, [создайте](../../iam/operations/sa/create.md) сервисный аккаунт с [ролью](../security/index.md#compute-editor) `compute.editor` на каталог.

    От имени этого сервисного аккаунта будут создаваться ВМ в Compute Cloud, и осуществляться [сервисное подключение](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/service-connections) SourceCraft.

## Создайте репозиторий с конфигурацией CI/CD {#clone-repo}

{% note tip %}

В примере показано, как создать новый репозиторий с использованием в качестве основы репозитория [self-hosted-worker](https://sourcecraft.dev/examples/self-hosted-worker). 

Вместо создания нового репозитория вы также можете [сделать](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/fork-work#create-fork) ответвление (fork) от репозитория `self-hosted-worker`.

{% endnote %}

1. [Создайте](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/repo-create#create-empty) новый пустой репозиторий в [организации](../../organization/concepts/organization.md), чьи облако и каталог будут использоваться для ВМ пользовательского воркера.

    На открывшейся странице скопируйте ссылку для доступа к новому репозиторию вида: `https://git@git.sourcecraft.dev/<слаг_организации>/<слаг_нового_репозитория>.git`.

    {% note info %}

    В примере далее для работы с `git` используется протокол [HTTPS](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/pat). Также вы можете работать по протоколу [SSH](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/ssh).

    {% endnote %}

1. [Клонируйте](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/repo-clone) репозиторий [self-hosted-worker](https://sourcecraft.dev/examples/self-hosted-worker) с примером развертывания пользовательского воркера:

    ```bash
    git clone https://git@git.sourcecraft.dev/examples/self-hosted-worker.git
    cd self-hosted-worker
    ```

    Репозиторий `self-hosted-worker` содержит следующие файлы:

    ```text
    ├── .sourcecraft
    │   └── ci.yaml                      # конфигурация CI/CD SourceCraft
    ├── .gitignore
    ├── compute-instance-create.sh       # скрипт для создания ВМ
    ├── compute-instance-delete-async.sh # скрипт для удаления ВМ в асинхронном режиме
    ├── compute-instance-delete.sh       # скрипт для удаления ВМ
    ├── metadata.yaml                    # метаданные для ВМ
    └── README.md
    ```

1. Используйте репозиторий `self-hosted-worker` в качестве основы для своего нового репозитория:

    ```bash
    git remote remove origin
    git remote add origin https://git@git.sourcecraft.dev/<слаг_организации>/<слаг_нового_репозитория>.git
    git branch -M main
    ```

1. Отправьте изменения в новый репозиторий:

    ```bash
    git push -u origin main
    ```

## Создайте секреты {#secrets}

1. [Получите](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/pat#create) персональный токен (PAT) с [ролью](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/#src-repositories-admin) `Администратор репозитория` с доступом к репозиторию, в котором вы хотите использовать пользовательский воркер для CI/CD.

    {% note tip %}

    Если вы хотите использовать воркер не только для репозитория, из которого он был создан, укажите для персонального токена соответствующие права.

    {% endnote %}

    С помощью этого токена воркер аутентифицируется в SourceCraft.

1. [Сгенерируйте SSH-ключи](../operations/vm-connect/ssh.md#creating-ssh-keys) для доступа на ВМ с воркером.
1. [Создайте](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/secrets#create-secret) следующие секреты SourceCraft:
    * с названием `PAT` и значением токена;
    * с названием `SSH_PUB` и публичным SSH-ключом.

## Настройте сервисное подключение {#service-connection}

[Сервисные подключения](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/service-connections) — это безопасный способ интеграции ваших проектов SourceCraft с ресурсами Yandex Cloud.

[Создайте](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/service-connections#create-service-connection) сервисное подключение с названием `default-service-connection`, используйте для него [созданный ранее](#infra) сервисный аккаунт с [ролью](../security/index.md#compute-editor) `compute.editor` на каталог.

{% note warning %}

Действие [гранта от SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/grant), который выдается при создании сервисного подключения в персональной организации SourceCraft, не распространяется на сервисы Yandex Compute Cloud и Yandex Virtual Private Cloud.

{% endnote %}

## Настройте CI/CD-процесс {#configure-ci-cd}

Настройте CI/CD-процесс для развертывания пользовательского воркера.

### Сконфигурируйте базовые параметры CI/CD {#base-config}

CI/CD-процесс [настраивается](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/ci-cd) в файле `.sourcecraft/ci.yaml`.

Представленная [конфигурация CI/CD](https://sourcecraft.dev/portal/docs/ru/sourcecraft/ci-cd-ref/) состоит из следующих [рабочих процессов](https://sourcecraft.dev/portal/docs/ru/sourcecraft/ci-cd-ref/workflows):
* `create-vm` — создает ВМ с пользовательским воркером.
* `delete-vm` — удаляет ВМ с пользовательским воркером.
* `test-task-and-delete-vm-async` — выполняет тестовую задачу на пользовательском воркере и удаляет ВМ в асинхронном режиме.

{% note info %}

Рабочие процессы `create-vm` и `delete-vm` выполняются на стандартных [облачных воркерах SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd#cloud-workers). Процесс `test-task-and-delete-vm-async` выполняется на пользовательском воркере.

{% endnote %}

Откорректируйте конфигурацию CI/CD под свои задачи или воспользуйтесь существующей.

### Задайте параметры ВМ {#vm-config}

Конфигурация ВМ для пользовательского воркера задается в блоке переменных `env` в файле `.sourcecraft/ci.yaml`:
* `COMPUTE_INSTANCE_NAME` — название и имя хоста ВМ, например `self-hosted-worker`.
* `VPC_SUBNET_NAME` — название подсети, созданной ранее, в которой будет размещена ВМ, например `default-ru-central1-d`.
* `CREATE_BOOT_DISK` — [образ диска](../concepts/image.md), из которого будет создана ВМ, например `image-folder-id=standard-images,image-family=ubuntu-2204-lts` (Ubuntu 22.04 LTS). Чтобы получить список публичных образов, воспользуйтесь [инструкцией](../operations/images-with-pre-installed-software/get-list.md).
* `PLATFORM` — [платформа](../concepts/vm-platforms.md) ВМ, например `standard-v3`.
* `MEMORY` — количество RAM, например `64GB`.
* `CORES` — количество ядер vCPU, например `8`.
* `CORE_FRACTION` — [гарантированная доля](../concepts/performance-levels.md) vCPU, например `100`.
* `PREEMPTIBLE` — указание, использовать ли [прерываемую ВМ](../concepts/preemptible-vm.md), например `false`.
* `SSH_PUB` — [созданный ранее](#secrets) секрет с публичной частью SSH-ключа в формате `${{ secrets.<название_секрета> }}`. Задается на случай, если понадобится подключиться к ВМ с пользовательским воркером.

Создание пользователя ВМ с логином `builder` происходит в файле с метаданными `metadata.yaml`:

```yaml
users:
- name: builder
  sudo: 'ALL=(ALL) NOPASSWD:ALL'
  shell: /bin/bash
  ssh_authorized_keys:
  - ${SSH_PUB}
```

Откорректируйте конфигурацию ВМ под свои задачи или воспользуйтесь существующей.

### Составьте скрипт установки пользовательского воркера и другого ПО на ВМ {#script}

Для установки исполняемого файла пользовательского воркера и другого программного обеспечения, например [Docker](https://www.docker.com/), используется файл с метаданными `metadata.yaml`:

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

При развертывании ВМ, в ней создается и выполняется bash-скрипт `/usr/local/etc/startup.sh`, который устанавливает исполняемый файл пользовательского воркера и Docker.

Откорректируйте скрипт установки под свои задачи или воспользуйтесь существующим.

### Сконфигурируйте пользовательский воркер {#worker-config}

[Конфигурационный файл воркера](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/self-hosted-worker#config-file) `config.yaml` также настраивается в файле с метаданными `metadata.yaml`:

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

## Проверьте работу воркера {#check-worker}

### Создайте ВМ с пользовательским воркером {#create-vm}

[Запустите вручную](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually) рабочий процесс `create-vm`.

Процесс создания можно контролировать по логам [кубиков](https://sourcecraft.dev/portal/docs/ru/sourcecraft/ci-cd-ref/cubes). При успешном завершении рабочего процесса созданную ВМ можно увидеть в [консоли управления](https://console.yandex.cloud) Yandex Cloud по ссылке из лога кубика `create-vm`.

### Запустите тестовый рабочий процесс {#run-test-workflow}

1. [Запустите вручную](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually) рабочий процесс `test-task-and-delete-vm-async`.
1. В задании `test-task` проверьте логи кубиков `test-worker` и `test-docker`:
    * В логах кубика `test-worker` должны отобразиться результаты выполнения команд `uname -a` и `free -h`, запущенных непосредственно на воркере.
    * В логах кубика `test-docker` должна отобразиться версия утилиты Yandex Cloud CLI, которая будет запущена в Docker-контейнере.

После выполнения задания `test-task` запустится задание `delete` (`delete-vm-async`), в котором будет предпринята попытка удалить ВМ в асинхронном режиме. Результат удаления можно увидеть в [консоли управления](https://console.yandex.cloud) Yandex Cloud по ссылке из лога кубика `delete-vm`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [запустите вручную](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually) рабочий процесс `delete-vm` или [удалите](../operations/vm-control/vm-delete.md) ВМ с пользовательским воркером в интерфейсе Yandex Cloud.

При необходимости удалите [сеть](../../vpc/operations/network-delete.md) и [подсеть](../../vpc/operations/subnet-delete.md).

## Полезные ссылки {#see-also}

* [Настроить пользовательский воркер для SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/self-hosted-worker)
* [Создать виртуальную машину с пользовательским скриптом конфигурации](../operations/vm-create/create-with-cloud-init-scripts.md)
* [Получить список публичных образов](../operations/images-with-pre-installed-software/get-list.md)
* [Платформы](../concepts/vm-platforms.md)
* [Уровни производительности vCPU](../concepts/performance-levels.md)