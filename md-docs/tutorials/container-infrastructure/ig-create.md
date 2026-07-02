[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Контейнерная инфраструктура](index.md) > Создать группу ВМ с Container Optimized Image

# Создать группу ВМ с Container Optimized Image


Для запуска нескольких экземпляров сервиса в Docker-контейнерах вы можете создать группу виртуальных машин на базе образа [Container Optimized Image](../../cos/concepts/index.md). В такой группе обновлять Docker-контейнер можно с помощью метаданных ВМ используя [COI или Docker Compose спецификацию](../../cos/concepts/coi-specifications.md).

{% note alert %}

Создавая группы ВМ, учитывайте [лимиты](../../compute/concepts/limits.md). Чтобы не нарушить работу компонента Instance Groups, не изменяйте и не удаляйте вручную созданные им ресурсы: [целевую группу](../../network-load-balancer/concepts/target-resources.md) Network Load Balancer, ВМ и диски. Вместо этого измените или удалите группу полностью.

{% endnote %}

Все операции в Instance Groups выполняются от имени сервисного аккаунта. Если сервисного аккаунта нет, [создайте его](../../iam/operations/sa/create.md).

Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль [compute.editor](../../compute/security/index.md#compute-editor).

Чтобы создать группу ВМ на базе Container Optimized Image:

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

1. По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. Посмотрите описание команды [CLI](../../glossary/cli.md) для создания группы ВМ:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     yc compute instance-group create --help
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

1. Узнайте идентификатор последней версии [публичного образа](../../compute/operations/images-with-pre-installed-software/get-list.md) Container Optimized Image.
   
   Образ Container Optimized Image в реестре [Container Registry](../../container-registry/index.md) может обновляться и меняться в соответствии с релизами. При этом образ на [виртуальной машине](../../compute/concepts/vm.md) не обновится автоматически до последней версии. Чтобы создать [группу ВМ](../../compute/concepts/instance-groups/index.md) с последней версией Container Optimized Image, необходимо самостоятельно проверить ее наличие:
   
   {% list tabs group=instructions %}
   
   - CLI {#cli}
   
     ```bash
     yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
     ```
   
     Результат:
     
     ```bash
     id: <идентификатор_последней_версии_COI>
     folder_id: standard-images
     ...
     ```
   
   - Yandex Cloud Marketplace {#marketplace}
   
     1. Перейдите на страницу Cloud Marketplace и выберите образ с нужной конфигурацией:
        * [Container Optimized Image](https://yandex.cloud/ru/marketplace/products/yc/container-optimized-image).
        * [Container Optimized Image GPU](https://yandex.cloud/ru/marketplace/products/yc/container-optimized-image-gpu).
     1. В блоке **Идентификаторы продукта** скопируйте значение `image_id`.
   
   {% endlist %}

1. Опишите в YAML-файле `specification.yaml`, который вы создали:

   * Общую информацию о группе:

     ```yaml
     name: container-optimized-group
     service_account_id: <идентификатор_сервисного_аккаунта>
     description: "This instance group was created from YAML config."
     ```

     Где:

     * `name` — произвольное имя группы ВМ. Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.
     * `service_account_id` — идентификатор сервисного аккаунта.

        Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль [compute.editor](../../compute/security/index.md#compute-editor).

       Сервисный аккаунт нельзя удалить, пока он связан с группой виртуальных машин.

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
                 image: cr.yandex/mirror/nginx:1.17.4-alpine
                 securityContext:
                   privileged: false
                 tty: false
                 stdin: false
     ```

     По умолчанию размер диска указывается в байтах. Вы можете указать другую единицу измерения с помощью соответствующего суффикса.
     
     Суффикс | Приставка и множитель | Пример
     ----- | ----- | -----
     `k` | кило- (2^10^) | `640k` = 640 × 2^10^ = `655360`
     `m` | мега- (2^20^) | `48m` = 48 × 2^20^ = `50331648`
     `g` | гига- (2^30^) | `10g` = 10 × 2^30^ = `10737418240`
     `t` | тера- (2^40^) | `4t` = 4 × 2^40^ = `4398046511104`
     `p` | пета- (2^50^) | `2p` = 2 × 2^50^ = `2251799813685248`

     Где:

     * `platform_id` — идентификатор платформы.
     * `memory` — количество памяти (RAM).
     * `cores` — количество ядер процессора (vCPU).
     * `mode` — режим доступа к диску:
         * `READ_ONLY` — доступ на чтение.
         * `READ_WRITE` — доступ на чтение и запись.
     * `image_id` — идентификатор публичного образа Container Optimized Image.
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
         - zone_id: ru-central1-a
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
     service_account_id: <идентификатор_сервисного_аккаунта>
     description: "This instance group was created from YAML config."
     instance_template:
       service_account_id: <идентификатор_сервисного_аккаунта> # Идентификатор сервисного аккаунта для доступа к приватным Docker-образам.
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
                 image: cr.yandex/mirror/nginx:1.17.4-alpine
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
          - zone_id: ru-central1-a
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
     yc compute instance-group create --file specification.yaml
     ```

     Команда создаст группу из трех однотипных ВМ со следующими характеристиками:
     * С именем `container-optimized-group`.
     * Из последней версии публичного образа Container Optimized Image.
     * С запущенным Docker-контейнером на основе `cr.yandex/mirror/nginx:1.17.4-alpine`.
     * В сети `default-net`.
     * В зоне доступности `ru-central1-a`.
     * С 2 vCPU и 2 ГБ RAM.
     * С сетевым HDD-диском объемом 32 ГБ.

   {% endlist %}