# Установка {{ GLR }} на виртуальной машине {{ compute-full-name }}

Вы можете установить {{ GLR }} на [виртуальной машине](../../compute/concepts/vm.md) {{ compute-name }}. В результате вам не понадобится более дорогой и сложный в конфигурировании [кластер {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) для установки {{ GLR }}.

Чтобы установить {{ GLR }} на ВМ {{ compute-name }}:

1. [{#T}](#infra).
1. [{#T}](#gitlab-token).
1. [{#T}](#install).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру {#infra}

1. [Создайте и активируйте инстанс](../../managed-gitlab/operations/instance/instance-create.md) {{ mgl-name }}.
1. [Создайте проект {{ GL }}]({{ gl.docs }}/ee/user/project/).
1. [Создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) из публичного образа Ubuntu 22.04 LTS.

## Получите токен {{ GLR }} {#gitlab-token}

1. Откройте проект {{ GL }} в браузере.
1. В меню слева перейдите в раздел **Settings** → **CI/CD**.
1. В разделе **Runners** нажмите кнопку **Expand**.
1. Рядом с кнопкой **New Project Runner** нажмите на ![icon](../../_assets/dots.svg) и скопируйте содержимое поля **Registration token**.

## Установите {{ GLR }} {#install}

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
   curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
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

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

* [инстанс {{ GL }}](../../managed-gitlab/operations/instance/instance-delete.md);
* [ВМ с {{ GLR }}](../../compute/operations/vm-control/vm-delete.md);
* [сервисный аккаунт](../../iam/operations/sa/delete.md).
