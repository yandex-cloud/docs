# Развертывание {{ GLR }} на виртуальной машине {{ compute-full-name }}

[{{ GLR }}](https://docs.gitlab.com/runner/) — приложение с открытым исходным кодом, которое выполняет задания конвейерной обработки {{ GL }} [CI/CD](/blog/posts/2022/10/ci-cd) по инструкциям из специального файла `.gitlab-ci.yml`. {{ GLR }} можно развернуть не только в [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), но и на виртуальной машине {{ compute-name }} — это проще и дешевле.

Сервис {{ compute-name }} предлагает два способа работы с {{ GLR }}. Вы можете:

* Создать [виртуальную машину](../../compute/concepts/vm.md) и вручную установить на нее {{ GLR }}.
* Создать с помощью [консоли управления]({{ link-console-main }}) раннер, который автоматически развернет указанное число виртуальных машин, готовых к выполнению задач.

Чтобы начать работу с {{ GLR }} с помощью {{ compute-name }}:

1. [Подготовьте инфраструктуру](#infra).
1. [Получите токен {{ GLR }}](#gitlab-token).
1. [Установите {{ GLR }} на виртуальную машину {{ compute-full-name }}](#install) или [создайте раннер с помощью консоли управления](#create-runner).
1. [Создайте тестовый сценарий](#example).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* Плата за [диски](../../compute/concepts/disk.md) и постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Подготовьте инфраструктуру {#infra}

1. [Создайте и активируйте инстанс](../../managed-gitlab/operations/instance/instance-create.md) {{ mgl-name }}.
1. [Создайте проект {{ GL }}]({{ gl.docs }}/ee/user/project/).

## Получите токен {{ GLR }} {#gitlab-token}

* Для настройки {{ GLR }} для всего [инстанса {{ GL }}](../../managed-gitlab/concepts/index.md#instance) (требуются права администратора {{ GL }}):

  1. Откройте {{ GL }}.
  1. В левом нижнем углу нажмите кнопку **Admin**. 
  1. В меню слева выберите **CI/CD** → **Runners**.
  1. Нажмите кнопку **New instance runner** и создайте новый {{ GLR }}.
  1. Сохраните значение параметра `Runner authentication token`.

* Для настройки {{ GLR }} для проекта:

  1. Откройте {{ GL }}.
  1. Выберите проект.
  1. В меню слева выберите **Settings** → **CI/CD**.
  1. В блоке **Runners** нажмите кнопку **Expand**.
  1. Нажмите кнопку **New project runner** и создайте новый {{ GLR }}.
  1. Сохраните значение параметра `Runner authentication token`.

## Установите {{ GLR }} на виртуальную машину {{ compute-full-name }} {#install}

1. [Создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) из публичного образа Ubuntu 22.04 LTS.

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH:

   ```bash
   ssh <логин>@<публичный_IP-адрес_ВМ>
   ```

1. Установите утилиты git и jq:

   ```bash
   sudo apt-get --yes install git jq
   ```

1. Добавьте репозиторий с {{ GLR }} в менеджер пакетов:

   ```bash
   curl --location https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
   ```

1. Установите {{ GLR }}:

   ```bash
   sudo apt-get -y install gitlab-runner
   ```

1. Зарегистрируйте {{ GLR }}:

   ```bash
   sudo gitlab-runner register
   ```

   Команда попросит ввести дополнительные данные:

   * URL инстанса {{ GL }} в формате `https://<домен>/`;
   * токен {{ GLR }}, [полученный ранее](#gitlab-token);
   * описание {{ GLR }};
   * теги {{ GLR }} и настройки обновлений (`maintenance note`) — не указывайте;
   * исполнителя (`executor`) — `shell`.

   Результат:

   ```text
   Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!

   Configuration (with the authentication token) was saved in "/etc/gitlab-runner/config.toml"
   ```

## Создайте раннер с помощью консоли управления {#create-runner}

1. Выберите инстанс {{ mgl-name }}, [созданный ранее](#infra).

1. Выберите вкладку **{{ ui-key.yacloud.gitlab.title_runners }}**.

1. Нажмите кнопку **{{ ui-key.yacloud.gitlab.button_runners_empty-create }}**.

1. Задайте имя раннера:

    * длина — от 2 до 63 символов;
    * может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * первый символ — буква, последний — не дефис.

1. Введите токен {{ GLR }}, [полученный ранее](#gitlab-token).

1. Выберите или создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). Он используется только для создания ВМ и не будет привязан к ней. У сервисного аккаунта должны быть роли `compute.admin`, `vpc.admin` и `iam.serviceAccounts.user`.

1. (Опционально) Добавьте метки для раннера.

1. В блоке **{{ ui-key.yacloud.gitlab.label_autoscale-section }}** укажите:

    * максимальное количество воркеров;
    * минимальное количество воркеров;
    * лимит простоя воркера (в минутах);
    * максимум задач на воркер;
    * количество параллельных задач на воркер.

1. (Опционально) Добавьте метки для воркера.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите одну из готовых конфигураций.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** настройте загрузочный [диск](../../compute/concepts/disk.md):

    * Выберите [тип диска](../../compute/concepts/disk.md#disks_types).
    * Задайте нужный размер диска.

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

1. Убедитесь, что раннер работает:

    * В {{ GL }}:
      * Если вы создавали {{ GLR }} для всего инстанса {{ GL }}:
          1. В левом нижнем углу нажмите кнопку **Admin**. 
          1. В меню слева выберите **CI/CD** → **Runners**.
          1. Проверьте, что созданный раннер появился в списке.

      *  Если вы создавали {{ GLR }} для проекта:
          1. Откройте проект.
          1. В меню слева выберите **Settings** → **CI/CD**.
          1. В блоке **Runners** нажмите кнопку **Expand**.
          1. Проверьте, что в блоке **Assigned project runners** появился созданный раннер.

    * В {{ compute-name }} — проверьте, что появились новые ВМ с префиксом `runner-`.

## Создайте тестовый сценарий {#example} 

1. Откройте проект {{ GL }}.

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

* [инстанс {{ GL }}](../../managed-gitlab/operations/instance/instance-delete.md);
* [ВМ с {{ GLR }}](../../compute/operations/vm-control/vm-delete.md);
* [сервисный аккаунт](../../iam/operations/sa/delete.md).
