Для запуска нескольких экземпляров сервиса в Docker-контейнерах вы можете создать группу виртуальных машин на базе образа [{{ coi }}](../../cos/concepts/index.md). В такой группе обновлять Docker-контейнер можно с помощью метаданных ВМ используя [COI или Docker Compose спецификацию](../../cos/concepts/coi-specifications.md).

{% include [warning.md](warning.md) %}

{% include [sa.md](sa.md) %}

Чтобы создать группу ВМ на базе {{ coi }}:

1. {% include [cli-install.md](../cli-install.md) %}

1. {% include [default-catalogue.md](../default-catalogue.md) %}

1. Посмотрите описание команды [CLI](../../glossary/cli.md) для создания группы ВМ:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     {{ yc-compute-ig }} create --help
     ```

   {% endlist %}

1. Проверьте, есть ли в каталоге сети:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     yc vpc network list
     ```

   {% endlist %}

   Если нет ни одной сети, [создайте ее](../../vpc/operations/network-create.md).

1. Создайте YAML-файл с именем, например, `specification.yaml`.

1. {% include [get-latest-coi](../container-registry/get-latest-coi.md) %}

1. Опишите в YAML-файле `specification.yaml`, который вы создали:

   * Общую информацию о группе:

     ```yaml
     name: container-optimized-group
     service_account_id: aje3932acd8a********
     description: "This instance group was created from YAML config."
     ```

     Где:

     * `name` — произвольное имя группы ВМ. Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.
     * `service_account_id` — идентификатор сервисного аккаунта.

       {% include [sa-dependence-brief](../../_includes/instance-groups/sa-dependence-brief.md) %}

     * `description` — произвольное описание группы ВМ.

   * [Шаблон ВМ](../../compute/concepts/instance-groups/instance-template.md):

     ```yaml
     instance_template:
       platform_id: standard-v3
       resources_spec:
         memory: 2G
         cores: 2
       boot_disk_spec:
         mode: READ_WRITE
         disk_spec:
           image_id: <идентификатор_последней_версии_COI>
           type_id: network-hdd
           size: 32G
       network_interface_specs:
         - network_id: c64mknqgnd8a********
           primary_v4_address_spec: {}
           security_group_ids:
             - enps0ar5s3ti********
       placement_policy:
        placement_group_id: rmppvhrgm77g********
       metadata:
         docker-container-declaration: |-
           spec:
             containers:
               - name: nginx
                 image: {{ registry }}/mirror/nginx:1.17.4-alpine
                 securityContext:
                   privileged: false
                 tty: false
                 stdin: false
     ```

     {% include [default-unit-size](default-unit-size.md) %}

     Где:

     * `platform_id` — идентификатор платформы.
     * `memory` — количество памяти (RAM).
     * `cores` — количество ядер процессора (vCPU).
     * `mode` — режим доступа к диску:
         * `READ_ONLY` — доступ на чтение.
         * `READ_WRITE` — доступ на чтение и запись.
     * `image_id` — идентификатор публичного образа {{ coi }}.
     * `type_id` — тип диска.
     * `size` — размер диска. Должен быть не менее 30 ГБ.
     * `network_id` — идентификатор сети `default-net`.
     * `primary_v4_address_spec` — спецификация версии интернет протокола IPv4. На данный момент доступен только протокол IPv4. Вы можете [предоставить публичный доступ к ВМ группы](../../compute/concepts/instance-groups/instance-template.md#instance-template), указав версию IP для публичного IP-адреса.
     * `security_group_ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).
     * `metadata` — значения, которые будут переданы в метаданные ВМ.
     * `docker-container-declaration` — ключ в метаданных ВМ, при котором используется [COI спецификация Docker-контейнера](../../cos/concepts/coi-specifications.md). Вы можете использовать в метаданных [Docker Compose спецификацию](../../cos/concepts/coi-specifications.md#compose-spec), для этого вместо ключа `docker-container-declaration` укажите ключ `docker-compose`.
     * `placement_policy` — (опционально) параметры [группы размещения ВМ](../../compute/concepts/placement-groups.md):
       * `placement_group_id` — идентификатор группы размещения.
   * [Политики](../../compute/concepts/instance-groups/policies/index.md):

     ```yaml
     deploy_policy:
       max_unavailable: 1
       max_expansion: 0
     scale_policy:
       fixed_scale:
         size: 3
     allocation_policy:
       zones:
         - zone_id: {{ region-id }}-a
           instance_tags_pool:
           - first
           - second
           - third
     ```

     Где:

     * `deploy_policy` — политика развертывания ВМ в группе.
     * `scale_policy` — политика масштабирования ВМ в группе.
     * `allocation_policy` — политика распределения ВМ по [зонам доступности](../../overview/concepts/geo-scope.md).

     Полный код файла `specification.yaml`:

     ```yaml
     name: container-optimized-group
     service_account_id: aje3932acd8a********
     description: "This instance group was created from YAML config."
     instance_template:
       service_account_id: aje3932acd8a******** # Идентификатор сервисного аккаунта для доступа к приватным Docker-образам.
       platform_id: standard-v3
       resources_spec:
         memory: 2G
         cores: 2
       boot_disk_spec:
         mode: READ_WRITE
         disk_spec:
           image_id: <идентификатор_последней_версии_COI>
           type_id: network-hdd
           size: 32G
       network_interface_specs:
         - network_id: c64mknqgnd8a********
           primary_v4_address_spec: {}
           security_group_ids:
             - enps0ar5s3ti********
       placement_policy:
         placement_group_id: rmppvhrgm77g********
       metadata:
         docker-container-declaration: |-
           spec:
             containers:
               - name: nginx
                 image: {{ registry }}/mirror/nginx:1.17.4-alpine
                 securityContext:
                   privileged: false
                 tty: false
                 stdin: false
     deploy_policy:
       max_unavailable: 1
       max_expansion: 0
     scale_policy:
       fixed_scale:
         size: 3
     allocation_policy:
       zones:
          - zone_id: {{ region-id }}-a
            instance_tags_pool:
            - first
            - second
            - third
     ```

     {% note info %}

     Чтобы использовать в `specification.yaml` [Docker Compose спецификацию](../../cos/concepts/coi-specifications.md#compose-spec),  вместо ключа `docker-container-declaration` укажите ключ `docker-compose`.

     {% endnote %}

1. Создайте группу ВМ в каталоге по умолчанию:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     {{ yc-compute-ig }} create --file specification.yaml
     ```

     Команда создаст группу из трех однотипных ВМ со следующими характеристиками:
     * С именем `container-optimized-group`.
     * Из последней версии публичного образа {{ coi }}.
     * С запущенным Docker-контейнером на основе `{{ registry }}/mirror/nginx:1.17.4-alpine`.
     * В сети `default-net`.
     * В зоне доступности `{{ region-id }}-a`.
     * С 2 vCPU и 2 ГБ RAM.
     * С сетевым HDD-диском объемом 32 ГБ.

   {% endlist %}