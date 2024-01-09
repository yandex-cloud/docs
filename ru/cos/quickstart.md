# Создание ВМ с {{ coi }}

Создайте виртуальную машину из образа [{{ coi }}](concepts/index.md) и запустите на ней [Docker-контейнер](/blog/posts/2022/03/docker-containers).

## Перед началом работы {#before-you-begin}

Если нужный Docker-образ загружен в {{ container-registry-name }}, то создайте [сервисный аккаунт](../iam/operations/sa/create.md) с ролью [{{ roles-cr-puller }}](../container-registry/security/index.md#choosing-roles) на используемый реестр. От его имени ВМ на базе {{ coi }} будет скачивать из реестра Docker-образ.

## Создайте ВМ с Docker-контейнером на базе образа {{ coi }} {#create-vm}

{% list tabs group=instructions %}


- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.image_coi_label_empty-button }}**.
  1. В открывшемся окне **{{ ui-key.yacloud.compute.instances.create.section_coi }}** задайте параметры, используя подсказки:
     * Укажите **{{ ui-key.yacloud.compute.instances.create.field_coi-image }}**, на основе которого будет запущен Docker-контейнер на ВМ.
     * Выберите значение поля **{{ ui-key.yacloud.compute.instances.create.field_coi-restart-policy }}** для Docker-контейнера:
       * **{{ ui-key.yacloud.compute.instances.create.value_coi-restart-always }}** — всегда перезапускать Docker-контейнер при его остановке.
       * **{{ ui-key.yacloud.compute.instances.create.value_coi-restart-never }}** — не перезапускать Docker-контейнер автоматически.
       * **{{ ui-key.yacloud.compute.instances.create.value_coi-restart-on-failure }}** — перезапускать Docker-контейнер, только если он завершил работу с ненулевым кодом возврата.
     * Заполните остальные поля при необходимости.

     Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
  1. Задайте остальные параметры ВМ по [инструкции](../compute/operations/vm-create/create-linux-vm.md).
 

- CLI {#cli}

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
       --create-boot-disk size=30 \
       --public-ip \
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
     * `--ssh-key` — содержимое файла [открытого ключа](../compute/quickstart/quick-create-linux.md#create-ssh).
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
      id: epdbf646ge5q********
      folder_id: b1g88tflru0e********
      created_at: "2023-03-13T09:44:03Z"
      name: my-vm
     ...
     ```

     После создания ВМ появится в списке ВМ в разделе **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** в [консоли управления]({{ link-console-main }}). Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../compute/operations/index.md).

{% endlist %}

#### Что дальше {#what-is-next}

* Прочитайте подробное описание [образа {{ coi }}](concepts/index.md).
* Посмотрите, что еще можно делать с образом {{ coi }} в [пошаговых инструкциях](tutorials/index.md).