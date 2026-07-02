[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Управление группой узлов > Создание группы узлов

# Создание группы узлов


[Группа узлов](../../concepts/index.md#node-group) — это группа виртуальных машин с одинаковой конфигурацией в [кластере Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster), на которых запускаются пользовательские контейнеры.

Перед тем как создавать группу узлов, [создайте](../kubernetes-cluster/kubernetes-cluster-create.md) кластер Managed Service for Kubernetes и убедитесь, что в [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) достаточно [свободных ресурсов](../../concepts/limits.md).

{% note warning %}

Начиная с Kubernetes версии 1.30 во всех [релизных каналах](../../concepts/release-channels-and-updates.md) базовый образ узлов кластера Managed Service for Kubernetes изменен с Ubuntu 20.04 на Ubuntu 22.04. В существующих кластерах и группах узлов версия операционной системы будет повышена в соответствии с выбранным способом обновления.

Особенности и рекомендации по обновлению ОС приведены в разделе [Обновление операционной системы в группе узлов](../../concepts/node-os-update.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать [группу узлов Managed Service for Kubernetes](../../concepts/index.md#node-group):
  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан [кластер Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster).
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер Managed Service for Kubernetes, для которого необходимо создать группу узлов.
  1. На странице кластера Managed Service for Kubernetes перейдите на вкладку **Управление узлами**.
  1. Нажмите кнопку **Создать группу узлов**.
  1. Введите имя и описание группы узлов Managed Service for Kubernetes.
  1. В поле **Версия Kubernetes** выберите версию Kubernetes для узлов Managed Service for Kubernetes.
  1. В поле **Среда запуска контейнеров** выберите `containerd`.
  1. В поле **Метки** добавьте [облачные метки узлов](../../concepts/index.md#node-labels).
  
  1. В блоке **Масштабирование** выберите его тип:
     * `Фиксированный` — чтобы количество узлов Managed Service for Kubernetes в группе оставалось неизменным. Укажите количество узлов Managed Service for Kubernetes в группе.
  
       При этом станет доступна настройка **Кол-во узлов**.
     * `Автоматический` — чтобы управлять количеством узлов в группе с помощью [автоматического масштабирования кластера Managed Service for Kubernetes](../../concepts/autoscale.md#ca).
  
       При этом станут доступны настройки:
       * **Минимальное кол-во узлов**.
       * **Максимальное кол-во узлов**.
       * **Начальное кол-во узлов**, с которым будет создана группа Managed Service for Kubernetes.
  
     {% note warning %}
  
     Тип масштабирования нельзя изменить после создания группы узлов Managed Service for Kubernetes.
  
     {% endnote %}
  
  1. В блоке **В процессе создания и обновления разрешено** укажите максимальное количество узлов, на которое можно превысить размер группы при ее обновлении, а также максимальное количество недоступных при обновлении узлов.
  
     {% note warning %}
     
     Если в настройках группы узлов разрешено автоматическое расширение размера группы при обновлении, убедитесь, что в вашем облаке достаточно [ресурсов](../../concepts/limits.md). При необходимости [увеличьте](../../../quota-manager/operations/set-quotas.md) квоты.
     
     {% endnote %}
  
  1. В блоке **Вычислительные ресурсы**:
     * Выберите [платформу](../../../compute/concepts/vm-platforms.md).     
     * Укажите необходимое количество [GPU](../../../compute/concepts/gpus.md), vCPU и [гарантированную долю vCPU](../../../compute/concepts/performance-levels.md), а также объем RAM.
     * (Опционально) Укажите, что ВМ должна быть [прерываемой](../../../compute/concepts/preemptible-vm.md).
  
        
        {% note tip %}
        
        Для автоматического расселения подов с прерываемого узла при его выключении используйте продукт Yandex Cloud Marketplace [node-sitter](../applications/node-sitter.md).
        
        {% endnote %}
        
  
     * (Опционально) Включите [программно ускоренную сеть](../../../compute/concepts/software-accelerated-network.md).
  
       {% note warning %}
       
       Перед включением [программно ускоренной сети](../../../compute/concepts/software-accelerated-network.md) убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../concepts/limits.md) для создания одного дополнительного [узла Managed Service for Kubernetes](../../concepts/index.md#node-group).
       
       {% endnote %}
  
     {% note info %}
  
     Набор параметров зависит от выбранной платформы.
  
     {% endnote %}
  
  1. (Опционально) В блоке **Настройки GPU** укажите, если группа узлов Managed Service for Kubernetes должна быть без предустановленных драйверов NVIDIA® и библиотек CUDA® для [GPU-ускорения](../../../compute/concepts/gpus.md).
  1. (Опционально) В блоке **Размещение** укажите имя [группы размещения](../../../compute/concepts/placement-groups.md) для узлов Managed Service for Kubernetes. Эту настройку невозможно изменить после создания группы узлов Managed Service for Kubernetes.
  
      {% note info %}
      
      От группы размещения зависит максимально доступный размер группы узлов:
      
      * В группе ВМ со стратегией [распределенного размещения](../../../compute/concepts/placement-groups.md#spread) максимальное число ВМ определяется [лимитами](../../../compute/concepts/limits.md#compute-limits-vm).
      * В группе ВМ со стратегией [размещения разделами](../../../compute/concepts/placement-groups.md#partition) максимальное число ВМ в разделе определяется [квотами](../../../compute/concepts/limits.md#vm-quotas).
      
      
      {% endnote %}
  
  1. В блоке **Хранилище**:
     * Укажите **Тип диска** узла Managed Service for Kubernetes:
       * `HDD` — [стандартный сетевой диск](../../../compute/concepts/disk.md#disks-types), сетевое блочное хранилище на HDD-накопителе.
       * `SSD` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
       * `Нереплицируемый SSD` — сетевой диск с повышенной производительностью, реализованной за счет устранения избыточности. Размер такого диска можно менять только с шагом 93 ГБ.
  
         {% note alert %}
         
         Нереплицируемые диски не имеют резервирования. При выходе диска из строя данные будут утеряны безвозвратно. Подробнее в разделе [Нереплицируемые диски и сверхбыстрые сетевые хранилища с тремя репликами (SSD)](../../../compute/concepts/disk.md#nr-disks).
         
         {% endnote %}
  
       * `SSD IO` — обладает теми же скоростными характеристиками, что и `Нереплицируемый SSD`, и одновременно обеспечивает избыточность. Размер такого диска можно менять только с шагом 93 ГБ.
  
     * Укажите размер диска узла Managed Service for Kubernetes.
  1. В блоке **Сетевые настройки**:
     * В поле **Публичный адрес** выберите способ назначения адреса:
       * `Автоматически` — чтобы назначить узлам случайные [IP-адреса](../../../vpc/concepts/address.md) из пула адресов Yandex Cloud.
       * `Без адреса` — чтобы не назначать публичные IP-адреса.
  
       Публичные IP-адреса необходимы для [подключения](../connect/index.md) к узлам из интернета и для подключения узлов к внешним ресурсам, например реестрам Docker-образов ([Container Registry](../../../container-registry/concepts/index.md), [Cloud Registry](../../../cloud-registry/concepts/index.md) или [Docker Hub](https://hub.docker.com/)), а также бакетам [Object Storage](../../../storage/concepts/bucket.md).
       
       Чтобы обеспечить узлам доступ в интернет, назначьте им публичный IP-адрес и [настройте](../connect/security-groups.md#rules-internal-nodegroup) группу безопасности. Также в качестве альтернативы публичным IP-адресам можно создать и настроить в подсети узлов [NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../../vpc/tutorials/nat-instance/index.md).
       
       Если вы назначили узлам кластера публичные IP-адреса и затем настроили NAT-шлюз или NAT-инстанс, доступ в интернет через публичные адреса пропадет. Подробнее читайте в [документации Yandex Virtual Private Cloud](../../../vpc/concepts/routing.md#internet-routes).
  
     * Выберите [группы безопасности](../../../vpc/concepts/security-groups.md).
  
       {% note warning %}
       
       От [настройки групп безопасности](../connect/security-groups.md) зависит работоспособность и доступность кластера, а также запущенных в нем сервисов.
       
       {% endnote %}
  
  1. В блоке **Расположение**:
     * Укажите [зону доступности](../../../overview/concepts/geo-scope.md) и [подсеть](../../../vpc/concepts/network.md#subnet), в которых вы хотите разместить узлы группы.
  
         {% note warning %}
         
         Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
         
         {% endnote %}
  
     * (Опционально) Вы можете разместить узлы группы с фиксированным типом масштабирования в нескольких зонах доступности, для этого нажмите кнопку **Добавить расположение** и укажите дополнительную зону доступности и подсеть.
  
     {% note warning %}
     
     Размещение узлов автомасштабируемой группы возможно только в одной [зоне доступности](../../../overview/concepts/geo-scope.md).
     
     {% endnote %}
  
  1. В блоке **Доступ** настройте один из способов подключения к узлам в группе узлов Managed Service for Kubernetes:
  
      * Чтобы подключаться к узлам через OS Login, выберите опцию **Доступ по OS Login**.
  
          При выборе этой опции будет нельзя указать SSH-ключи, так как эти способы подключения являются взаимоисключающими.
  
          Настройка и использование OS Login подробно рассмотрены в разделе [Подключение к узлу через OS Login](../node-connect-oslogin.md).
  
      * Чтобы подключаться к узлам с использованием SSH-ключей, укажите необходимые реквизиты:
  
          * В поле **Логин** введите имя пользователя.
  
          * В поле **SSH-ключ** вставьте содержимое файла [публичного ключа](../node-connect-ssh.md#creating-ssh-keys).
  
          Подготовка реквизитов, настройка и использование SSH-ключей подробно рассмотрены в разделе [Подключение к узлу по SSH](../node-connect-ssh.md).
  
      Перечень метаданных можно [изменить после создания кластера](node-group-update.md#switch-node-connect-mode).
  
  1. В блоке **Настройки окна обновлений**:
     * В поле **Частота обновлений / Отключение** выберите окно для обновлений:
       * `Отключено` — отключение автоматических обновлений.
       * `В любое время` — обновления разрешены в любое время.
       * `Ежедневно` — обновления будут происходить во временной интервал, указанный в поле **Начало окна обновления в UTC**.
       * `В выбранные дни` — обновления будут происходить во временной интервал, указанный в поле **Расписание по дням**.
  1. В блоке **Дополнительно**:
     * Чтобы иметь возможность изменять [небезопасные параметры ядра](../../concepts/index.md#node-group) на узлах группы Managed Service for Kubernetes, используйте кнопку **Добавить переменную**. Для ввода имени каждого параметра ядра создайте отдельное поле.
     * Чтобы задать [taint-политики узлов Managed Service for Kubernetes](../../concepts/index.md#taints-tolerations), используйте кнопку **Добавить политику**. Укажите ключ, значение и эффект каждой taint-политики в отдельном наборе полей.
     * Чтобы задать [Kubernetes-метки](../../concepts/index.md#node-labels) узлов группы, используйте кнопку **Добавить метку**. Укажите ключ и значение каждой Kubernetes-метки в отдельном наборе полей.
  
  1. (Опционально) Раскройте блок **Метаданные** и добавьте метаданные для узлов.
  
      {% note warning %}
  
      Настройки метаданных могут повлиять на поведение и работоспособность узлов в группе. Меняйте эти настройки только если вы точно знаете, что хотите сделать.
      
      Передача пользовательских данных в метаданных с ключом `user-data` не поддерживается.
  
      {% endnote %}
  
      Чтобы добавить метаданные, используйте кнопку **Добавить поле**. Укажите ключ и значение каждого элемента метаданных в отдельном наборе полей.
  
      Перечень метаданных можно [изменить после создания кластера](node-group-update.md#switch-node-connect-mode).
  
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания группы узлов Managed Service for Kubernetes:

     ```bash
     yc managed-kubernetes node-group create --help
     ```

  1. Укажите параметры группы узлов Managed Service for Kubernetes в команде создания (в примере приведены не все доступные параметры):

     ```bash
     yc managed-kubernetes node-group create \
       --allowed-unsafe-sysctls <имена_небезопасных_параметров_ядра> \
       --cluster-name <имя_кластера> \
       --cores <количество_vCPU> \
       --core-fraction <гарантированная_доля_vCPU> \
       --daily-maintenance-window <настройки_окна_обновлений> \
       --disk-size <размер_хранилища_ГБ> \
       --disk-type <тип_хранилища> \
       --fixed-size <фиксированное_количество_узлов_в_группе> \
       --max-expansion <расширение_размера_группы_при_обновлении> \
       --max-unavailable <количество_недоступных_узлов_при_обновлении> \
       --location zone=[<зона_доступности>],subnet-id=[<идентификатор_подсети>] \
       --memory <количество_ГБ_RAM> \
       --name <имя_группы_узлов> \
       --network-acceleration-type <тип_ускорения_сети> \
       --network-interface security-group-ids=[<идентификаторы_групп_безопасности>],ipv4-address=<способ_назначения_IP-адреса> \
       --platform-id <идентификатор_платформы> \
       --container-runtime containerd \
       --preemptible \
       --public-ip \
       --template-labels <ключ_облачной_метки=значение_облачной_метки> \
       --node-labels <ключ_k8s-метки=значение_k8s-метки>
       --version <версия_Kubernetes_на_узлах_группы> \
       --node-name <шаблон_имени_узлов> \
       --node-taints <taint-политики> \
       --container-network-settings pod-mtu=<значение_MTU_для_подов_группы> \
       --max-expansion <предел_расширения_группы_узлов> \
       --max-unavailable <предел_недоступных_узлов> \
       --reserved-instance-pool-id <идентификатор_пула_резервов>
     ```

     Где:
     * `--allowed-unsafe-sysctls` — разрешение на использование узлами группы Managed Service for Kubernetes [небезопасных параметров ядра](../../concepts/index.md#node-group), через запятую.
     * `--cluster-name` — имя [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster), в котором будет создана группа узлов.
     * `--cores` — количество vCPU для узлов Managed Service for Kubernetes.
     * `--core-fraction` — [гарантированная доля vCPU](../../../compute/concepts/performance-levels.md) для узлов Managed Service for Kubernetes.
     * `--daily-maintenance-window` — настройки окна [обновлений](../../concepts/release-channels-and-updates.md#updates).
     * `--disk-size` — [размер диска](../../../compute/concepts/disk.md#maximum-disk-size) узла Managed Service for Kubernetes.
     * `--disk-type` — [тип диска](../../../compute/concepts/disk.md#disks_types) узла Managed Service for Kubernetes: `network-nvme` или `network-hdd`.
     * Тип масштабирования:

       * `--fixed-size` — фиксированное количество узлов в группе узлов Managed Service for Kubernetes.
       * `--auto-scale` — настройки [автоматического масштабирования кластера Managed Service for Kubernetes](../../concepts/node-group/cluster-autoscaler.md):

         * `min` — минимальное количество узлов в группе.
         * `max` — максимальное количество узлов в группе.
         * `initial` — начальное количество узлов в группе.

       Тип масштабирования нельзя изменить после создания группы узлов.

     * `--max-expansion` — максимальное количество узлов, на которое можно увеличить размер группы при ее обновлении.

       {% note warning %}
       
       Если в настройках группы узлов разрешено автоматическое расширение размера группы при обновлении, убедитесь, что в вашем облаке достаточно [ресурсов](../../concepts/limits.md). При необходимости [увеличьте](../../../quota-manager/operations/set-quotas.md) квоты.
       
       {% endnote %}

     * `--max-unavailable` — максимальное количество недоступных узлов группы при ее обновлении.
     * `--location` — [зона доступности](../../../overview/concepts/geo-scope.md) и [подсеть](../../../vpc/concepts/network.md#subnet), в которых будут расположены узлы Managed Service for Kubernetes. Можно указать несколько вариантов, но нельзя указывать несколько подсетей для одной зоны. Для каждой зоны доступности следует использовать отдельный параметр `--location`.

       {% note warning %}
       
       Размещение узлов автомасштабируемой группы возможно только в одной [зоне доступности](../../../overview/concepts/geo-scope.md).
       
       {% endnote %}

       Если в одной команде передать параметры `--location`, `--network-interface` и `--public-ip`, [возникнет ошибка](../../qa/troubleshooting.md#conflicting-flags). Расположение группы узлов Managed Service for Kubernetes достаточно указать в `--location` или `--network-interface`.

       Чтобы выдать доступ в интернет узлам кластера Managed Service for Kubernetes, выполните одно из действий:
       * Назначьте [публичные IP-адреса](../../../vpc/concepts/address.md#public-addresses) узлам кластера, указав `--network-interface ipv4-address=nat` или `--network-interface ipv6-address=nat`.
       * [Включите доступ к узлам Managed Service for Kubernetes из интернета](node-group-update.md#node-internet-access) после того, как создадите группу узлов.

       {% note warning %}
       
       Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
       
       {% endnote %}

     * `--memory` — количество памяти для узлов Managed Service for Kubernetes.
     * `--name` — имя группы узлов Managed Service for Kubernetes.
     * `--network-acceleration-type` — выбор типа [ускорения сети](../../../compute/concepts/software-accelerated-network.md):
       * `standard` — без ускорения.
       * `software-accelerated` — программно ускоренная сеть.

       {% note warning %}
       
       Перед включением [программно ускоренной сети](../../../compute/concepts/software-accelerated-network.md) убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../concepts/limits.md) для создания одного дополнительного [узла Managed Service for Kubernetes](../../concepts/index.md#node-group).
       
       {% endnote %}

     * `--network-interface` — настройки сети:

       * `security-group-ids` — идентификаторы [групп безопасности](../connect/security-groups.md).
       * `subnets` — имена подсетей, в которых будут размещаться узлы.
       * `ipv4-address` — способ назначения IPv4-адресов.
       * `ipv6-address` — способ назначения IPv6-адресов.
       
       Параметры `ipv4-address` и `ipv6-address` отвечают за способ назначения IP-адресов:
       * `auto` — узлам будут присвоены только внутренние IP-адреса.
       * `nat` — узлам будут присвоены публичные и внутренние IP-адреса.
       
       Публичные IP-адреса необходимы для [подключения](../connect/index.md) к узлам из интернета и для подключения узлов к внешним ресурсам, например реестрам Docker-образов ([Container Registry](../../../container-registry/concepts/index.md), [Cloud Registry](../../../cloud-registry/concepts/index.md) или [Docker Hub](https://hub.docker.com/)), а также бакетам [Object Storage](../../../storage/concepts/bucket.md).
       
       Чтобы обеспечить узлам доступ в интернет, назначьте им публичный IP-адрес и [настройте](../connect/security-groups.md#rules-internal-nodegroup) группу безопасности. Также в качестве альтернативы публичным IP-адресам можно создать и настроить в подсети узлов [NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../../vpc/tutorials/nat-instance/index.md).
       
       Если вы назначили узлам кластера публичные IP-адреса и затем настроили NAT-шлюз или NAT-инстанс, доступ в интернет через публичные адреса пропадет. Подробнее читайте в [документации Yandex Virtual Private Cloud](../../../vpc/concepts/routing.md#internet-routes).

     * `--platform-id` — [платформа](../../../compute/concepts/vm-platforms.md) для узлов Managed Service for Kubernetes.
     * `--container-runtime` — среда запуска контейнеров [containerd](https://containerd.io/).
     * `--preemptible` — флаг, который указывается, если виртуальные машины должны быть [прерываемыми](../../../compute/concepts/preemptible-vm.md).

        
        {% note tip %}
        
        Для автоматического расселения подов с прерываемого узла при его выключении используйте продукт Yandex Cloud Marketplace [node-sitter](../applications/node-sitter.md).
        
        {% endnote %}


     * `--public-ip` — флаг, который указывается, если группе узлов Managed Service for Kubernetes требуется [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses).
     * `--template-labels` — [облачные метки](../../concepts/index.md#node-labels) группы узлов. Можно указать несколько меток через запятую.
     * `--node-labels` — [Kubernetes-метки](../../concepts/index.md#node-labels) группы узлов.
     * `--version` — версия Kubernetes на узлах группы Managed Service for Kubernetes.
     * `--node-name` — шаблон имени узлов Managed Service for Kubernetes. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

       * `{instance_group.id}` — идентификатор группы ВМ.
       * `{instance.index}` — уникальный номер ВМ в группе. Возможные значения: от 1 до N, где N — количество ВМ в группе.
       * `{instance.index_in_zone}` — номер ВМ в зоне. Уникален в рамках зоны для конкретной группы ВМ.
       * `{instance.short_id}` — идентификатор ВМ, уникальный в рамках группы. Состоит из четырех букв.
       * `{instance.zone_id}`— идентификатор зоны.
       
       Например, `prod-{instance.short_id}-{instance_group.id}`. Если имя не задано, используется значение по умолчанию: `{instance_group.id}-{instance.short_id}`.

     * `--node-taints` — [taint-политики](../../concepts/index.md#taints-tolerations) Kubernetes. Можно указать несколько политик.
     * `--container-network-settings` — значение [MTU](https://ru.wikipedia.org/wiki/Maximum_transmission_unit) для сетевых соединений с подами группы. Настройка не применима для кластеров с контроллерами сетевых политик Calico или Cilium.
     * `--reserved-instance-pool-id` — [идентификатор](../../../compute/cli-ref/reserved-instance-pool/list.md) пула резервов ВМ. Подробнее читайте на странице [Создание группы с узлами из пула резервов ВМ Yandex Compute Cloud](node-group-create-in-instance-pool.md).
     * Параметры [политики развертывания](../../concepts/node-group/deploy-policy.md) (deploy policy):

        * `--max-expansion` — максимальное количество узлов, на которое можно расширить группу при ее изменении или обновлении. Значение по умолчанию — `3`.
        * `--max-unavailable` — максимальное количество узлов, которые могут быть недоступны в ходе изменения или обновления группы. Значение по умолчанию — `0`.
        
        Подробнее в разделе [Политика развертывания группы узлов в Managed Service for Kubernetes](../../concepts/node-group/deploy-policy.md).

     Результат:

     ```text
     done (1m17s)
     id: catpl8c44kii********
     cluster_id: catcsqidoos7********
     ...
         start_time:
           hours: 22
         duration: 36000s
     ```

  1. Чтобы добавить метаданные для узлов, используйте параметр `--metadata` или `--metadata-from-file`.

        Способ подключения к узлам в группе узлов настраивается с помощью метаданных. Допустимо настроить только один из способов, так как они являются взаимоисключающими.
        
        Чтобы получить возможность подключаться к узлам в группе узлов, укажите метаданные для выбранного способа подключения:
        
        * Чтобы подключаться к узлам через OS Login, добавьте метаданные с ключом `enable-oslogin` и значением `true`.
        
            Настройка и использование OS Login подробно рассмотрены в разделе [Подключение к узлу через OS Login](../node-connect-oslogin.md).
        
        * Чтобы подключаться к узлам с использованием SSH-ключей, добавьте метаданные с ключом `ssh-keys` и значением, в котором содержится перечень реквизитов для подключения.
        
            Подготовка реквизитов, настройка и использование SSH-ключей подробно рассмотрены в разделе [Подключение к узлу по SSH](../node-connect-ssh.md).

        {% note warning %}

        Настройки метаданных могут повлиять на поведение и работоспособность узлов в группе. Меняйте эти настройки только если вы точно знаете, что хотите сделать.
        
        Передача пользовательских данных в метаданных с ключом `user-data` не поддерживается.

        {% endnote %}

        Добавьте метаданные одним из способов:

        * С помощью `--metadata`: укажите одну или несколько пар `ключ=значение`, разделенных запятыми.

            Значение ключа передается в явном виде.

        * С помощью `--metadata-from-file`: укажите одну или несколько пар `ключ=путь_к_файлу_со_значением`, разделенных запятыми.

            Значение ключа будет считано из файла. Это может быть полезно, если значение слишком длинное, чтобы передавать его в явном виде, или содержит переносы строк и другие спецсимволы.

        Перечень метаданных можно [изменить после создания кластера](node-group-update.md#switch-node-connect-mode).

  1. Чтобы указать [группу размещения](../../../compute/concepts/placement-groups.md) для узлов Managed Service for Kubernetes:
     1. Получите список групп размещения с помощью команды `yc compute placement-group list`.
     1. Передайте имя или идентификатор группы размещения в параметре `--placement-group` при создании группы узлов Managed Service for Kubernetes:

        ```bash
        yc managed-kubernetes node-group create \
        ...
          --placement-group <имя_или_идентификатор_группы_размещения>
        ```

      {% note info %}
      
      От группы размещения зависит максимально доступный размер группы узлов:
      
      * В группе ВМ со стратегией [распределенного размещения](../../../compute/concepts/placement-groups.md#spread) максимальное число ВМ определяется [лимитами](../../../compute/concepts/limits.md#compute-limits-vm).
      * В группе ВМ со стратегией [размещения разделами](../../../compute/concepts/placement-groups.md#partition) максимальное число ВМ в разделе определяется [квотами](../../../compute/concepts/limits.md#vm-quotas).
      
      
      {% endnote %}

- Terraform {#tf}

  Чтобы создать [группу узлов Managed Service for Kubernetes](../../concepts/index.md#node-group):

  1. В каталоге с [файлом описания кластера](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) создайте конфигурационный файл, содержащий параметры новой группы узлов Managed Service for Kubernetes.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       cluster_id = yandex_kubernetes_cluster.<имя_кластера>.id
       name       = "<имя_группы_узлов>"
       ...
       instance_template {
         name       = "<шаблон_имени_узлов>"
         platform_id = "<платформа_для_узлов>"
         placement_policy {
           placement_group_id = "<группа_размещения>"
         }
         network_acceleration_type = "<тип_ускорения_сети>"
         container_runtime {
           type = "containerd"
         }
         network_interface {
           nat = <назначить_публичные_IP-адреса>
         }
         labels {
           "<имя_облачной_метки>"="<значение_облачной_метки>"
         }
         node_labels {
           "<имя_Kubernetes-метки>"="<значение_Kubernetes-метки>"
         }
         ...
       }
       ...
       scale_policy {
         <настройки_масштабирования_группы_узлов>
       }
       deploy_policy {
         max_expansion   = <расширение_размера_группы_при_обновлении>
         max_unavailable = <количество_недоступных_узлов_при_обновлении>
       }
       ...
       allocation_policy {
         location {
           zone = "<зона_доступности>"
         }
       }
     }
     ```

     Где:
     * `cluster_id` — идентификатор [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster).
     * `name` — имя группы узлов Managed Service for Kubernetes.
     * `instance_template` — параметры узлов Managed Service for Kubernetes:
       * `name` — шаблон имени узлов Managed Service for Kubernetes. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

         * `{instance_group.id}` — идентификатор группы ВМ.
         * `{instance.index}` — уникальный номер ВМ в группе. Возможные значения: от 1 до N, где N — количество ВМ в группе.
         * `{instance.index_in_zone}` — номер ВМ в зоне. Уникален в рамках зоны для конкретной группы ВМ.
         * `{instance.short_id}` — идентификатор ВМ, уникальный в рамках группы. Состоит из четырех букв.
         * `{instance.zone_id}`— идентификатор зоны.
         
         Например, `prod-{instance.short_id}-{instance_group.id}`. Если имя не задано, используется значение по умолчанию: `{instance_group.id}-{instance.short_id}`.

       * `platform_id` — [платформа](../../../compute/concepts/vm-platforms.md) для узлов Managed Service for Kubernetes.
       * `placement_group_id` — [группа размещения](../../../compute/concepts/placement-groups.md) для узлов Managed Service for Kubernetes.

          {% note info %}
          
          От группы размещения зависит максимально доступный размер группы узлов:
          
          * В группе ВМ со стратегией [распределенного размещения](../../../compute/concepts/placement-groups.md#spread) максимальное число ВМ определяется [лимитами](../../../compute/concepts/limits.md#compute-limits-vm).
          * В группе ВМ со стратегией [размещения разделами](../../../compute/concepts/placement-groups.md#partition) максимальное число ВМ в разделе определяется [квотами](../../../compute/concepts/limits.md#vm-quotas).
          
          
          {% endnote %}

       * `network_acceleration_type` — тип [ускорения сети](../../../compute/concepts/software-accelerated-network.md):
         * `standard` — без ускорения.
         * `software-accelerated` — программно ускоренная сеть.

         {% note warning %}
         
         Перед включением [программно ускоренной сети](../../../compute/concepts/software-accelerated-network.md) убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../concepts/limits.md) для создания одного дополнительного [узла Managed Service for Kubernetes](../../concepts/index.md#node-group).
         
         {% endnote %}

       * `container_runtime`, `type` — среда запуска контейнеров [containerd](https://containerd.io/).
       * `network_interface.nat` — назначение узлам случайных публичных [IP-адресов](../../../vpc/concepts/address.md) из пула адресов Yandex Cloud: `true` или `false`.

         Публичные IP-адреса необходимы для [подключения](../connect/index.md) к узлам из интернета и для подключения узлов к внешним ресурсам, например реестрам Docker-образов ([Container Registry](../../../container-registry/concepts/index.md), [Cloud Registry](../../../cloud-registry/concepts/index.md) или [Docker Hub](https://hub.docker.com/)), а также бакетам [Object Storage](../../../storage/concepts/bucket.md).
         
         Чтобы обеспечить узлам доступ в интернет, назначьте им публичный IP-адрес и [настройте](../connect/security-groups.md#rules-internal-nodegroup) группу безопасности. Также в качестве альтернативы публичным IP-адресам можно создать и настроить в подсети узлов [NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../../vpc/tutorials/nat-instance/index.md).
         
         Если вы назначили узлам кластера публичные IP-адреса и затем настроили NAT-шлюз или NAT-инстанс, доступ в интернет через публичные адреса пропадет. Подробнее читайте в [документации Yandex Virtual Private Cloud](../../../vpc/concepts/routing.md#internet-routes).

       * `labels` — [облачные метки](../../concepts/index.md#node-labels) группы узлов. Можно указать несколько меток через запятую.
       * `node_labels` — [Kubernetes-метки](../../concepts/index.md#node-labels) группы узлов.
       * `reserved_instance_pool_id` — [идентификатор](../../../compute/cli-ref/reserved-instance-pool/list.md) пула резервов ВМ. Подробнее читайте на странице [Создание группы с узлами из пула резервов ВМ Yandex Compute Cloud](node-group-create-in-instance-pool.md).
       * `scale_policy` — настройки масштабирования.

         Тип масштабирования нельзя изменить после создания группы узлов.

       * `deploy_policy` — настройки развертывания группы:
         * `max_expansion` — максимальное количество узлов, на которое можно увеличить размер группы при ее обновлении.

           {% note warning %}
           
           Если в настройках группы узлов разрешено автоматическое расширение размера группы при обновлении, убедитесь, что в вашем облаке достаточно [ресурсов](../../concepts/limits.md). При необходимости [увеличьте](../../../quota-manager/operations/set-quotas.md) квоты.
           
           {% endnote %}

         * `max_unavailable` — максимальное количество недоступных узлов группы при ее обновлении.

       * `allocation_policy` — настройки размещения. Содержат блок `location` с параметром `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой вы хотите разместить узлы группы. Вы можете разместить узлы группы с фиксированным типом масштабирования в нескольких зонах доступности, для этого укажите каждую зону доступности в отдельном блоке `location`.

         {% note warning %}
         
         Размещение узлов автомасштабируемой группы возможно только в одной [зоне доступности](../../../overview/concepts/geo-scope.md).
         
         {% endnote %}

         {% note warning %}
         
         Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
         
         {% endnote %}

     * Чтобы создать группу с фиксированным количеством узлов, добавьте блок `fixed_scale`:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
         ...
         scale_policy {
           fixed_scale {
             size = <количество_узлов_в_группе>
           }
         }
       }
       ```

     * Чтобы создать группу узлов Managed Service for Kubernetes с [автомасштабированием](../../concepts/node-group/cluster-autoscaler.md), добавьте блок `auto_scale`:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
         ...
         scale_policy {
           auto_scale {
             min     = <минимальное_количество_узлов_в_группе_узлов>
             max     = <максимальное_количество_узлов_в_группе_узлов>
             initial = <начальное_количество_узлов_в_группе_узлов>
           }
         }
       }
       ```

     * Чтобы создать группу узлов Managed Service for Kubernetes с [прерываемыми ВМ](../../../compute/concepts/preemptible-vm.md), добавьте блок `scheduling_policy`:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
         ...
         instance_template {
           scheduling_policy {
             preemptible = true
           }
         }
       }
       ```

       
       {% note tip %}
       
       Для автоматического расселения подов с прерываемого узла при его выключении используйте продукт Yandex Cloud Marketplace [node-sitter](../applications/node-sitter.md).
       
       {% endnote %}


     * Чтобы добавить метаданные для узлов, передайте их в параметре `instance_template.metadata`.

        Способ подключения к узлам в группе узлов настраивается с помощью метаданных. Допустимо настроить только один из способов, так как они являются взаимоисключающими.
        
        Чтобы получить возможность подключаться к узлам в группе узлов, укажите метаданные для выбранного способа подключения:
        
        * Чтобы подключаться к узлам через OS Login, добавьте метаданные с ключом `enable-oslogin` и значением `true`.
        
            Настройка и использование OS Login подробно рассмотрены в разделе [Подключение к узлу через OS Login](../node-connect-oslogin.md).
        
        * Чтобы подключаться к узлам с использованием SSH-ключей, добавьте метаданные с ключом `ssh-keys` и значением, в котором содержится перечень реквизитов для подключения.
        
            Подготовка реквизитов, настройка и использование SSH-ключей подробно рассмотрены в разделе [Подключение к узлу по SSH](../node-connect-ssh.md).

        {% note warning %}

        Настройки метаданных могут повлиять на поведение и работоспособность узлов в группе. Меняйте эти настройки только если вы точно знаете, что хотите сделать.
        
        Передача пользовательских данных в метаданных с ключом `user-data` не поддерживается.

        {% endnote %}

        Добавьте метаданные одним из способов:

        * Укажите одну или несколько пар `ключ=значение`.

            Значение ключа передается в явном виде.

        * Укажите одну или несколько пар `ключ=file(путь_к_файлу_со_значением)`.

            Значение ключа будет считано из файла. Это может быть полезно, если значение слишком длинное, чтобы передавать его в явном виде, или содержит переносы строк и другие спецсимволы.

        ```hcl
        resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
          ...
          instance_template {
            metadata = {
              "ключ_1" = "значение"
              "ключ_2" = file("<путь_к_файлу_со_значением>")
              ...
            }
            ...
          }
          ...
        }
        ```

        Перечень метаданных можно [изменить после создания кластера](node-group-update.md#switch-node-connect-mode).

     * Чтобы добавить [DNS-записи](../../../dns/concepts/resource-record.md):

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

     Подробнее в [документации провайдера Terraform](../../../terraform/resources/kubernetes_node_group.md).
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в каталог, в котором создан конфигурационный файл.
        
     1. Выполните проверку с помощью команды:
        
        ```bash
        terraform plan
        ```
     
     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. Это проверочный этап: ресурсы не будут созданы.

  1. Создайте группу узлов Managed Service for Kubernetes.

     1. Если в конфигурации нет ошибок, выполните команду:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите создание ресурсов.
     
     После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

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

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Воспользуйтесь методом REST API [create](../../managed-kubernetes/api-ref/NodeGroup/create.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Create](../../managed-kubernetes/api-ref/grpc/NodeGroup/create.md) и передайте в запросе:
  * Идентификатор [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster) в параметре `clusterId`. Его можно получить со [списком кластеров Managed Service for Kubernetes в каталоге](../kubernetes-cluster/kubernetes-cluster-list.md#list).
  * [Конфигурацию группы узлов Managed Service for Kubernetes](../../concepts/index.md#config) в параметре `nodeTemplate`.
  * Тип [ускорения сети](../../../compute/concepts/software-accelerated-network.md) в параметре `nodeTemplate.networkSettings.type`.

    {% note warning %}
    
    Перед включением [программно ускоренной сети](../../../compute/concepts/software-accelerated-network.md) убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../concepts/limits.md) для создания одного дополнительного [узла Managed Service for Kubernetes](../../concepts/index.md#node-group).
    
    {% endnote %}

  * Среду запуска контейнеров [containerd](https://containerd.io/) в параметре `nodeTemplate.containerRuntimeSettings.type`.
  * [Облачные метки](../../concepts/index.md#node-labels) группы узлов в параметре `nodeTemplate.labels`.
  * [Kubernetes-метки](../../concepts/index.md#node-labels) группы узлов в параметре `nodeLabels`.
  * Идентификатор [пула резервов виртуальных машин](../../../compute/concepts/reserved-pools.md) в параметре `nodeTemplate.reservedInstancePoolId`. Подробнее читайте на странице [Создание группы с узлами из пула резервов ВМ Yandex Compute Cloud](node-group-create-in-instance-pool.md).
  * [Настройки масштабирования](../../concepts/autoscale.md#ca) в параметре `scalePolicy`.
  
    Тип масштабирования нельзя изменить после создания группы узлов.

  * Настройки развертывания группы узлов в параметре `deployPolicy`:
    * `maxExpansion` — максимальное количество узлов, на которое можно увеличить размер группы при ее обновлении.

      {% note warning %}
      
      Если в настройках группы узлов разрешено автоматическое расширение размера группы при обновлении, убедитесь, что в вашем облаке достаточно [ресурсов](../../concepts/limits.md). При необходимости [увеличьте](../../../quota-manager/operations/set-quotas.md) квоты.
      
      {% endnote %}

    * `maxUnavailable` — максимальное количество недоступных узлов группы при ее обновлении.

  * [Настройки размещения](../../../overview/concepts/geo-scope.md) группы узлов Managed Service for Kubernetes в параметрах `allocationPolicy`.

    {% note warning %}
    
    Размещение узлов автомасштабируемой группы возможно только в одной [зоне доступности](../../../overview/concepts/geo-scope.md).
    
    {% endnote %}

    {% note warning %}
    
    Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
    
    {% endnote %}

  * Настройки окна [обновлений](../../concepts/release-channels-and-updates.md#updates) в параметрах `maintenancePolicy`.
  * Параметры [политики развертывания](../../concepts/node-group/deploy-policy.md) (deploy policy):

    * Параметр `deployPolicy.maxExpansion` — максимальное количество узлов, на которое можно расширить группу при ее изменении или обновлении. Значение по умолчанию — `3`.
    * Параметр `deployPolicy.maxUnavailable` — максимальное количество узлов, которые могут быть недоступны в ходе изменения или обновления группы. Значение по умолчанию — `0`.
    
    Подробнее в разделе [Политика развертывания группы узлов в Managed Service for Kubernetes](../../concepts/node-group/deploy-policy.md).

  * Список изменяемых настроек в параметре `updateMask`.

    {% note warning %}
    
    Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
    
    {% endnote %}

  * Чтобы назначить узлам случайные публичные [IP-адреса](../../../vpc/concepts/address.md) из пула адресов Yandex Cloud, передайте значение `IPV4` в параметре `nodeTemplate.networkInterfaceSpecs.primaryV4AddressSpec.oneToOneNatSpec.ipVersion`.

    Публичные IP-адреса необходимы для [подключения](../connect/index.md) к узлам из интернета и для подключения узлов к внешним ресурсам, например реестрам Docker-образов ([Container Registry](../../../container-registry/concepts/index.md), [Cloud Registry](../../../cloud-registry/concepts/index.md) или [Docker Hub](https://hub.docker.com/)), а также бакетам [Object Storage](../../../storage/concepts/bucket.md).
    
    Чтобы обеспечить узлам доступ в интернет, назначьте им публичный IP-адрес и [настройте](../connect/security-groups.md#rules-internal-nodegroup) группу безопасности. Также в качестве альтернативы публичным IP-адресам можно создать и настроить в подсети узлов [NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../../vpc/tutorials/nat-instance/index.md).
    
    Если вы назначили узлам кластера публичные IP-адреса и затем настроили NAT-шлюз или NAT-инстанс, доступ в интернет через публичные адреса пропадет. Подробнее читайте в [документации Yandex Virtual Private Cloud](../../../vpc/concepts/routing.md#internet-routes).

  * Чтобы узлы использовали [нереплицируемые диски](../../../compute/concepts/disk.md#disks_types), передайте значение `network-ssd-nonreplicated` для параметра `nodeTemplate.bootDiskSpec.diskTypeId`.

    Размер нереплицируемых дисков можно менять только с шагом 93 ГБ. Максимальный размер такого диска — 4 ТБ.

    {% note alert %}
    
    Нереплицируемые диски не имеют резервирования. При выходе диска из строя данные будут утеряны безвозвратно. Подробнее в разделе [Нереплицируемые диски и сверхбыстрые сетевые хранилища с тремя репликами (SSD)](../../../compute/concepts/disk.md#nr-disks).
    
    {% endnote %}

  * Чтобы разрешить использование узлами группы Managed Service for Kubernetes [небезопасных параметров ядра](../../concepts/index.md#node-group), передайте их имена в параметре `allowedUnsafeSysctls`.

  * Чтобы задать [taint-политики](../../concepts/index.md#taints-tolerations), передайте их значения в параметре `nodeTaints`.

  * Чтобы задать шаблон имени узлов Managed Service for Kubernetes, передайте его в параметре `nodeTemplate.name`. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

    * `{instance_group.id}` — идентификатор группы ВМ.
    * `{instance.index}` — уникальный номер ВМ в группе. Возможные значения: от 1 до N, где N — количество ВМ в группе.
    * `{instance.index_in_zone}` — номер ВМ в зоне. Уникален в рамках зоны для конкретной группы ВМ.
    * `{instance.short_id}` — идентификатор ВМ, уникальный в рамках группы. Состоит из четырех букв.
    * `{instance.zone_id}`— идентификатор зоны.
    
    Например, `prod-{instance.short_id}-{instance_group.id}`. Если имя не задано, используется значение по умолчанию: `{instance_group.id}-{instance.short_id}`.

  * Чтобы создать группу узлов с [прерываемыми ВМ](../../../compute/concepts/preemptible-vm.md), передайте параметр `nodeTemplate.schedulingPolicy.preemptible`.

    
    {% note tip %}
    
    Для автоматического расселения подов с прерываемого узла при его выключении используйте продукт Yandex Cloud Marketplace [node-sitter](../applications/node-sitter.md).
    
    {% endnote %}


  * Чтобы указать [группу размещения](../../../compute/concepts/placement-groups.md) для узлов Managed Service for Kubernetes, передайте идентификатор группы размещения в параметре `nodeTemplate.placementPolicy.placementGroupId`.

    {% note info %}
    
    От группы размещения зависит максимально доступный размер группы узлов:
    
    * В группе ВМ со стратегией [распределенного размещения](../../../compute/concepts/placement-groups.md#spread) максимальное число ВМ определяется [лимитами](../../../compute/concepts/limits.md#compute-limits-vm).
    * В группе ВМ со стратегией [размещения разделами](../../../compute/concepts/placement-groups.md#partition) максимальное число ВМ в разделе определяется [квотами](../../../compute/concepts/limits.md#vm-quotas).
    
    
    {% endnote %}

  * Чтобы добавить метаданные для узлов, передайте их в параметре `nodeTemplate.metadata`.

    Способ подключения к узлам в группе узлов настраивается с помощью метаданных. Допустимо настроить только один из способов, так как они являются взаимоисключающими.
    
    Чтобы получить возможность подключаться к узлам в группе узлов, укажите метаданные для выбранного способа подключения:
    
    * Чтобы подключаться к узлам через OS Login, добавьте метаданные с ключом `enable-oslogin` и значением `true`.
    
        Настройка и использование OS Login подробно рассмотрены в разделе [Подключение к узлу через OS Login](../node-connect-oslogin.md).
    
    * Чтобы подключаться к узлам с использованием SSH-ключей, добавьте метаданные с ключом `ssh-keys` и значением, в котором содержится перечень реквизитов для подключения.
    
        Подготовка реквизитов, настройка и использование SSH-ключей подробно рассмотрены в разделе [Подключение к узлу по SSH](../node-connect-ssh.md).

    {% note warning %}

    Настройки метаданных могут повлиять на поведение и работоспособность узлов в группе. Меняйте эти настройки только если вы точно знаете, что хотите сделать.
    
    Передача пользовательских данных в метаданных с ключом `user-data` не поддерживается.

    {% endnote %}

    Добавьте метаданные, указав одну или несколько пар `ключ=значение`, разделенных запятыми.

    Значение ключа передается в явном виде.

    Перечень метаданных можно [изменить после создания кластера](node-group-update.md#switch-node-connect-mode).

  * Чтобы добавить [DNS-записи](../../../dns/concepts/resource-record.md), передайте их настройки в параметре `nodeTemplate.networkInterfaceSpecs.primaryV4AddressSpec.dnsRecordSpecs`. В [FQDN](../../../glossary/fqdn.md) записи DNS можно использовать шаблон с переменными для имени узлов `nodeTemplate.name`.

{% endlist %}

Процесс создания группы узлов Managed Service for Kubernetes может занять несколько минут в зависимости от количества узлов.

Отдельные узлы в группах узлов — это виртуальные машины Yandex Compute Cloud с автоматически сгенерированными именами. Чтобы сконфигурировать узлы, [воспользуйтесь инструкциями по управлению группами узлов](../index.md#node-group).

{% note alert %}

Не изменяйте параметры ВМ узлов, в том числе имена, сетевые интерфейсы и SSH-ключи, с помощью интерфейсов Compute Cloud или SSH-подключения к ВМ.

Это может нарушить работу отдельных узлов, групп узлов и всего кластера Managed Service for Kubernetes.

{% endnote %}

## Примеры {#examples}

Создайте группу узлов для кластера Managed Service for Kubernetes с тестовыми характеристиками:

* Имя — `k8s-demo-ng`.
* Описание — `Test node group`.
* Шаблон имени узлов — `test-{instance.short_id}-{instance_group.id}`.
* [Кластер Kubernetes](../../concepts/index.md#kubernetes-cluster) — укажите [идентификатор](../kubernetes-cluster/kubernetes-cluster-list.md) существующего кластера, например `cat0adul1fj0********`.
* [Версия Kubernetes](../../concepts/release-channels-and-updates.md) на узлах группы — `1.29`.
* [Платформа](../../../compute/concepts/vm-platforms.md) для узлов — `standard-v3`.
* Количество vCPU для узлов — два.
* [Гарантированная доля vCPU](../../../compute/concepts/performance-levels.md) — 50%.
* [Размер диска](../../../compute/concepts/disk.md#maximum-disk-size) — 64 ГБ.
* [Тип диска](../../../compute/concepts/disk.md#disks_types) — `network-ssd`.
* Количество узлов — один.
* [Политика развертывания](../../concepts/node-group/deploy-policy.md):
    * Максимальное количество узлов, на которое можно расширить группу при ее изменении или обновлении — `3`.
    * Максимальное количество узлов, которые могут быть недоступны в ходе изменения или обновления группы — `1`.
* Объем RAM — два ГБ.
* Время для [обновления](../../concepts/release-channels-and-updates.md#updates) — в период с 22:00 до 08:00 UTC.
* Тип [ускорения сети](../../../compute/concepts/software-accelerated-network.md) — `standard` (без ускорения).
* Сетевые настройки:
  * [Идентификатор группы безопасности](../../../vpc/operations/security-group-get-info.md), например `enp6saqnq4ie********`.
  * [Идентификатор подсети](../../../vpc/operations/subnet-get-info.md), например `e9bj3s90g9hm********`.
  * Назначение узлам публичного и внутреннего IP-адресов — включено.
* [Kubernetes-метка](../../concepts/index.md#node-labels) — `node-label1=node-value1`.
* [Taint-политика](../../concepts/index.md#taints-tolerations) Kubernetes — `taint1=taint-value1:NoSchedule`.
* [Облачная метка](../../concepts/index.md#node-labels) — `template-label1=template-value1`.
* Разрешение на использование [небезопасных параметров ядра](../../concepts/index.md#config) — включено. Добавлены параметры `kernel.msg*` и `net.core.somaxconn`.
* ВМ, которая является единственным узлом группы, — [прерываемая](../../../compute/concepts/preemptible-vm.md).

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните следующую команду:

  ```bash
  yc managed-kubernetes node-group create \
    --name k8s-demo-ng \
    --description 'Test node group' \
    --node-name test-{instance.short_id}-{instance_group.id} \
    --cluster-id cat0adul1fj0******** \
    --version 1.29 \
    --platform-id standard-v3 \
    --cores 2 \
    --core-fraction 50 \
    --disk-size 64 \
    --disk-type network-ssd \
    --fixed-size 1 \
    --max-expansion 3 \
    --max-unavailable 1 \
    --memory 2 \
    --daily-maintenance-window 'start=22:00,duration=10h' \
    --network-acceleration-type standard \
    --network-interface security-group-ids=enp6saqnq4ie********,subnets=e9bj3s90g9hm********,ipv4-address=nat \
    --node-labels node-label1=node-value1 \
    --node-taints taint1=taint-value1:NoSchedule \
    --template-labels template-label1=template-value1 \
    --allowed-unsafe-sysctls='kernel.msg*,net.core.somaxconn' \
    --preemptible
  ```

- Terraform

  1. Разместите конфигурационный файл для группы узлов в каталоге с [файлом описания кластера](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create).

      ```hcl
      resource "yandex_kubernetes_node_group" "k8s-demo-ng" {
        name        = "k8s-demo-ng"
        description = "Test node group"
        cluster_id  = "cat0adul1fj0********"
        version     = "1.29"
        instance_template {
          name = "test-{instance.short_id}-{instance_group.id}"
          platform_id = "standard-v3"
          resources {
            cores         = 2
            core_fraction = 50
            memory        = 2
          }
          boot_disk {
            size = 64
            type = "network-ssd"
          }
          network_acceleration_type = "standard"
          network_interface {
            security_group_ids = ["enp6saqnq4ie********"]
            subnet_ids         = ["e9bj3s90g9hm********"]
            nat                = true
          }
          scheduling_policy {
            preemptible = true
          }
        }
        scale_policy {
          fixed_scale {
            size = 1
          }
        }
        deploy_policy {
          max_expansion   = 3
          max_unavailable = 1
        }
        maintenance_policy {
          auto_upgrade = true
          auto_repair  = true
          maintenance_window {
            start_time = "22:00"
            duration   = "10h"
          }
        }
        node_labels = {
          node-label1 = "node-value1"
        }
        node_taints = ["taint1=taint-value1:NoSchedule"]
        labels = {
          "template-label1" = "template-value1"
        }
        allowed_unsafe_sysctls = ["kernel.msg*", "net.core.somaxconn"]
      }
      ```

  1. Проверьте корректность конфигурационного файла.

      1. В командной строке перейдите в каталог, в котором создан конфигурационный файл.
         
      1. Выполните проверку с помощью команды:
         
         ```bash
         terraform plan
         ```
      
      Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. Это проверочный этап: ресурсы не будут созданы.

  1. Создайте группу узлов Managed Service for Kubernetes.

      1. Если в конфигурации нет ошибок, выполните команду:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите создание ресурсов.
      
      После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

### Полезные ссылки {#see-also}

* [Создание группы с узлами из пула резервов ВМ Yandex Compute Cloud](node-group-create-in-instance-pool.md)
* [Группа узлов](../../concepts/index.md#node-group)