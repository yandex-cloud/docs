# Развертывание {{ GLR }} на виртуальной машине {{ compute-full-name }}

[{{ GLR }}](https://docs.gitlab.com/runner/) — приложение с открытым исходным кодом, которое выполняет задания конвейерной обработки {{ GL }} [CI/CD](/blog/posts/2022/10/ci-cd) по инструкциям из специального файла `.gitlab-ci.yml`. {{ GLR }} можно развернуть не только в [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), но и на виртуальной машине {{ compute-name }} — это проще и дешевле.

Для пользовательской (self-managed) инсталляции {{ GL }} вы можете вручную установить {{ GLR }} на [виртуальную машину](../../compute/concepts/vm.md) {{ compute-name }}.

Для {{ mgl-full-name }} вы также можете воспользоваться ручной установкой {{ GLR }} или автоматически развернуть [раннер](../../managed-gitlab/concepts/index.md#runners) в [консоли управления]({{ link-console-main }}), который будет обеспечивать нужное количество воркеров, запущенных в {{ compute-name }}.

{% include [gl-runners-preview](../../_includes/managed-gitlab/gl-runners-preview.md) %}

Чтобы начать работу с {{ GLR }} с помощью {{ compute-name }}:

1. [Подготовьте инфраструктуру](#infra).
1. [Получите токен {{ GLR }}](#gitlab-token).
1. [Разверните {{ GLR }}](#deploy-glr).
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

Токен можно получить при создании {{ GLR }} в {{ GL }}. Этот токен указывается при [развертывании {{ GLR }}](#deploy-glr) на виртуальной машине {{ compute-name }} и используется для аутентификации раннера в {{ GL }}.

{% include [get-token](../../_includes/managed-gitlab/get-token.md) %}

## Разверните {{ GLR }} {#deploy-glr}

Вы можете воспользоваться [ручной установкой {{ GLR }}](#install) или [автоматически развернуть раннер в консоли управления](#create-runner).

### Установите {{ GLR }} на виртуальную машину вручную {#install}

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

### Создайте раннер с помощью консоли управления {#create-runner}

{% include [gl-runners-preview](../../_includes/managed-gitlab/gl-runners-preview.md) %}

{% include [note-payment](../../_includes/managed-gitlab/note-payment.md) %}

Создание раннеров с помощью консоли управления доступно только для инстансов {{ mgl-name }}.

{% include [runner-create](../../_includes/managed-gitlab/runner-create-console.md) %}

#### Убедитесь, что раннер работает {#view-runner}

{% list tabs %}

- В {{ GL }}

    * Если вы создавали {{ GLR }} для всего инстанса {{ GL }}:
        1. В левом нижнем углу нажмите кнопку **Admin**.
        1. В меню слева выберите **CI/CD** → **Runners**.
        1. Проверьте, что созданный раннер появился в списке.

    * Если вы создавали {{ GLR }} для проекта:
        1. Откройте проект.
        1. В меню слева выберите **Settings** → **CI/CD**.
        1. В блоке **Runners** нажмите кнопку **Expand**.
        1. Проверьте, что в блоке **Assigned project runners** появился созданный раннер.

- В {{ compute-name }}

    Проверьте, что в разделе **{{ ui-key.yacloud.compute.instances.label_title }}** появились новые ВМ с префиксом в имени `runner-`.

{% endlist %}

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

### Смотрите также {#see-also}

* [{#T}](../../managed-gitlab/concepts/index.md#managed-runners)
* [{#T}](../../managed-gitlab/operations/runner.md)