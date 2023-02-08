# Создание ВМ с {{ coi }}

Создайте виртуальную машину из образа [{{ coi }}](concepts/index.md) и запустите на ней {% if lang == "ru" %}[Docker-контейнер](/blog/posts/2022/03/docker-containers){% else %}Docker-контейнер{% endif %}.

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в {{ container-registry-name }}, то создайте [сервисный аккаунт](../iam/operations/sa/create.md) с ролью [{{ roles-cr-puller }}](../container-registry/security/index.md#choosing-roles) на используемый реестр. От его имени ВМ на базе {{ coi }} будет скачивать из реестра Docker-образ.

## Создайте ВМ с Docker-контейнером на базе образа {{ coi }} {#create-vm}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. Нажмите кнопку **Создать ВМ**.
  1. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **Container Solution**.
  1. Нажмите кнопку **Настроить**.
  1. В открывшемся окне **Настройка Docker-контейнера** задайте параметры, используя подсказки:
     * Укажите **Docker-образ**, на основе которого будет запущен Docker-контейнер на ВМ.
     * Выберите значение поля **Политика перезапуска** для Docker-контейнера:
       * **Always** — всегда перезапускать Docker-контейнер при его остановке.
       * **Never** — не перезапускать Docker-контейнер автоматически.
       * **On-Failure** — перезапускать Docker-контейнер, только если он завершил работу с ненулевым кодом возврата.
     * Заполните остальные поля при необходимости.

     Нажмите кнопку **Применить**.
  1. Задайте остальные параметры ВМ по [инструкции](../compute/operations/vm-create/create-linux-vm.md).

- CLI

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания ВМ на базе образа {{ coi }}:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Создайте ВМ с образом {{ coi }}:

     ```bash
     yc compute instance create-with-container \
       --name my-vm \
       --zone {{ region-id }}-b \
       --ssh-key ssh-key.pub \
       --service-account-name my-robot \
       --platform standard-v3 \
       --public-ip \
       --container-name=my-app \
       --container-image=cr.yandex/mirror/ubuntu:16.04 \
       --container-command=sleep \
       --container-arg="1000" \
       --container-env=KEY1=VAL1,KEY2=VAL2 \
       --container-privileged
     ```

     Где:

     * `--name` — имя ВМ.
     * `--zone` — зона доступности.
     * `--ssh-key` — содержимое файла [открытого ключа](../compute/quickstart/quick-create-linux.md#create-ssh).
     * `--service-account-name` — имя сервисного аккаунта. 
     * `--public-ip` — выделение публичного IP-адреса для ВМ.
     * `--container-name` — имя Docker-контейнера.
     * `--container-image` — имя Docker-образа для запуска Docker-контейнера.
     * `--container-command` — команда, которая будет выполнена при запуске Docker-контейнера.
     * `--container-arg` — параметры для команды, указанной с помощью `--container-command`.
     * `--container-env` — переменные окружения, доступные внутри Docker-контейнера.
     * `--container-privileged` — запуск Docker-контейнера в привилегированном режиме.

     Результат:

     ```
     done (17s)
      id: epdbf646ge5qgutfvh43
      folder_id: b1g88tflru0ek1omtsu0
      created_at: "2019-08-07T09:44:03Z"
      name: my-vm
      zone_id: {{ region-id }}-b
      platform_id: standard-v3
     ...
     ```

     После создания ВМ появится в списке ВМ в разделе **{{ compute-name }}** в [консоли управления]({{ link-console-main }}). Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../compute/operations/index.md).

{% endlist %}

#### Что дальше {#what-is-next}

* Прочитайте подробное описание [образа {{ coi }}](concepts/index.md).
* Посмотрите, что еще можно делать с образом {{ coi }} в [пошаговых инструкциях](tutorials/index.md).