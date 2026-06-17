# Изменение группы узлов Managed Service for Kubernetes


Отдельные узлы в группах узлов — это виртуальные машины Yandex Compute Cloud с автоматически сгенерированными именами. Чтобы сконфигурировать узлы, воспользуйтесь инструкциями, приведенными ниже, или [другими инструкциями по управлению группами узлов](../index.md#node-group).

{% note alert %}

Не изменяйте параметры ВМ узлов, в том числе имена, сетевые интерфейсы и SSH-ключи, с помощью интерфейсов Compute Cloud или SSH-подключения к ВМ.

Это может нарушить работу отдельных узлов, групп узлов и всего кластера Managed Service for Kubernetes.

{% endnote %}

Для обращения к группе узлов используйте ее имя или уникальный идентификатор, которые можно узнать с помощью команды:

```bash
yc managed-kubernetes node-group list
```

Результат:

```bash
+----------------------+----------------------+-------------+----------------------+---------------------+---------+------+
|          ID          |      CLUSTER ID      |    NAME     |  INSTANCE GROUP ID   |     CREATED AT      | STATUS  | SIZE |
+----------------------+----------------------+-------------+----------------------+---------------------+---------+------+
| catt3knapbq5******** | cati493bu7ia******** | k8s-demo-ng | cl1tbm76ms7p******** | 2019-11-20 12:01:02 | RUNNING |    2 |
+----------------------+----------------------+-------------+----------------------+---------------------+---------+------+
```

Перед началом работы убедитесь, что в [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) достаточно [свободных ресурсов](../../concepts/limits.md).

## Изменить параметры группы узлов {#update-settings}

Вы можете изменить следующие параметры [группы узлов Managed Service for Kubernetes](../../concepts/index.md#node-group):
* Имя.
* Описание.
* Масштабирование: для фиксированного типа — количество узлов Managed Service for Kubernetes, для [автоматического](../../concepts/node-group/cluster-autoscaler.md) — минимальное, максимальное и начальное количество узлов Managed Service for Kubernetes. Тип масштабирования нельзя изменить.
* [Версию Kubernetes](../../concepts/release-channels-and-updates.md).
* Способ назначения [IP-адресов](../../../vpc/concepts/address.md) узлам группы: только внутренние адреса или также публичные.

    {% note info %}

    Для подключения к внешним ресурсам, например реестрам Docker-образов [Container Registry](../../../container-registry/concepts/index.md), [Cloud Registry](../../../cloud-registry/concepts/index.md) или [Docker Hub](https://hub.docker.com/), а также бакетам [Object Storage](../../../storage/concepts/bucket.md), у узлов группы должен быть доступ в интернет.
    
    Чтобы обеспечить доступ в интернет, [назначьте](node-group-update.md#node-internet-access) узлам публичный IP-адрес и [настройте](../connect/security-groups.md#rules-internal-nodegroup) группу безопасности. Также в качестве альтернативы публичным IP-адресам можно создать и настроить в подсети узлов [NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../../vpc/tutorials/nat-instance/index.md).

    Подробнее в подразделе [Доступ в интернет для рабочих узлов кластера](../../concepts/network.md#nodes-internet).

    {% endnote %}

* Список [групп безопасности](../connect/security-groups.md).

  {% note alert %}

  Не удаляйте [группы безопасности](../../../vpc/concepts/security-groups.md), привязанные к работающей группе узлов Managed Service for Kubernetes: это может привести к нарушению ее работы и потере данных.

  {% endnote %}

* [Вычислительные ресурсы](../../../compute/concepts/vm-platforms.md) и размер [диска](../../../compute/concepts/disk.md) узлов Managed Service for Kubernetes.
* Шаблон имени узлов Managed Service for Kubernetes.
* Политику [обновлений](../../concepts/release-channels-and-updates.md#updates).

Инструкция по изменению [зоны доступности](../../../overview/concepts/geo-scope.md) группы узлов приведена в разделе [Миграция ресурсов Kubernetes в другую зону доступности](../../tutorials/migration-to-an-availability-zone.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить группу узлов Managed Service for Kubernetes:
  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите во вкладку **Группы узлов**.
  1. Выберите нужную группу узлов.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. В открывшемся окне измените необходимые параметры.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Получите подробную информацию о команде для изменения группы узлов Managed Service for Kubernetes:

  ```bash
  yc managed-kubernetes node-group update --help
  ```

  Для изменения группы узлов Managed Service for Kubernetes воспользуйтесь флагами:

  * `--new-name` — изменить имя.
  * `--description` — изменить описание.
  * `--service-account-id`, `--service-account-name` — изменить [сервисный аккаунт](../../../iam/concepts/index.md#sa) для ресурсов.
  * `--node-service-account-id`, `--node-service-account-name` — изменить сервисный аккаунт для узлов Managed Service for Kubernetes.
  * `--version` — изменить версию Kubernetes.
  * `--network-interface` — настройки [сети](../../../vpc/concepts/network.md#network):

    * `security-group-ids` — идентификаторы [групп безопасности](../connect/security-groups.md).
    * `subnets` — имена подсетей, в которых будут размещаться узлы.
    * `ipv4-address` — способ назначения IPv4-адресов.
    * `ipv6-address` — способ назначения IPv6-адресов.
    
    Параметры `ipv4-address` и `ipv6-address` отвечают за способ назначения IP-адресов:
    * `auto` — узлам будут присвоены только внутренние IP-адреса.
    * `nat` — узлам будут присвоены публичные и внутренние IP-адреса.
    
    Публичные IP-адреса необходимы для [подключения](../connect/index.md) к узлам из интернета и для подключения узлов к внешним ресурсам, например реестрам Docker-образов ([Container Registry](../../../container-registry/concepts/index.md), [Cloud Registry](../../../cloud-registry/concepts/index.md) или [Docker Hub](https://hub.docker.com/)), а также бакетам [Object Storage](../../../storage/concepts/bucket.md).
    
    Чтобы обеспечить узлам доступ в интернет, назначьте им публичный IP-адрес и [настройте](../connect/security-groups.md#rules-internal-nodegroup) группу безопасности. Также в качестве альтернативы публичным IP-адресам можно создать и настроить в подсети узлов [NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../../vpc/tutorials/nat-instance/index.md).
    
    Если вы назначили узлам кластера публичные IP-адреса и затем настроили NAT-шлюз или NAT-инстанс, доступ в интернет через публичные адреса пропадет. Подробнее в [документации Yandex Virtual Private Cloud](../../../vpc/concepts/routing.md#internet-routes).

  * `--network-acceleration-type` — выбор типа [ускорения сети](../../../compute/concepts/software-accelerated-network.md):
    * `standard` — без ускорения.
    * `software-accelerated` — программно ускоренная сеть.

      {% note warning %}
      
      Перед включением [программно ускоренной сети](../../../compute/concepts/software-accelerated-network.md) убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../concepts/limits.md) для создания одного дополнительного [узла Managed Service for Kubernetes](../../concepts/index.md#node-group).
      
      {% endnote %}

  * `--node-name` — изменить шаблон имени узлов Managed Service for Kubernetes. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

    * `{instance_group.id}` — идентификатор группы ВМ.
    * `{instance.index}` — уникальный номер ВМ в группе. Возможные значения: от 1 до N, где N — количество ВМ в группе.
    * `{instance.index_in_zone}` — номер ВМ в зоне. Уникален в рамках зоны для конкретной группы ВМ.
    * `{instance.short_id}` — идентификатор ВМ, уникальный в рамках группы. Состоит из четырех букв.
    * `{instance.zone_id}`— идентификатор зоны.
    
    Например, `prod-{instance.short_id}-{instance_group.id}`. Если имя не задано, используется значение по умолчанию: `{instance_group.id}-{instance.short_id}`.

  * `--template-labels` — изменить [облачные метки группы узлов](../../../resource-manager/concepts/labels.md) в формате `<имя_метки>=<значение_метки>`. Можно указать несколько меток через запятую.
  * `--latest-revision` — получить все доступные обновления для текущей версии [мастера Managed Service for Kubernetes](../../concepts/index.md#master).
  * Настройки масштабирования:

    * `--fixed-size` — изменить фиксированное количество узлов в группе узлов Managed Service for Kubernetes.
    * `--auto-scale` — изменить настройки [автоматического масштабирования кластера Managed Service for Kubernetes](../../concepts/node-group/cluster-autoscaler.md):

      * `min` — минимальное количество узлов в группе.
      * `max` — максимальное количество узлов в группе.
      * `initial` — начальное количество узлов в группе.

    Тип масштабирования нельзя изменить.

  * `--auto-upgrade` — управлять автоматическими обновлениями.
  * Управление окном обновлений:
    * `--anytime-maintenance-window` — обновлять в любое время.
    * `--daily-maintenance-window` — обновлять ежедневно в выбранное время.
    * `--weekly-maintenance-window` — обновлять в выбранные дни.

      {% note info %}
      
      Если вы включили обновление ежедневно или в отдельные дни, оно может начаться позже указанного времени.  
      
      {% endnote %}

  {% note warning %}

  * Не поддерживается использование ключа метаданных `user-data` для донастройки ВМ и передачи пользовательских данных.
  * Для управления [SSH-ключами](../../../glossary/ssh-keygen.md) можно [воспользоваться ключом `ssh-keys`](../../../compute/concepts/vm-metadata.md).
  * Для донастройки узлов используйте привилегированные наборы DaemonSet. Например, [sysctl-tuner](https://github.com/elemir/yc-recipes/tree/master/sysctl-tuner).

  {% endnote %}

- Terraform {#tf}

  Чтобы изменить группу узлов Managed Service for Kubernetes:
  1. Откройте актуальный конфигурационный файл Terraform с описанием группы узлов Managed Service for Kubernetes.

     О том, как создать такой файл, см. в разделе [Создание группы узлов](node-group-create.md).
  1. Измените параметры в описании группы узлов Managed Service for Kubernetes.

     * Чтобы изменить настройки масштабирования, измените в блоке `scale_policy`:

       * Для фиксированного масштабирования — значение параметра `fixed_scale.size`.
       * Для [автоматического масштабирования](../../concepts/node-group/cluster-autoscaler.md) — параметры в блоке `auto_scale`:

          * `min` — минимальное количество узлов в группе.
          * `max` — максимальное количество узлов в группе.
          * `initial` — начальное количество узлов в группе.

       Тип масштабирования нельзя изменить.

     * Чтобы изменить [облачные метки группы узлов](../../../resource-manager/concepts/labels.md), добавьте блок `instance_template.labels`:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
         ...
         instance_template {
           ...
           labels {
             "<имя_метки>"="<значение_метки>"
           }
         }
       }
       ```

     * Чтобы изменить шаблон имени узлов Managed Service for Kubernetes, измените параметр `instance_template.name`. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

       * `{instance_group.id}` — идентификатор группы ВМ.
       * `{instance.index}` — уникальный номер ВМ в группе. Возможные значения: от 1 до N, где N — количество ВМ в группе.
       * `{instance.index_in_zone}` — номер ВМ в зоне. Уникален в рамках зоны для конкретной группы ВМ.
       * `{instance.short_id}` — идентификатор ВМ, уникальный в рамках группы. Состоит из четырех букв.
       * `{instance.zone_id}`— идентификатор зоны.
       
       Например, `prod-{instance.short_id}-{instance_group.id}`. Если имя не задано, используется значение по умолчанию: `{instance_group.id}-{instance.short_id}`.

     * Чтобы изменить [DNS-записи](../../../dns/concepts/resource-record.md):

       1. Создайте [внутреннюю](../../../dns/operations/zone-create-private.md) или [публичную](../../../dns/operations/zone-create-public.md) зону DNS.
       1. Добавьте блок `instance_template.network_interface.ipv4_dns_records`:
       
          ```hcl
          resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
            ...
            instance_template {
              network_interface {
                ipv4_dns_records {
                  fqdn        = "<FQDN_записи_DNS>"
                  dns_zone_id = "<идентификатор_зоны_DNS>"
                  ttl         = "<TTL_записи_DNS_в_секундах>"
                  ptr         = "<создание_PTR_записи>"
                }
              }
            }
          }
          ```
       
          Где `ptr` — создание PTR записи: `true` или `false`.
       
          В FQDN записи DNS можно использовать шаблон с переменными:
          * `{instance_group.id}` — идентификатор группы ВМ.
          * `{instance.index}` — уникальный номер ВМ в группе. Возможные значения: от 1 до N, где N — количество ВМ в группе.
          * `{instance.index_in_zone}` — номер ВМ в зоне. Уникален в рамках зоны для конкретной группы ВМ.
          * `{instance.short_id}` — идентификатор ВМ, уникальный в рамках группы. Состоит из четырех букв.
          * `{instance.zone_id}`— идентификатор зоны.

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на выполнение операций с группами узлов кластера Managed Service for Kubernetes:
     
     * создание и изменение — 60 минут;
     * удаление — 20 минут.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы узлов кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       timeouts {
         create = "1h30m"
         update = "1h30m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

     Подробнее см. в [документации провайдера Terraform](../../../terraform/resources/kubernetes_node_group.md).

- API {#api}

  Чтобы изменить параметры [группы узлов Managed Service for Kubernetes](../../concepts/index.md#node-group), воспользуйтесь методом REST API [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../../managed-kubernetes/api-ref/grpc/NodeGroup/update.md).

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Чтобы изменить [облачные метки группы узлов](../../../resource-manager/concepts/labels.md), передайте значения меток в параметре `nodeTemplate.labels`.

  Чтобы изменить шаблон имени узлов Managed Service for Kubernetes, передайте его в параметре `nodeTemplate.name`. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

  * `{instance_group.id}` — идентификатор группы ВМ.
  * `{instance.index}` — уникальный номер ВМ в группе. Возможные значения: от 1 до N, где N — количество ВМ в группе.
  * `{instance.index_in_zone}` — номер ВМ в зоне. Уникален в рамках зоны для конкретной группы ВМ.
  * `{instance.short_id}` — идентификатор ВМ, уникальный в рамках группы. Состоит из четырех букв.
  * `{instance.zone_id}`— идентификатор зоны.
  
  Например, `prod-{instance.short_id}-{instance_group.id}`. Если имя не задано, используется значение по умолчанию: `{instance_group.id}-{instance.short_id}`.

  Чтобы изменить [DNS-записи](../../../dns/concepts/resource-record.md), передайте их настройки в параметре `nodeTemplate.v4AddressSpec.dnsRecordSpecs`. В [FQDN](../../../glossary/fqdn.md) записи DNS можно использовать шаблон с переменными для имени узлов `nodeTemplate.name`.

{% endlist %}

## Настроить политику развертывания {#configure-deploy-policy}

С помощью [политики развертывания](../../concepts/node-group/deploy-policy.md) вы можете контролировать количество доступных узлов во время изменения или обновления группы.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте раздел **Managed Service for&nbsp;Kubernetes** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется изменить кластер Managed Service for Kubernetes.
  1. Нажмите на имя нужного кластера Managed Service for Kubernetes.
  1. Перейдите во вкладку **Группы узлов**.
  1. Выберите нужную группу узлов.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. Укажите значения параметров в блоке **В процессе создания и обновления разрешено**:

      * **Расширение размера группы, макс.** — максимальное количество узлов, на которое можно расширить группу при ее изменении или обновлении. Значение по умолчанию — `3`.
      * **Уменьшение размера группы, макс.** — максимальное количество узлов, которые могут быть недоступны в ходе изменения или обновления группы. Значение по умолчанию — `0`.
      
      Подробнее в разделе [Политика развертывания группы узлов в Managed Service for Kubernetes](../../concepts/node-group/deploy-policy.md).

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения группы узлов Managed Service for Kubernetes:

      ```bash
      yc managed-kubernetes node-group update --help
      ```

  1. Выполните команду:

      ```bash
      yc managed-kubernetes node-group update \
        --name <имя_группы_узлов> \
        --max-expansion <предел_расширения_группы_узлов> \
        --max-unavailable <предел_недоступных_узлов>
      ```

      Где:

      * `--max-expansion` — максимальное количество узлов, на которое можно расширить группу при ее изменении или обновлении. Значение по умолчанию — `3`.
      * `--max-unavailable` — максимальное количество узлов, которые могут быть недоступны в ходе изменения или обновления группы. Значение по умолчанию — `0`.
      
      Подробнее в разделе [Политика развертывания группы узлов в Managed Service for Kubernetes](../../concepts/node-group/deploy-policy.md).

      Имя группы узлов можно запросить со [списком групп узлов в каталоге](node-group-list.md#list).

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с описанием группы узлов Managed Service for Kubernetes.

      О том, как создать такой файл, см. в разделе [Создание группы узлов](node-group-create.md).

  1. Укажите значения параметров в блоке `deploy_policy`. Если такого блока нет — добавьте его.

      ```hcl
      resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
        cluster_id = yandex_kubernetes_cluster.<имя_кластера>.id
        ...
        deploy_policy {
          max_expansion   = <предел_расширения_группы_узлов>
          max_unavailable = <предел_недоступных_узлов>
        }
        ...
      }
      ```

      Где:

      * `max_expansion` — максимальное количество узлов, на которое можно расширить группу при ее изменении или обновлении. Значение по умолчанию — `3`.
      * `max_unavailable` — максимальное количество узлов, которые могут быть недоступны в ходе изменения или обновления группы. Значение по умолчанию — `0`.
      
      Подробнее в разделе [Политика развертывания группы узлов в Managed Service for Kubernetes](../../concepts/node-group/deploy-policy.md).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

  Подробнее см. в [документации провайдера Terraform](../../../terraform/resources/kubernetes_node_group.md).

- API {#api}

  Воспользуйтесь методом REST API [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../../managed-kubernetes/api-ref/grpc/NodeGroup/update.md).

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Передайте в запросе:
  * Идентификатор группы узлов в параметре `nodeGroupId`.

    Идентификатор группы узлов можно запросить со [списком групп узлов в каталоге](node-group-list.md#list).
  * Параметр `updateMask` со значением `deployPolicy.maxExpansion,deployPolicy.maxUnavailable`.

    {% note warning %}
    
    Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
    
    {% endnote %}

  * Параметр `deployPolicy.maxExpansion` — максимальное количество узлов, на которое можно расширить группу при ее изменении или обновлении. Значение по умолчанию — `3`.
  * Параметр `deployPolicy.maxUnavailable` — максимальное количество узлов, которые могут быть недоступны в ходе изменения или обновления группы. Значение по умолчанию — `0`.
  
  Подробнее в разделе [Политика развертывания группы узлов в Managed Service for Kubernetes](../../concepts/node-group/deploy-policy.md).

{% endlist %}

## Назначить узлам публичные IP-адреса {#node-internet-access}

Публичные IP-адреса необходимы для [подключения](../connect/index.md) к узлам из интернета и для подключения узлов к внешним ресурсам, например реестрам Docker-образов ([Container Registry](../../../container-registry/concepts/index.md), [Cloud Registry](../../../cloud-registry/concepts/index.md) или [Docker Hub](https://hub.docker.com/)), а также бакетам [Object Storage](../../../storage/concepts/bucket.md).

Чтобы обеспечить узлам доступ в интернет, назначьте им публичный IP-адрес и [настройте](../connect/security-groups.md#rules-internal-nodegroup) группу безопасности. Также в качестве альтернативы публичным IP-адресам можно создать и настроить в подсети узлов [NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../../vpc/tutorials/nat-instance/index.md).

Если вы назначили узлам кластера публичные IP-адреса и затем настроили NAT-шлюз или NAT-инстанс, доступ в интернет через публичные адреса пропадет. Подробнее в [документации Yandex Virtual Private Cloud](../../../vpc/concepts/routing.md#internet-routes).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите на вкладку **Группы узлов**.
  1. Выберите нужную группу узлов.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. В блоке **Сетевые настройки** в поле **Публичный адрес** выберите способ назначения адреса `Автоматически`. Узлам будут назначены случайные публичные IP-адреса из пула адресов Yandex Cloud.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Для назначения [узлам Managed Service for Kubernetes](../../concepts/index.md#node-group) случайных публичных IP-адресов из пула адресов Yandex Cloud:

  1. Получите подробную информацию о команде для изменения группы узлов Managed Service for Kubernetes:

     ```bash
     yc managed-kubernetes node-group update --help
     ```

  1. Выполните команду изменения группы узлов, передав ей параметр `--network-interface`:

     ```bash
     yc managed-kubernetes node-group update <идентификатор_или_имя_группы_узлов> \
     ...
       --network-interface security-group-ids=[<идентификаторы_групп_безопасности>],ipv4-address=nat
     ```

     Имена и идентификаторы групп узлов Managed Service for Kubernetes можно получить со [списком групп узлов в каталоге](node-group-list.md#list).

- Terraform {#tf}

  Чтобы назначить узлам случайные публичные IP-адреса из пула адресов Yandex Cloud:

  1. Откройте актуальный конфигурационный файл Terraform с описанием группы узлов Managed Service for Kubernetes.

     О том, как создать такой файл, см. в разделе [Создание группы узлов](node-group-create.md).

  1. В описание группы узлов добавьте параметр `instance_template.network_interface.nat` со значением `true`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       instance_template {
         ...
         network_interface {
           nat = true
         }
       }
     }
     ```

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на выполнение операций с группами узлов кластера Managed Service for Kubernetes:
     
     * создание и изменение — 60 минут;
     * удаление — 20 минут.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы узлов кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       timeouts {
         create = "1h30m"
         update = "1h30m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

     Подробнее см. в [документации провайдера Terraform](../../../terraform/resources/kubernetes_node_group.md).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Воспользуйтесь методом REST API [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) и передайте в запросе:

  * Значение `nodeTemplate.networkInterfaceSpecs.primaryV4AddressSpec.oneToOneNatSpec.ipVersion` в параметре `updateMask`.

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
     
     {% endnote %}

  * Значение `IPV4` в параметре `nodeTemplate.networkInterfaceSpecs.primaryV4AddressSpec.oneToOneNatSpec.ipVersion`.

{% endlist %}

## Пересоздать группу узлов с новой taint-политикой {#assign-taint}

{% note warning %}

При добавлении [taint-политик](../../concepts/index.md#taints-tolerations) текущая группа узлов Managed Service for Kubernetes удаляется, затем создается группа узлов с новой конфигурацией.

{% endnote %}

{% list tabs group=instructions %}

- Terraform {#tf}

  Чтобы назначить taint-политику на группу узлов:

  1. Откройте актуальный конфигурационный файл Terraform с описанием группы узлов Managed Service for Kubernetes.

     О том, как создать такой файл, см. в разделе [Создание группы узлов](node-group-create.md).

  1. В описание группы узлов добавьте блок `node_taints`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       node_taints = [
         "<ключ>=<значение>:<taint-эффект>",
         ...
       ]
       ...
     }
     ```

     Укажите произвольные ключ и значение. В качестве taint-эффекта выберите один из доступных:

     * `NoSchedule` — запретить запуск новых подов на узлах группы (уже запущенные поды продолжат работу).
     * `PreferNoSchedule` — избегать запуска подов на узлах группы, если для запуска этих подов есть свободные ресурсы в других группах.
     * `NoExecute` — завершить работу подов на узлах этой группы, расселить их в другие группы, а запуск новых подов запретить.

     Можно назначить несколько taint-политик, в этом случае укажите их через запятую.

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на выполнение операций с группами узлов кластера Managed Service for Kubernetes:
     
     * создание и изменение — 60 минут;
     * удаление — 20 минут.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы узлов кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       timeouts {
         create = "1h30m"
         update = "1h30m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

     Подробнее см. в [документации провайдера Terraform](../../../terraform/resources/kubernetes_node_group.md).

{% endlist %}

## Пересоздать группу узлов без taint-политики {#remove-taint}

{% note warning %}

При удалении [taint-политик](../../concepts/index.md#taints-tolerations) текущая группа узлов Managed Service for Kubernetes удаляется, затем создается группа узлов с новой конфигурацией.

{% endnote %}

{% list tabs group=instructions %}

- Terraform {#tf}

  Чтобы снять taint-политику с группы узлов:

  1. Откройте актуальный конфигурационный файл Terraform с описанием группы узлов Managed Service for Kubernetes.

     О том, как создать такой файл, см. в разделе [Создание группы узлов](node-group-create.md).

  1. Удалите из описания группы узлов ненужные taint-политики в блоке `node_taints`.

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на выполнение операций с группами узлов кластера Managed Service for Kubernetes:
     
     * создание и изменение — 60 минут;
     * удаление — 20 минут.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы узлов кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       timeouts {
         create = "1h30m"
         update = "1h30m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

     Подробнее см. в [документации провайдера Terraform](../../../terraform/resources/kubernetes_node_group.md).

{% endlist %}

## Управлять облачными метками группы узлов {#manage-label}

Вы можете выполнять следующие действия с [облачными метками](../../concepts/index.md#node-labels) группы узлов Managed Service for Kubernetes:
* [Добавить](#add-label).
* [Изменить](#update-label).
* [Удалить](#remove-label).

### Добавить облачную метку {#add-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
    1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
    1. Нажмите на имя нужного кластера.
    1. Перейдите во вкладку **Группы узлов**.
    1. Выберите нужную группу узлов.
    1. Нажмите кнопку **Редактировать** в правом верхнем углу.
    1. В поле **Метки** нажмите **Добавить метку**.
    1. Введите ключ и значение и нажмите **Enter**.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Добавьте облачную метку [группе узлов Managed Service for Kubernetes](../../concepts/index.md#node-group):

  ```bash
  yc managed-kubernetes node-group add-labels my-node-group --labels new_label=test_label
  ```

  Результат:

  ```text
  done (28s)
  id: catpl8c44kii********
  cluster_id: catcsqidoos7********
  ...
  ```

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с описанием группы узлов Managed Service for Kubernetes.

     О том, как создать такой файл, см. в разделе [Создание группы узлов](node-group-create.md).
  1. Добавьте в описание группы узлов Managed Service for Kubernetes параметр `labels`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       cluster_id = yandex_kubernetes_cluster.<имя_кластера>.id
       ...
       labels = {
         "<облачная_метка>" = "<значение>"
       }
       ...
     }
     ```

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на выполнение операций с группами узлов кластера Managed Service for Kubernetes:
     
     * создание и изменение — 60 минут;
     * удаление — 20 минут.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы узлов кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       timeouts {
         create = "1h30m"
         update = "1h30m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

  Подробнее см. в [документации провайдера Terraform](../../../terraform/resources/kubernetes_node_group.md).

{% endlist %}

### Изменить облачную метку {#update-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить облачную метку, потребуется удалить ее и создать заново:

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
    1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
    1. Нажмите на имя нужного кластера.
    1. Перейдите во вкладку **Группы узлов**.
    1. Выберите нужную группу узлов.
    1. Нажмите кнопку **Редактировать** в правом верхнем углу.
    1. В поле **Метки** нажмите на крестик рядом с нужной меткой, чтобы удалить ее.
    1. Нажмите **Добавить метку** и введите новые ключ и/или значение метки.
    1. Нажмите **Enter**, а затем — **Сохранить**.

- CLI {#cli}

  Измените облачную метку группы узлов Managed Service for Kubernetes:

  {% note warning %}
  
  Существующий набор меток (`labels`) полностью перезаписывается набором, переданным в запросе.
  
  {% endnote %}

  ```bash
  yc managed-kubernetes node-group update my-node-group --labels test_label=my_ng_label
  ```

  Результат:

  ```text
  done (3s)
  id: catpl8c44kii********
  cluster_id: catcsqidoos7********
  ...
  ```

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с описанием группы узлов Managed Service for Kubernetes.

     О том, как создать такой файл, см. в разделе [Создание группы узлов](node-group-create.md).
  1. Измените в описании группы узлов Managed Service for Kubernetes значения параметра `labels`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       cluster_id = yandex_kubernetes_cluster.<имя_кластера>.id
       ...
       labels = {
         "<облачная_метка>" = "<значение>"
         ...
       }
       ...
     }
     ```

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на выполнение операций с группами узлов кластера Managed Service for Kubernetes:
     
     * создание и изменение — 60 минут;
     * удаление — 20 минут.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы узлов кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       timeouts {
         create = "1h30m"
         update = "1h30m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

  Подробнее см. в [документации провайдера Terraform](../../../terraform/resources/kubernetes_node_group.md).

{% endlist %}

### Удалить облачную метку {#remove-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
    1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
    1. Нажмите на имя нужного кластера.
    1. Перейдите во вкладку **Группы узлов**.
    1. Выберите нужную группу узлов.
    1. Нажмите кнопку **Редактировать** в правом верхнем углу.
    1. В поле **Метки** нажмите на крестик рядом с нужной меткой.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Удалите облачную метку группы узлов Managed Service for Kubernetes:

  ```bash
  yc managed-kubernetes node-group remove-labels my-node-group --labels test_label
  ```

  Результат:

  ```text
  done (2s)
  id: catpl8c44kii********
  cluster_id: catcsqidoos7********
  ...
  ```

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с описанием группы узлов Managed Service for Kubernetes.

     О том, как создать такой файл, см. в разделе [Создание группы узлов](node-group-create.md).
  1. Удалите из описания группы узлов Managed Service for Kubernetes ненужные облачные метки в блоке `labels`.
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на выполнение операций с группами узлов кластера Managed Service for Kubernetes:
     
     * создание и изменение — 60 минут;
     * удаление — 20 минут.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы узлов кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       timeouts {
         create = "1h30m"
         update = "1h30m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

  Подробнее см. в [документации провайдера Terraform](../../../terraform/resources/kubernetes_node_group.md).

{% endlist %}

## Изменить способ подключения к узлам в группе узлов {#switch-node-connect-mode}

{% note info %}

После изменения способа подключения группа узлов временно перейдет в статус `Reconciling`: все узлы в группе будут пересозданы для применения изменений.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
    1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
    1. Нажмите на имя нужного кластера.
    1. Перейдите во вкладку **Группы узлов**.
    1. Выберите нужную группу узлов.
    1. Нажмите кнопку **Редактировать** в правом верхнем углу.
    1. Измените настройки для способов подключения:

        1. Чтобы включить или выключить доступ к узлам через OS Login, используйте опцию **Доступ по OS Login**.

            {% note warning %}
            
            Если доступ через OS Login включен, то доступ по SSH-ключам будет невозможен.
            
            {% endnote %}

            Настройка и использование OS Login подробно рассмотрены в разделе [Подключение к узлу через OS Login](../node-connect-oslogin.md).

        1. Чтобы включить доступ к узлам с использованием SSH-ключей:
           
           1. Убедитесь, что доступ через OS Login выключен.
           1. Убедитесь, что в метаданных группы узлов есть хотя бы один SSH-ключ. При необходимости добавьте или удалите ключи, [изменив метаданные](node-group-update.md#update-metadata) с ключом `ssh-keys`.

            Подготовка реквизитов, настройка и использование SSH-ключей подробно рассмотрены в разделе [Подключение к узлу по SSH](../node-connect-ssh.md).

        1. Чтобы выключить доступ к узлам с использованием SSH-ключей, выполните одно из действий:
           
           * Включите доступ через OS Login.
           * [Измените метаданные](node-group-update.md#update-metadata), удалив метаданные с ключом `ssh-keys`.
           
               После удаления этих метаданных вы не сможете подключиться к узлам кластера Managed Service for Kubernetes, пока не добавите один или несколько SSH-ключей.

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    1. Чтобы включить или выключить доступ к узлам через OS Login, [измените значение метаданных](node-group-update.md#update-metadata) с ключом `enable-oslogin`:
       
       * `true` — доступ включен;
       * `false` — доступ выключен.
       
       {% note warning %}
       
       Если доступ через OS Login включен, то доступ по SSH-ключам будет невозможен.
       
       {% endnote %}
       
       Настройка и использование OS Login подробно рассмотрены в разделе [Подключение к узлу через OS Login](../node-connect-oslogin.md).

    1. Чтобы включить доступ к узлам с использованием SSH-ключей:
       
       1. Убедитесь, что доступ через OS Login выключен.
       1. Убедитесь, что в метаданных группы узлов есть хотя бы один SSH-ключ. При необходимости добавьте или удалите ключи, [изменив метаданные](node-group-update.md#update-metadata) с ключом `ssh-keys`.

        Подготовка реквизитов, настройка и использование SSH-ключей подробно рассмотрены в разделе [Подключение к узлу по SSH](../node-connect-ssh.md).

    1. Чтобы выключить доступ к узлам с использованием SSH-ключей, выполните одно из действий:
       
       * Включите доступ через OS Login.
       * [Измените метаданные](node-group-update.md#update-metadata), удалив метаданные с ключом `ssh-keys`.
       
           После удаления этих метаданных вы не сможете подключиться к узлам кластера Managed Service for Kubernetes, пока не добавите один или несколько SSH-ключей.

- Terraform {#tf}

    1. Чтобы включить или выключить доступ к узлам через OS Login, [измените значение метаданных](node-group-update.md#update-metadata) с ключом `enable-oslogin`:
       
       * `true` — доступ включен;
       * `false` — доступ выключен.
       
       {% note warning %}
       
       Если доступ через OS Login включен, то доступ по SSH-ключам будет невозможен.
       
       {% endnote %}
       
       Настройка и использование OS Login подробно рассмотрены в разделе [Подключение к узлу через OS Login](../node-connect-oslogin.md).

    1. Чтобы включить доступ к узлам с использованием SSH-ключей:
       
       1. Убедитесь, что доступ через OS Login выключен.
       1. Убедитесь, что в метаданных группы узлов есть хотя бы один SSH-ключ. При необходимости добавьте или удалите ключи, [изменив метаданные](node-group-update.md#update-metadata) с ключом `ssh-keys`.

        Подготовка реквизитов, настройка и использование SSH-ключей подробно рассмотрены в разделе [Подключение к узлу по SSH](../node-connect-ssh.md).

    1. Чтобы выключить доступ к узлам с использованием SSH-ключей, выполните одно из действий:
       
       * Включите доступ через OS Login.
       * [Измените метаданные](node-group-update.md#update-metadata), удалив метаданные с ключом `ssh-keys`.
       
           После удаления этих метаданных вы не сможете подключиться к узлам кластера Managed Service for Kubernetes, пока не добавите один или несколько SSH-ключей.

- API {#api}

    1. Чтобы включить или выключить доступ к узлам через OS Login, [измените значение метаданных](node-group-update.md#update-metadata) с ключом `enable-oslogin`:
       
       * `true` — доступ включен;
       * `false` — доступ выключен.
       
       {% note warning %}
       
       Если доступ через OS Login включен, то доступ по SSH-ключам будет невозможен.
       
       {% endnote %}
       
       Настройка и использование OS Login подробно рассмотрены в разделе [Подключение к узлу через OS Login](../node-connect-oslogin.md).

    1. Чтобы включить доступ к узлам с использованием SSH-ключей:
       
       1. Убедитесь, что доступ через OS Login выключен.
       1. Убедитесь, что в метаданных группы узлов есть хотя бы один SSH-ключ. При необходимости добавьте или удалите ключи, [изменив метаданные](node-group-update.md#update-metadata) с ключом `ssh-keys`.

        Подготовка реквизитов, настройка и использование SSH-ключей подробно рассмотрены в разделе [Подключение к узлу по SSH](../node-connect-ssh.md).

    1. Чтобы выключить доступ к узлам с использованием SSH-ключей, выполните одно из действий:
       
       * Включите доступ через OS Login.
       * [Измените метаданные](node-group-update.md#update-metadata), удалив метаданные с ключом `ssh-keys`.
       
           После удаления этих метаданных вы не сможете подключиться к узлам кластера Managed Service for Kubernetes, пока не добавите один или несколько SSH-ключей.

{% endlist %}

## Изменить метаданные {#update-metadata}

{% note warning %}

Настройки метаданных могут повлиять на поведение и работоспособность узлов в группе. Меняйте эти настройки только если вы точно знаете, что хотите сделать.

Передача пользовательских данных в метаданных с ключом `user-data` не поддерживается.

После изменения метаданных группа узлов временно перейдет в статус `Reconciling`: все узлы в группе будут пересозданы для применения изменений.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
    1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
    1. Нажмите на имя нужного кластера.
    1. Перейдите во вкладку **Группы узлов**.
    1. Выберите нужную группу узлов.
    1. Нажмите кнопку **Редактировать** в правом верхнем углу.
    1. Раскройте блок **Метаданные** и измените, добавьте или удалите метаданные для узлов.

        Чтобы добавить метаданные, используйте кнопку **Добавить поле**. Укажите ключ и значение каждого элемента метаданных в отдельном наборе полей.

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Чтобы добавить или изменить метаданные с определенным ключом:

        1. Посмотрите описание команды CLI для добавления и обновления метаданных группы узлов Managed Service for Kubernetes:

            ```bash
            yc managed-kubernetes node-group add-metadata --help
            ```

        1. Чтобы добавить новые метаданные или изменить их, если они существуют, выполните команду:

            ```bash
            yc managed-kubernetes node-group add-metadata \
              --name <имя_группы_узлов> \
              --metadata <ключ>=<значение>
            ```

            Имя группы узлов можно запросить со [списком групп узлов в каталоге](node-group-list.md#list).

            Перечень существующих метаданных можно запросить вместе с [подробной информацией о группе узлов](node-group-list.md#get).

            {% note tip %}

            Используйте параметр `--metadata-from-file` вместо `--metadata`, если нужно получить значение из файла:

            ```bash
            --metadata-from-file <ключ>=<путь_к_файлу_со_значением>
            ```

            Значение ключа будет считано из файла. Это может быть полезно, если значение слишком длинное, чтобы передавать его в явном виде, или содержит переносы строк и другие спецсимволы.

            {% endnote %}

    1. Чтобы удалить метаданные с определенным ключом:

        1. Посмотрите описание команды CLI для удаления метаданных группы узлов Managed Service for Kubernetes:

            ```bash
            yc managed-kubernetes node-group remove-metadata --help
            ```

        1. Удалите существующие метаданные:

            ```bash
            yc managed-kubernetes node-group remove-metadata \
              --name <имя_группы_узлов> \
              --keys <ключ>
            ```

            Имя группы узлов можно запросить со [списком групп узлов в каталоге](node-group-list.md#list).

            Перечень существующих метаданных можно запросить вместе с [подробной информацией о группе узлов](node-group-list.md#get).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с описанием группы узлов Managed Service for Kubernetes.

        О том, как создать такой файл, см. в разделе [Создание группы узлов](node-group-create.md).

    1. Чтобы добавить, изменить или удалить метаданные с определенным ключом, измените перечень ключей и значений в параметре `instance_template.metadata`. Если такого параметра нет — добавьте его.

        ```hcl
        resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
          cluster_id = yandex_kubernetes_cluster.<имя_кластера>.id
          ...
          instance_template {
            metadata = {
              "<ключ>" = "<значение>"
              ...
            }
            ...
          }
          ...
        }
        ```

        {% note tip %}

        Используйте функцию `file()`, если нужно получить значение из файла:

        ```hcl
        "<ключ>" = file("<путь_к_файлу_со_значением>")
        ```

        Значение ключа будет считано из файла. Это может быть полезно, если значение слишком длинное, чтобы передавать его в явном виде, или содержит переносы строк и другие спецсимволы.

        {% endnote %}

    1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        {% note warning "Ограничения по времени" %}
        
        Провайдер Terraform ограничивает время на выполнение операций с группами узлов кластера Managed Service for Kubernetes:
        
        * создание и изменение — 60 минут;
        * удаление — 20 минут.
        
        Операции, которые длятся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию группы узлов кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
          ...
          timeouts {
            create = "1h30m"
            update = "1h30m"
            delete = "60m"
          }
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

    Подробнее см. в [документации провайдера Terraform](../../../terraform/resources/kubernetes_node_group.md).

- API {#api}

    {% note info %}
    
    Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
    
    {% endnote %}

    1. Получите все существующие метаданные для группы узлов одним из способов:
       
       * Воспользуйтесь методом REST API [get](../../managed-kubernetes/api-ref/NodeGroup/get.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md).
       * Используйте вызов gRPC API [NodeGroupService/Get](../../managed-kubernetes/api-ref/grpc/NodeGroup/get.md).
       
       Передайте в запросе идентификатор группы узлов в параметре `nodeGroupId`. Идентификатор можно запросить со [списком групп узлов в каталоге](node-group-list.md#list).
       
       Метаданные будут перечислены в виде пар `ключ=значение` в поле `nodeTemplate.metadata` ответа.

    1. Воспользуйтесь методом REST API [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) и передайте в запросе:

        * Идентификатор группы узлов в параметре `nodeGroupId`.

        * Параметр `updateMask` со значением `nodeTemplate.metadata`.

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

        * Параметр `nodeTemplate.metadata`, в котором перечислены метаданные группы узлов.

            Внесите нужные изменения в перечень метаданных, который был получен на предыдущем шаге: добавьте, измените или удалите пары `ключ=значение`. Затем передайте обновленный перечень в параметре `nodeTemplate.metadata`.

            {% note alert %}

            Метаданные, не перечисленные в параметре `nodeTemplate.metadata`, будут удалены.

            {% endnote %}

{% endlist %}