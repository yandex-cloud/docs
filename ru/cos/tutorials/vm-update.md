# Изменить ВМ с {{ coi }}

Измените параметры [Docker-контейнера](/blog/posts/2022/03/docker-containers) на виртуальной машине, созданной из образа [{{ coi }}](../concepts/index.md).

{% list tabs %}


- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором была создана ВМ.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. Нажмите на строку с ВМ, которую вы хотите изменить.
  1. Нажмите кнопку **Изменить ВМ** на верхней панели.
  1. Внесите необходимые изменения в блоке **Настройка Docker-контейнера**.
  1. Нажмите **Сохранить изменения**.
 

- CLI

  1. Посмотрите описание команды CLI для обновления ВМ:

     ```bash
     yc compute instance update-container --help
     ```

  1. Получите уникальный идентификатор ВМ. Для этого нажмите на строку с ее именем в разделе **{{ compute-name }}** в [консоли управления]({{ link-console-main }}) или воспользуйтесь командой CLI:

     ```bash
     yc compute instance list
     ```

     Результат:

     ```text
     +----------------------+-------+-------------------+---------+----------------------------------+-------------+
     |          ID          | NAME  |      ZONE ID      | STATUS  |           EXTERNAL IP            | INTERNAL IP |
     +----------------------+-------+-------------------+---------+----------------------------------+-------------+
     | epdbf646ge5qgutfvh43 | my-vm | {{ region-id }}-b | RUNNING | {{ external-ip-examples.0 }} | 172.18.0.21 |
     +----------------------+-------+-------------------+---------+----------------------------------+-------------+
     ```

  1. Обновите ВМ.

     В зависимости от способа создания ВМ, есть несколько способов обновления:

     Способ создания | Обновить с помощью<br>`--container-image` | Обновить с помощью<br>`--docker-compose-file`
     --- | --- | ---
     С помощью параметров `--container-*` | Старый Docker-контейнер удаляется, создается новый Docker-контейнер. | Старый Docker-контейнер удаляется, создаются новые Docker-контейнеры (описанные в docker-compose.yaml файле).
     С помощью спецификации в файле docker-compose.yaml | Старые Docker-контейнеры (описанные в docker-compose.yaml файле) удаляются, создается новый, описанный с помощью параметров `--container-*`| Создаются только новые (добавленные в docker-compose.yaml файл) или измененные Docker-контейнеры. Удаляются Docker-контейнеры, отсутствующие в новом в docker-compose.yaml файле.
    
     * Обновите ВМ, задав новые параметры:

       ```bash
       yc compute instance update-container epdbf646ge5qgutfvh43 \
         --container-name=my_vm_new_version \
         --container-image={{ registry }}/mirror/ubuntu:18.04 \
         --container-env=KEY1=VAL1,KEY2=VAL2 \
         --remove-container-env=KEY3 \
         --container-stdin=false \
         --container-restart-policy=Never
       ```

       Где:
       * `--container-name` — имя Docker-контейнера.
       * `--container-image` — имя Docker-образа для запуска Docker-контейнера.
       * `--container-env` — переменные окружения, доступные внутри Docker-контейнера.
       * `--remove-container-env` — исключение переменных окружения, ключи которых указаны в параметре.
       * `--container-command` — команда, которая будет выполнена при запуске Docker-контейнера.
       * `--container-stdin` — выделение буфера для потока ввода во время выполнения Docker-контейнера.
       * `--container-restart-policy` — параметры для команды, указанной с помощью `--container-command`.
       * `--container-privileged` — запуск Docker-контейнера в привилегированном режиме.

       Результат:

       ```text
       done (2s)
       id: epdbf646ge5qgutfvh43
       folder_id: b1g88tflru0ek1omtsu0
       created_at: "2023-03-13T09:44:03Z"
       name: my-vm
       ...
       ```

     * Обновите ВМ, указав спецификацию нескольких Docker-контейнеров:

       ```bash
       yc compute instance update-container epdbf646ge5qgutfvh43 --docker-compose-file=<путь к файлу>
       ```

       Где `--docker-compose-file` — путь к файлу со спецификацией Docker-контейнеров.

       Результат:

       ```text
       done (2s)
       id: fhma9omhj2e7d4c04kd2
       folder_id: b1g88tflru0ek1omtsu0
       created_at: "2023-03-13T17:08:48Z"
       name: coi-vm
       ...
       ```

{% endlist %}