[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Управление группой узлов > Управление Kubernetes-метками узлов

# Управление Kubernetes-метками узлов

Отдельные узлы в группах узлов — это виртуальные машины Yandex Compute Cloud с автоматически сгенерированными именами. Чтобы сконфигурировать узлы, воспользуйтесь инструкциями, приведенными ниже, или [другими инструкциями по управлению группами узлов](../index.md#node-group).

{% note alert %}

Не изменяйте параметры ВМ узлов, в том числе имена, сетевые интерфейсы и SSH-ключи, с помощью интерфейсов Compute Cloud или SSH-подключения к ВМ.

Это может нарушить работу отдельных узлов, групп узлов и всего кластера Managed Service for Kubernetes.

{% endnote %}

## Ограничения в именах и значениях Kubernetes-меток {#restrictions}

[Kubernetes-метки](../../concepts/index.md#node-labels) представляют собой пары `ключ:значение`.

Ключи Kubernetes-меток узлов могут состоять из двух частей: префикса и имени, которые разделены знаком `/`.

Префикс — необязательная часть ключа. Требования к префиксу:
* Должен быть поддоменом DNS — серия DNS-меток, разделенных точками `.`.
* Длина — до 253 символов.
* За последним символом — `/`.

Имя — обязательная часть ключа. Требования к имени:
* Длина — до 63 символов.
* Может содержать строчные буквы латинского алфавита, цифры и символы `-_.`.
* Первый и последний символы — буква или цифра.

Для значения действуют те же правила, что и для имени.

Пример метки: `app.kubernetes.io/name: mysql`, где `app.kubernetes.io/` — префикс, `name` — имя, `mysql` — значение.

## Назначить Kubernetes-метки при создании группы узлов {#node-group-creation}

Вы можете добавлять Kubernetes-метки сразу на все узлы Managed Service for Kubernetes в [группе узлов](../../concepts/index.md#node-group). Для этого задайте набор меток в параметре `node_labels` при [создании группы узлов Managed Service for Kubernetes](node-group-create.md).

1. Создайте [кластер Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster).

   Вы можете использовать уже работающий кластер Managed Service for Kubernetes или [создать новый](../kubernetes-cluster/kubernetes-cluster-create.md).

1. Создайте группу узлов с Kubernetes-метками:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан кластер Managed Service for Kubernetes.
     1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
     1. Выберите кластер Managed Service for Kubernetes, для которого необходимо создать группу узлов.
     1. На странице кластера Managed Service for Kubernetes перейдите на вкладку **Управление узлами**.
     1. Нажмите кнопку **Создать группу узлов**.
     1. Введите имя группы узлов Managed Service for Kubernetes.
     1. В поле **Версия Kubernetes** выберите версию Kubernetes для узлов Managed Service for Kubernetes.
     1. В блоке **Масштабирование**:
        * Выберите тип политики масштабирования.
        * Укажите количество узлов в группе узлов Managed Service for Kubernetes.
     1. В блоке **В процессе создания и обновления разрешено** укажите максимальное количество [виртуальных машин](../../../compute/concepts/vm.md), на которое можно превысить и уменьшить размер группы Managed Service for Kubernetes.
     1. В блоке **Вычислительные ресурсы**:
        * Выберите [платформу](../../../compute/concepts/vm-platforms.md).
        * Укажите необходимое количество vCPU и [гарантированную долю vCPU](../../../compute/concepts/performance-levels.md), а также объем RAM.
     1. В блоке **Хранилище**:
        * Укажите **Тип диска** узла Managed Service for Kubernetes:
          * `HDD` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * `SSD` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
          * `Нереплицируемый SSD` — сетевой диск с повышенной производительностью, реализованной за счет устранения избыточности. Размер такого диска можно менять только с шагом 93 ГБ.
          * `SSD IO` — обладает теми же скоростными характеристиками, что и `Нереплицируемый SSD`, и одновременно обеспечивает избыточность. Размер такого диска можно менять только с шагом 93 ГБ.
        * Укажите размер [диска](../../../compute/concepts/disk.md) узла Managed Service for Kubernetes.
     1. В блоке **Сетевые настройки**:
        * В поле **Публичный адрес** выберите способ назначения адреса:
          * `Автоматически` — чтобы назначить узлам случайные [IP-адреса](../../../vpc/concepts/address.md) из пула адресов Yandex Cloud.
          * `Без адреса` — чтобы не назначать публичные IP-адреса.
        * Укажите расположение узлов Managed Service for Kubernetes по [зонам доступности](../../../overview/concepts/geo-scope.md) и [сетям](../../../vpc/concepts/network.md#network).
     1. В блоке **Доступ** укажите данные для доступа на узел Managed Service for Kubernetes:
        * В поле **Логин** введите имя пользователя.
        * В поле **SSH-ключ** вставьте содержимое файла [публичного ключа](../node-connect-ssh.md#creating-ssh-keys).
     1. В блоке **Настройки окна обновлений**:
        * В поле **Частота обновлений / Отключение** выберите окно для [обновлений](../../concepts/release-channels-and-updates.md#updates):
          * `Отключено` — отключение автоматических обновлений.
          * `В любое время` — обновления разрешены в любое время.
          * `Ежедневно` — обновления будут происходить во временной интервал, указанный в поле **Начало окна обновления в UTC**.
          * `В выбранные дни` — обновления будут происходить во временной интервал, указанный в поле **Расписание по дням**.
     1. В блоке **Дополнительно**:
        * В поле **Метки узла** нажмите кнопку **Добавить метку** и укажите ее ключ и значение. Если необходимо, добавьте несколько меток.
     1. Нажмите кнопку **Создать**.

   - CLI {#cli}

     Создайте группу узлов Managed Service for Kubernetes:

     ```bash
     yc managed-kubernetes node-group create \
      --name k8s-labels-node \
      --cluster-name k8s-labels \
      --disk-type network-ssd \
      --fixed-size 1 \
      --node-labels environment=production,apps/tier=backend
     ```

     Где:

     * `--name` — имя группы узлов Managed Service for Kubernetes.
     * `--cluster-name` — имя кластера Managed Service for Kubernetes, в котором будет создана группа узлов.
     * `--disk-type` — [тип диска](../../../compute/concepts/disk.md) узла Managed Service for Kubernetes.
     * `--fixed-size` — количество узлов Managed Service for Kubernetes в группе.
     * `--node-labels` — метки узла Managed Service for Kubernetes. Можно указать несколько меток через запятую.

     Результат:

     ```text
     done (2m19s)
     id: catkuapro07e********
     cluster_id: abcsk1s2f3fm********
     created_at: "2020-09-24T13:32:24Z"
     name: k8s-labels-node
     status: RUNNING
     node_template:
       platform_id: standard-v2
       resources_spec:
         memory: "4294967296"
         cores: "2"
         core_fraction: "100"
       boot_disk_spec:
         disk_type_id: network-ssd
         disk_size: "103079215104"
       v4_address_spec: {}
       scheduling_policy: {}
     scale_policy:
       fixed_scale:
         size: "1"
     allocation_policy:
       locations:
       - zone_id: ru-central1-a
         subnet_id: e9bm87gkjd81********
     deploy_policy:
       max_expansion: "3"
     instance_group_id: cl1v2gh33j1c********
     node_version: "1.17"
     version_info:
       current_version: "1.17"
     maintenance_policy:
       auto_upgrade: true
       auto_repair: true
       maintenance_window:
         anytime: {}
     node_labels:
       apps/tier: backend
       environment: production
     ```

   - Terraform {#tf}

     {% note warning %}

     Группа узлов Managed Service for Kubernetes будет создана заново.

     {% endnote %}

     1. Откройте актуальный конфигурационный файл с описанием группы узлов Managed Service for Kubernetes.

        О том, как создать такой файл, читайте в разделе [Создание группы узлов](node-group-create.md).
     1. Добавьте к описанию группы узлов Managed Service for Kubernetes параметр `node_labels`:

        ```hcl
        resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
          cluster_id = yandex_kubernetes_cluster.<имя_кластера>.id
          ...
          node_labels = {
            "<метка_1>" = "<значение_1>"
            "<метка_2>" = "<значение_2>"
            ...
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

        Подробнее в [документации провайдера Terraform](../../../terraform/resources/kubernetes_node_group.md).

   - API {#api}

     Чтобы создать группу узлов Managed Service for Kubernetes, воспользуйтесь методом REST API [create](../../managed-kubernetes/api-ref/NodeGroup/create.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Create](../../managed-kubernetes/api-ref/grpc/NodeGroup/create.md).

   {% endlist %}

1. Посмотрите информацию о созданной группе узлов с Kubernetes-метками:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором создан кластер Managed Service for Kubernetes.
     1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
     1. Выберите кластер Managed Service for Kubernetes, в котором создана группа узлов.
     1. На странице кластера Managed Service for Kubernetes перейдите на вкладку **Управление узлами**.
     1. На странице одного из узлов Managed Service for Kubernetes перейдите на вкладку **Метки**. На вкладке перечислены системные и пользовательские Kubernetes-метки узла.

   - CLI {#cli}

     1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
     1. Посмотрите все узлы кластера Managed Service for Kubernetes:

        ```bash
        kubectl get nodes
        ```

        Результат:

        ```bash
        NAME                        STATUS   ROLES    AGE  VERSION
        catkuapro07e********-hgjd   Ready    <none>   1h   v1.17.8
        catkuapro07e********-lskc   Ready    <none>   1h   v1.17.8
        ```

     1. Посмотрите информацию о выбранном узле кластера Managed Service for Kubernetes:

        ```bash
        kubectl describe node catkuapro07e********-hgjd
        ```

        Результат:

        ```bash
        Name:               catkuapro07e********-hgjd
        Roles:              <none>
        Labels:             apps/tier=backend
                            beta.kubernetes.io/arch=amd64
                            beta.kubernetes.io/instance-type=standard-v2
                            beta.kubernetes.io/os=linux
                            environment=production
                            failure-domain.beta.kubernetes.io/zone=ru-central1-a
                            kubernetes.io/arch=amd64
                            kubernetes.io/hostname=catkuapro07e********-hgjd
                            kubernetes.io/os=linux
                            node.kubernetes.io/kube-proxy-ds-ready=true
                            node.kubernetes.io/masq-agent-ds-ready=true
                            node.kubernetes.io/node-problem-detector-ds-ready=true
                            yandex.cloud/node-group-id=catkuapro07e********
                            yandex.cloud/pci-topology=k8s
                            yandex.cloud/preemptible=false
        ```

   - API {#api}

     Чтобы посмотреть информацию об узле Managed Service for Kubernetes, воспользуйтесь методом REST API [list](../../managed-kubernetes/api-ref/NodeGroup/list.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/List](../../managed-kubernetes/api-ref/grpc/NodeGroup/list.md).

   {% endlist %}

## Назначить Kubernetes-метку на уже созданную группу узлов {#assign-label}

Назначение Kubernetes-меток не приводит к пересозданию группы узлов.

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы назначить Kubernetes-метку на уже созданную группу узлов, выполните команду:

  ```bash
  yc managed-kubernetes node-group add-node-labels \
     --id <идентификатор_группы_узлов> \
     --labels <ключ>=<значение>, ...
  ```

  Команда содержит параметры:

  * `--id` — идентификатор группы узлов. Его можно [получить вместе со списком](node-group-list.md#list) групп узлов в кластере Managed Service for Kubernetes.
  * `--labels` — Kubernetes-метки в формате `<ключ>=<значение>`. Можно указать одну или несколько меток через запятую.

- Terraform {#tf}

  Чтобы назначить Kubernetes-метку на уже созданную группу узлов:

  1. Откройте актуальный конфигурационный файл Terraform с описанием группы узлов Managed Service for Kubernetes.

     О том, как создать такой файл, читайте в разделе [Создание группы узлов](node-group-create.md).

  1. В описании группы узлов добавьте блок `node_labels`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       node_labels {
         "<имя_метки>" = "<значение_метки>"
         ...
       }
       ...
     }
     ```

     Можно назначить несколько меток. Для этого укажите каждую метку на отдельной строке.

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

     Подробнее в [документации провайдера Terraform](../../../terraform/resources/kubernetes_node_group.md).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Чтобы назначить Kubernetes-метку на уже созданную группу узлов, воспользуйтесь методом REST API [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) и передайте в запросе:

  * Kubernetes-метки в параметре `nodeLabels`.
  * Обновляемый параметр `nodeLabels` в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}

## Снять Kubernetes-метку с группы узлов {#remove-label}

Удаление Kubernetes-меток не приводит к пересозданию группы узлов.

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы снять Kubernetes-метку с группы узлов, выполните команду:

  ```bash
  yc managed-kubernetes node-group remove-node-labels \
     --id <идентификатор_группы_узлов> \
     --labels <ключ_метки>, ...
  ```

  Команда содержит параметры:

  * `--id` — идентификатор группы узлов. Его можно [получить вместе со списком](node-group-list.md#list) групп узлов в кластере Managed Service for Kubernetes.
  * `--labels` — ключи Kubernetes-меток, которые надо снять. Можно указать одну или несколько меток через запятую.

- Terraform {#tf}

  Чтобы снять Kubernetes-метку с группы узлов:

  1. Откройте актуальный конфигурационный файл Terraform с описанием группы узлов Managed Service for Kubernetes.

     О том, как создать такой файл, читайте в разделе [Создание группы узлов](node-group-create.md).

  1. Удалите из описания группы узлов ненужные Kubernetes-метки в блоке `node_labels`.

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

     Подробнее в [документации провайдера Terraform](../../../terraform/resources/kubernetes_node_group.md).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Чтобы снять Kubernetes-метку с группы узлов, воспользуйтесь методом REST API [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) и передайте в запросе:

  * Новый набор Kubernetes-меток в параметре `nodeLabels`. Если вы хотите снять все метки, передайте в запросе `"nodeLabels": {}`.
  * Обновляемый параметр `nodeLabels` в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}