# Развертывание GitLab Runner на виртуальной машине Compute Cloud

# Развертывание GitLab Runner на виртуальной машине Yandex Compute Cloud

[GitLab Runner](https://docs.gitlab.com/runner/) — приложение с открытым исходным кодом, которое выполняет задания конвейерной обработки GitLab [CI/CD](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd) по инструкциям из специального файла `.gitlab-ci.yml`. GitLab Runner можно развернуть не только в [кластере Yandex Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), но и на виртуальной машине Compute Cloud — это проще и дешевле.

Для пользовательской (self-managed) инсталляции GitLab вы можете вручную установить GitLab Runner на [виртуальную машину](../concepts/vm.md) Compute Cloud.

Для Yandex Managed Service for GitLab вы также можете воспользоваться ручной установкой GitLab Runner или автоматически развернуть [раннер](../../managed-gitlab/concepts/index.md#runners) в [консоли управления](https://console.yandex.cloud), который будет обеспечивать нужное количество воркеров, запущенных в Compute Cloud.

{% note info %}

Функциональность создания и управления раннерами с помощью консоли управления находится на стадии [Preview](../../overview/concepts/launch-stages.md). Чтобы запросить доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

Чтобы начать работу с GitLab Runner с помощью Compute Cloud:

1. [Подготовьте инфраструктуру](#infra).
1. [Получите токен GitLab Runner](#gitlab-token).
1. [Разверните GitLab Runner](#deploy-glr).
1. [Создайте тестовый сценарий](#example).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* Плата за [диски](../concepts/disk.md) и постоянно запущенные ВМ ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Плата за использование [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).

## Подготовьте инфраструктуру {#infra}

1. [Создайте и активируйте инстанс](../../managed-gitlab/operations/instance/instance-create.md) Managed Service for GitLab.
1. [Создайте проект GitLab](https://docs.gitlab.com/ee/user/project/).

## Получите токен GitLab Runner {#gitlab-token}

Токен можно получить при создании GitLab Runner в GitLab. Этот токен указывается при [развертывании GitLab Runner](#deploy-glr) на виртуальной машине Compute Cloud и используется для аутентификации раннера в GitLab.

Чтобы создать и настроить GitLab Runner для всего [инстанса GitLab](../../managed-gitlab/concepts/index.md#instance) (требуются права администратора GitLab):

1. Откройте GitLab.
1. В левом нижнем углу нажмите кнопку **Admin**.
1. В меню слева выберите **CI/CD** → **Runners**.
1. Нажмите кнопку **New instance runner** и создайте новый GitLab Runner.
1. Сохраните значение параметра `Runner authentication token`.

Чтобы создать и настроить GitLab Runner для [проекта](https://docs.gitlab.com/ee/user/project/):

1. Откройте GitLab.
1. Выберите проект.
1. В меню слева выберите **Settings** → **CI/CD**.
1. В блоке **Runners** нажмите кнопку **Expand**.
1. Нажмите кнопку **New project runner** и создайте новый GitLab Runner.
1. Сохраните значение параметра `Runner authentication token`.

## Разверните GitLab Runner {#deploy-glr}

Вы можете воспользоваться [ручной установкой GitLab Runner](#install) или [автоматически развернуть раннер в консоли управления](#create-runner).

### Установите GitLab Runner на виртуальную машину вручную {#install}

1. [Создайте ВМ](../operations/vm-create/create-linux-vm.md) из публичного образа Ubuntu 22.04 LTS.

1. [Подключитесь](../operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH:

   ```bash
   ssh <логин>@<публичный_IP-адрес_ВМ>
   ```

1. Установите утилиты git и jq:

   ```bash
   sudo apt-get --yes install git jq
   ```

1. Добавьте репозиторий с GitLab Runner в менеджер пакетов:

   ```bash
   curl --location https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
   ```

1. Установите GitLab Runner:

   ```bash
   sudo apt-get -y install gitlab-runner
   ```

1. Зарегистрируйте GitLab Runner:

   ```bash
   sudo gitlab-runner register
   ```

   Команда попросит ввести дополнительные данные:

   * URL инстанса GitLab в формате `https://<домен>/`;
   * токен GitLab Runner, [полученный ранее](#gitlab-token);
   * описание GitLab Runner;
   * теги GitLab Runner и настройки обновлений (`maintenance note`) — не указывайте;
   * исполнителя (`executor`) — `shell`.

   Результат:

   ```text
   Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!

   Configuration (with the authentication token) was saved in "/etc/gitlab-runner/config.toml"
   ```

### Создайте раннер с помощью консоли управления {#create-runner}

{% note info %}

Функциональность создания и управления раннерами с помощью консоли управления находится на стадии [Preview](../../overview/concepts/launch-stages.md). Чтобы запросить доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

{% note warning %}

За использование виртуальных машин (воркеров) взимается плата ([тарифы Compute Cloud](../../compute/pricing.md)).

{% endnote %}

Создание раннеров с помощью консоли управления доступно только для инстансов Managed Service for GitLab.

Для корректной работы управляемого раннера нужно выполнить [настройку](../../managed-gitlab/concepts/index.md#networking-gl-mr) сети и групп безопасности.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите инстанс Managed Service for GitLab, для которого нужно создать раннер.
  1. Выберите вкладку **Раннеры**.
  1. Нажмите кнопку **Создать раннер**.
  1. Задайте имя раннера:
      * длина — от 2 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.
  1. (Опционально) Введите произвольное описание раннера.
  1. Введите токен GitLab Runner, [полученный ранее](#gitlab-token).
  1. Выберите или создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для раннера.

      {% note info %}
      
      Этот сервисный аккаунт используется только для создания ВМ и не будет привязан к ней. У сервисного аккаунта должны быть роли [compute.admin](../security/index.md#compute-admin), [vpc.admin](../../vpc/security/index.md#vpc-admin) и [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user). Подробнее на странице [Назначение роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md).
      
      {% endnote %}

  1. (Опционально) Добавьте [метки](../../resource-manager/concepts/labels.md) для разделения раннеров на логические группы.
  1. В блоке **Настройки масштабирования** укажите:

      * **Минимум воркеров** — число воркеров, которые всегда запущены и готовы выполнять задачи. Значение по умолчанию — `1`, минимальное — `0`, максимальное — `10`.
      * **Максимум воркеров** — максимальное число воркеров, которые могут быть созданы для выполнения задач. Значение по умолчанию — `3`, минимальное — `1`, максимальное — `30`. Максимальное количество воркеров не может быть меньше минимального.
      * **Лимит простоя воркера, в минутах** — максимальное время простоя, по истечении которого дополнительно созданный воркер будет удален. Значение по умолчанию — `10`, минимальное — `0`.
      * **Максимум задач на воркер** — максимальное количество задач, после выполнения которых воркер будет удален. Значение по умолчанию — `100`, минимальное — `0`.
      * **Количество параллельных задач на воркер** — количество задач, которые выполняются на одном воркере одновременно. Значение по умолчанию — `1`, минимальное — `0`.

  1. (Опционально) Добавьте метки для воркера.
  1. В блоке **Вычислительные ресурсы** выберите конфигурацию вычислительных ресурсов.
  1. В блоке **Диски и файловые хранилища** настройте загрузочный диск:
      * Выберите [тип диска](../concepts/disk.md#disks_types).
      * Задайте размер диска.
  1. (Опционально) Выберите или создайте сервисный аккаунт для воркера.

      {% note info %}
      
      Этот сервисный аккаунт будет привязан к ВМ с воркером. С помощью него воркер сможет аутентифицироваться в API Yandex Cloud и взаимодействовать с облачными ресурсами.
      
      [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль на ресурс, с которым вы хотите работать.
      
      {% endnote %}

  1. (Опционально) Выберите [группу безопасности](../../vpc/concepts/security-groups.md).
  1. Нажмите кнопку **Создать**.

{% endlist %}

#### Убедитесь, что раннер работает {#view-runner}

{% list tabs %}

- В GitLab

    * Если вы создавали GitLab Runner для всего инстанса GitLab:
        1. В левом нижнем углу нажмите кнопку **Admin**.
        1. В меню слева выберите **CI/CD** → **Runners**.
        1. Проверьте, что созданный раннер появился в списке.

    * Если вы создавали GitLab Runner для проекта:
        1. Откройте проект.
        1. В меню слева выберите **Settings** → **CI/CD**.
        1. В блоке **Runners** нажмите кнопку **Expand**.
        1. Проверьте, что в блоке **Assigned project runners** появился созданный раннер.

- В Compute Cloud

    Проверьте, что в разделе **Виртуальные машины** появились новые ВМ с префиксом в имени `runner-`.

{% endlist %}

## Создайте тестовый сценарий {#example} 

1. Откройте проект GitLab.

1. В меню слева выберите раздел **Build** → **Pipeline editor**. Откроется страница с предложением добавить новый файл `.gitlab-ci.yml`, в котором в формате [YAML](https://yaml.org/) нужно описать сценарий.

1. Добавьте текст сценария:

    ```yaml
    build:
    stage: build
    script:
      - echo "Hello, $GITLAB_USER_LOGIN!"

    test:
    stage: test
    script:
      - echo "This job tests something"

    deploy:
    stage: deploy
    script:
      - echo "This job deploys something from the $CI_COMMIT_BRANCH branch."
    environment: production
    ```

1. Нажмите **Commit changes**.

1. В меню слева выберите раздел **Build** → **Jobs**.

1. Убедитесь, что три задачи имеют статус `Passed`.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

* [инстанс GitLab](../../managed-gitlab/operations/instance/instance-delete.md);
* [ВМ с GitLab Runner](../operations/vm-control/vm-delete.md);
* [сервисный аккаунт](../../iam/operations/sa/delete.md).

### Полезные ссылки {#see-also}

* [Управляемые раннеры](../../managed-gitlab/concepts/index.md#managed-runners)
* [Работа с управляемым раннером](../../managed-gitlab/operations/runner.md)