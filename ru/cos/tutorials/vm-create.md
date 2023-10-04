# Создание ВМ с {{ coi }}

Создайте виртуальную машину из образа [{{ coi }}](../concepts/index.md) и запустите на ней [Docker-контейнер](/blog/posts/2022/03/docker-containers).

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в {{ container-registry-full-name }}, то создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) на используемый реестр. От его имени ВМ на базе {{ coi }} будет скачивать из реестра Docker-образ.

## Создайте ВМ с Docker-контейнером на базе образа {{ coi }} {#create-vm}

{% list tabs %}


- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.image_coi_label_empty-button }}**.
  1. В открывшемся окне **{{ ui-key.yacloud.compute.instances.create.section_coi }}** задайте параметры, используя подсказки:
     * (Опционально) Введите **{{ ui-key.yacloud.compute.instances.create.field_coi-name }}** Docker-контейнера, который будет запущен на ВМ. Требования к имени:
       * Длина — от 3 до 63 символов.
       * Может содержать буквы латинского алфавита, цифры и дефисы.
       * Первый символ — буква. Последний символ — не дефис.
     * Укажите [**{{ ui-key.yacloud.compute.instances.create.field_coi-image }}**](../concepts/docker-image.md), на основе которого будет запущен Docker-контейнер на ВМ. Вы можете сделать это одним из способов:
       * Выбрать один из доступных образов. Для этого начните вводить часть имени образа в поисковой строке. Поиск образов осуществляется во всех доступных каталогах облака.
       * Указать имя образа вручную. Для этого нажмите **{{ ui-key.yacloud.component.image-field.button_custom-image }}** и введите имя образа. Вы можете указать образ из сервиса {{ container-registry-name }} или любой публично доступной библиотеки Docker-образов (например, [Docker Hub](https://hub.docker.com)).
     * (Опционально) В поле **{{ ui-key.yacloud.compute.instances.create.field_coi-command }}** укажите исполняемый файл, который будет запущен при старте Docker-контейнера.
     * (Опционально) Задайте **{{ ui-key.yacloud.compute.instances.create.field_coi-arguments }}**.
     * (Опционально) Задайте **{{ ui-key.yacloud.compute.instances.create.field_coi-env }}** в формате `ключ:значение`, доступные внутри Docker-контейнера.
     * Выберите значение поля [**{{ ui-key.yacloud.compute.instances.create.field_coi-restart-policy }}**](../concepts/restart-policy.md) для Docker-контейнера:
       * **{{ ui-key.yacloud.compute.instances.create.value_coi-restart-always }}** — всегда перезапускать Docker-контейнер при его остановке.
       * **{{ ui-key.yacloud.compute.instances.create.value_coi-restart-never }}** — не перезапускать Docker-контейнер автоматически.
       * **{{ ui-key.yacloud.compute.instances.create.value_coi-restart-on-failure }}** — перезапускать Docker-контейнер, только если он завершил работу с ненулевым кодом возврата.
     * (Опционально) Включите **{{ ui-key.yacloud.compute.instances.create.field_coi-tty }}**, чтобы использовать командную оболочку внутри Docker-контейнера.
     * (Опционально) Включите **{{ ui-key.yacloud.compute.instances.create.field_coi-stdin }}**, чтобы связать поток ввода с запущенным Docker-контейнером.
     * (Опционально) Включите **{{ ui-key.yacloud.compute.instances.create.field_coi-privileged }}**, чтобы процессы Docker-контейнера получили доступ ко всем ресурсам ВМ.
     Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
  1. Задайте остальные параметры ВМ по [инструкции](../../compute/operations/vm-create/create-linux-vm.md).
 

- CLI с помощью флагов

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать ВМ и задать параметры Docker-контейнера через YC CLI:
  1. Посмотрите описание команды:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Выполните команду:

     ```bash
     yc compute instance create-with-container \
       --name my-vm \
       --zone {{ region-id }}-b \
       --ssh-key ssh-key.pub \
       --service-account-name my-robot \
       --create-boot-disk size=30 \
       --public-ip \
       --platform standard-v3 \
       --container-name=my-app \
       --container-image={{ registry }}/mirror/ubuntu:16.04 \
       --container-command=sleep \
       --container-arg="1000" \
       --container-env=KEY1=VAL1,KEY2=VAL2 \
       --container-privileged
      ```

     Где:
     * `--name` — имя ВМ.
     * `--zone` — зона доступности.
     * `--ssh-key` — содержимое файла [открытого ключа](../../compute/quickstart/quick-create-linux.md#create-ssh).
     * `--service-account-name` — имя сервисного аккаунта.
     * `--create-boot-disk size` — размер загрузочного диска. Должен быть не менее 30 ГБ.
     * `--public-ip` — выделение публичного IP-адреса для ВМ.
     * `--container-name` — имя Docker-контейнера.
     * `--container-image` — имя Docker-образа для запуска Docker-контейнера.
     * `--container-command` — команда, которая будет выполнена при запуске Docker-контейнера.
     * `--container-arg` — параметры для команды, указанной с помощью `--container-command`.
     * `--container-env` — переменные окружения, доступные внутри Docker-контейнера.
     * `--container-privileged` — запуск Docker-контейнера в привилегированном режиме.

     Результат:

     ```text
     done (17s)
      id: epdbf646ge5qgutfvh43
      folder_id: b1g88tflru0ek1omtsu0
      created_at: "2023-03-13T09:44:03Z"
      name: my-vm
     ...
     ```

    После создания ВМ появится в списке ВМ в разделе **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** в [консоли управления]({{ link-console-main }}). Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md).

- CLI с помощью файла спецификации

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать ВМ и задать параметры Docker-контейнера с помощью [файла спецификации](../concepts/coi-specifications.md#coi-spec):
  1. Посмотрите описание команды:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Подготовьте файл спецификации Docker-контейнера. Сохраните следующие данные в файл `docker-spec.yaml`:

     ```yaml
     spec:
       containers:
       - command:
         - sleep
         args:
         - 100000
         image: {{ registry }}/mirror/ubuntu:20.04
         name: my-container
         securityContext:
          privileged: true
     ```

  1. Выполните команду:

     ```bash
     yc compute instance create-with-container \
       --coi-spec-file docker-spec.yaml \
       --name my-vm \
       --zone {{ region-id }}-b \
       --ssh-key ssh-key.pub \
       --create-boot-disk size=30 \
       --service-account-name my-service-account \
       --public-ip
     ```

     Где:
     * `--coi-spec-file` — путь к [файлу спецификации](../concepts/coi-specifications.md#coi-spec) Docker-контейнера.
     * `--name` — имя ВМ.
     * `--zone` — зона доступности.
     * `--ssh-key` — содержимое файла [открытого ключа](../../compute/quickstart/quick-create-linux.md#create-ssh).
     * `--create-boot-disk size` — размер загрузочного диска. Должен быть не менее 30 ГБ.
     * `--service-account-name` — имя сервисного аккаунта.
     * `--public-ip` — выделение публичного IP-адреса для ВМ.

     Результат:

     ```text
     done (1m40s)
      id: epde18u4mahl4a8n39ta
      folder_id: b1g7gvsi89m34qmcm3ke
      created_at: "2023-03-13T13:50:17Z"
      name: my-vm
      ...
     ```

  После создания ВМ появится в списке ВМ в разделе **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** в [консоли управления]({{ link-console-main }}). Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md).

{% endlist %}