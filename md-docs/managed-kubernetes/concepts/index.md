# Взаимосвязь ресурсов в Managed Service for Kubernetes


[Kubernetes](https://kubernetes.io/ru/) — система для управления [контейнерными приложениями](../../glossary/containerization.md#containers-apps). Kubernetes предоставляет механизмы взаимодействия с [кластером](../../glossary/cluster.md), с помощью которых осуществляется автоматизация развертывания, масштабирования и управления приложениями в контейнерах.

Основная сущность, которой оперирует сервис, — _кластер Kubernetes_.

## Кластер Kubernetes {#kubernetes-cluster}

Кластер Kubernetes состоит из мастера и одной или нескольких групп узлов. Мастер отвечает за управление кластером Kubernetes. На узлах запускаются контейнеризованные приложения пользователя.

Сервис полностью управляет мастером, а также следит за состоянием и работоспособностью группы узлов. Пользователь может управлять узлами напрямую, а также настраивать кластер Kubernetes с помощью консоли управления Yandex Cloud, CLI и API Managed Service for Kubernetes.

При работе с кластером Kubernetes на инфраструктуре Yandex Cloud задействуются следующие ресурсы:

Ресурс | Количество | Комментарий
--- | --- | ---
Подсеть | 2 | При создании кластера без [туннельного режима](network-policy.md#cilium) Managed Service for Kubernetes резервирует две подсети: для подов и сервисов. Для кластера с туннельным режимом подсети в адресном пространстве облачной сети не резервируются.
Публичный IP | N | В зависимости от того, используется ли [публичный доступ в кластере](network.md#public-access-to-a-host), количество IP-адресов может быть разным.

{% note info %}

Для подключения к внешним ресурсам, например реестрам Docker-образов [Container Registry](../../container-registry/concepts/index.md), [Cloud Registry](../../cloud-registry/concepts/index.md) или [Docker Hub](https://hub.docker.com/), а также бакетам [Object Storage](../../storage/concepts/bucket.md), у узлов группы должен быть доступ в интернет.

Чтобы обеспечить доступ в интернет, [назначьте](../operations/node-group/node-group-update.md#node-internet-access) узлам публичный IP-адрес и [настройте](../operations/connect/security-groups.md#rules-internal-nodegroup) группу безопасности. Также в качестве альтернативы публичным IP-адресам можно создать и настроить в подсети узлов [NAT-шлюз](../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../vpc/tutorials/nat-instance/index.md).

Подробнее в подразделе [Доступ в интернет для рабочих узлов кластера](network.md#nodes-internet).

{% endnote %}

### Метки кластера {#cluster-labels}

Для разделения кластеров Kubernetes по логическим группам используйте [облачные метки](../../resource-manager/concepts/labels.md).

Облачные метки для кластеров Kubernetes составляются по следующим правилам:

  * Параметры ключа метки:
  
    * Длина — от 1 до 63 символов.
    * Может содержать строчные буквы латинского алфавита, цифры, дефисы и подчеркивания.
    * Первый символ — буква.
  
  * Параметры значения метки:
  
    * Длина — до 63 символов.
    * Может содержать строчные буквы латинского алфавита, цифры, дефисы и подчеркивания.

Об управлении облачными метками читайте в разделе [Изменение кластера](../operations/kubernetes-cluster/kubernetes-cluster-update.md#manage-label).

{% note info %}

Кластеру нельзя назначить [Kubernetes-метки](https://kubernetes.io/ru/docs/concepts/overview/working-with-objects/labels/).

{% endnote %}

## Мастер {#master}

_Мастер_ — компонент, который управляет кластером Kubernetes.

Мастер запускает управляющие процессы Kubernetes, которые включают сервер Kubernetes API, планировщик и контроллеры основных ресурсов. Жизненный цикл мастера управляется сервисом при создании или удалении кластера Kubernetes. Мастер отвечает за глобальные решения, которые выполняются на всех узлах кластера Kubernetes. Они включают в себя планирование рабочих нагрузок, таких как контейнерные приложения, управление жизненным циклом рабочих нагрузок и масштабированием.

Мастер бывает следующих типов, которые отличаются количеством хостов мастера и размещением в [зонах доступности](../../overview/concepts/geo-scope.md):
* _Базовый_ — содержит один хост мастера в одной зоне доступности. Такой мастер дешевле, но он не является отказоустойчивым. Прежнее название — _зональный_.

  {% note warning %}

  _Базовый_ мастер тарифицируется как _зональный_ и отображается в Yandex Cloud Billing как `Managed Service for Kubernetes. Зональный мастер`.

  {% endnote %}

* _Высокодоступный_ — содержит три хоста мастера, которые вы можете разместить следующим образом:
  * В одной зоне доступности и одной подсети. Такой мастер подойдет, если вы хотите обеспечить высокую доступность кластера и уменьшить сетевую задержку внутри него.
  * В трех разных зонах доступности. Такой мастер обеспечивает наибольшую [отказоустойчивость](../../architecture/fault-tolerance.md): при недоступности одной зоны мастер остается работоспособным.

  Внутренний IP-адрес высокодоступного мастера доступен только в пределах одной облачной сети Yandex Virtual Private Cloud.

  Прежнее название — _региональный_.

  {% note warning %}

  _Высокодоступный_ мастер тарифицируется как _региональный_ и отображается в Yandex Cloud Billing как `Managed Service for Kubernetes. Региональный мастер`.

  {% endnote %}

Подробнее о настройках мастера см. на странице [Создание кластера Managed Service for Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-create.md).

### Вычислительные ресурсы мастера {#master-resources}

{% note warning %}

С 18 июня 2026 года тарификация мастеров изменится — плата будет взиматься за количество vCPU и объем RAM. Чтобы рассчитать необходимое количество ресурсов мастера для своего кластера, воспользуйтесь таблицей [Рекомендуемые конфигурации мастера](master-configuration.md).

{% endnote %}

_По умолчанию_ для работы одного хоста мастера предоставляются следующие ресурсы:
* [платформа](../../compute/concepts/vm-platforms.md) — Intel Cascade Lake;
* гарантированная доля vCPU — 100%;
* количество vCPU — 2;
* объем RAM — 8 ГБ.

При [создании](../operations/kubernetes-cluster/kubernetes-cluster-create.md) и [изменении](../operations/kubernetes-cluster/kubernetes-cluster-update.md#manage-resources) кластера вы можете выбрать конфигурацию мастера, подходящую под ваши задачи.

Выбранная конфигурация задает минимальные значения ресурсов для мастера. В зависимости от нагрузки объем RAM и количество vCPU мастера будут автоматически увеличиваться.

{% note info %}

Функциональность выбора и изменения конфигурации мастера находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Доступны следующие конфигурации мастера на платформе Intel Cascade Lake с гарантированной долей vCPU 100%:

* **Standard** — стандартные хосты с соотношением объема RAM к vCPU, равным 4 к 1: {#master-standard}

  Идентификатор | Количество vCPU | Объем RAM, ГБ
  --- | --- | ---
  s-c2-m8    | 2 | 8
  s-c4-m16   | 4 | 16
  s-c8-m32   | 8 | 32
  s-c16-m64  | 16 | 64
  s-c32-m128 | 32 | 128
  s-c64-m256 | 64 | 256
  s-c80-m320 | 80 | 320

* **CPU optimized** — хосты с уменьшенным соотношением RAM к vCPU, равным 2 к 1: {#master-cpu-optimized}

  Идентификатор | Количество vCPU | Объем RAM, ГБ
  --- | --- | ---
  c-c4-m8   | 4 | 8
  c-c8-m16  | 8 | 16
  c-c16-m32 | 16 | 32
  c-c32-m64 | 32 | 64

* **Memory optimized** — хосты с увеличенным соотношением RAM к vCPU, равным 8 к 1: {#master-memory-optimized}

  Идентификатор | Количество vCPU | Объем RAM, ГБ
  --- | --- | ---
  m-c2-m16 | 2 | 16
  m-c4-m32 | 4 | 32
  m-c8-m64 | 8 | 64
  m-c16-m128 | 16 | 128
  m-c32-m256 | 32 | 256

Подробнее см. на странице [Получение списка доступных конфигураций мастера в кластере Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-configuration-list.md).

Изменение конфигурации мастера не требует остановки кластера Managed Service for Kubernetes.

## Группа узлов {#node-group}

_Группа узлов_ — [группа виртуальных машин](../../compute/concepts/instance-groups/index.md) Yandex Compute Cloud с одинаковой конфигурацией в кластере Kubernetes, на которых запускаются пользовательские контейнеры.

Отдельные узлы в группах узлов — это виртуальные машины Yandex Compute Cloud с автоматически сгенерированными именами. Чтобы сконфигурировать узлы, [воспользуйтесь инструкциями по управлению группами узлов](../operations/index.md#node-group).

{% note alert %}

Не изменяйте параметры ВМ узлов, в том числе имена, сетевые интерфейсы и SSH-ключи, с помощью интерфейсов Compute Cloud или SSH-подключения к ВМ.

Это может нарушить работу отдельных узлов, групп узлов и всего кластера Managed Service for Kubernetes.

{% endnote %}

Смотрите также [описание групп ВМ при зональном инциденте и рекомендации по предотвращению его последствий](../../compute/concepts/instance-groups/zonal-inc/overview.md).

Для группы узлов вы можете задать следующие параметры:
* Имя и описание.
* [Версия Kubernetes](k8s-supported-versions.md)
* [Облачные метки группы узлов](../../resource-manager/concepts/labels.md)
* [Параметры масштабирования](node-group/cluster-autoscaler.md)
* [Политика развертывания](node-group/deploy-policy.md)
* [Пулы резервов виртуальных машин](node-group/reserved-pools.md)
* [Переменные в шаблоне узла](node-group/variables-in-the-template.md)
* [Конфигурация ВМ](#config)
* [Политики taints и tolerations](#taints-tolerations)
* [Метки узлов](#node-labels)

Для Managed Service for Kubernetes в качестве среды запуска контейнеров доступна только платформа [containerd](https://containerd.io/).

### Конфигурация ВМ {#config}


При создании группы узлов вы можете сконфигурировать следующие параметры ВМ:

* Тип ВМ. Для снижения стоимости кластера вы можете использовать [прерываемые ВМ](../../compute/concepts/preemptible-vm.md).

   
   {% note tip %}
   
   Для автоматического расселения подов с прерываемого узла при его выключении используйте продукт Yandex Cloud Marketplace [node-sitter](../operations/applications/node-sitter.md).
   
   {% endnote %}
   

* Тип и количество ядер (vCPU).
* Объем памяти (RAM) и диска.
* [Группу размещения](../../compute/concepts/placement-groups.md).

  {% note info %}
  
  От группы размещения зависит максимально доступный размер группы узлов:
  
  * В группе ВМ со стратегией [распределенного размещения](../../compute/concepts/placement-groups.md#spread) максимальное число ВМ определяется [лимитами](../../compute/concepts/limits.md#compute-limits-vm).
  * В группе ВМ со стратегией [размещения разделами](../../compute/concepts/placement-groups.md#partition) максимальное число ВМ в разделе определяется [квотами](../../compute/concepts/limits.md#vm-quotas).
  
  
  {% endnote %}

* Параметры ядра.
  * _Безопасные_ (safe) параметры ядра изолированы между подами.
  * _Небезопасные_ (unsafe) параметры влияют на работу не только подов, но и узла в целом. В Managed Service for Kubernetes нельзя изменять небезопасные параметры ядра, имена которых не были явно указаны при [создании группы узлов](../operations/node-group/node-group-create.md).

  {% note info %}

  Указывайте только параметры ядра, которые принадлежат [пространствам имен](#namespace), например, `net.ipv4.ping_group_range`. Параметры, которые не принадлежат пространствам имен, например, `vm.max_map_count`, необходимо разрешать непосредственно в операционной системе или при помощи DaemonSet с контейнерами в привилегированном режиме после создания [группы узлов Managed Service for Kubernetes](#node-group).

  {% endnote %}

  Подробнее о параметрах ядра см. в [документации Kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/).

В одном кластере Kubernetes можно создавать группы с разными конфигурациями и размещать их в разных зонах доступности.

### Политики taints и tolerations {#taints-tolerations}

_Taints_ — это особые политики, которые присваиваются узлам в группе. С помощью taint-политик можно запретить некоторым подам выполняться на определенных узлах. Например, можно указать, что поды для рендеринга должны запускаться только на [узлах с GPU](node-group/node-group-gpu.md).

Преимущества использования taint-политик:
* политики сохраняются, когда узел перезапускается или заменяется новым;
* при добавлении узлов в группу политики назначаются этому узлу автоматически;
* политики автоматически назначаются новым узлам при [масштабировании группы узлов](autoscale.md).

Назначить taint-политику на группу узлов можно только при [создании](../operations/node-group/node-group-create.md) группы. 

{% note tip %}

С помощью Terraform вы можете [добавить](../operations/node-group/node-group-update.md#assign-taints) или [удалить](../operations/node-group/node-group-update.md#remove-taint) taint-политики для Terraform-ресурса группы узлов, однако при этом сама группа узлов будет удалена и создана заново с новой конфигурацией.

{% endnote %}

Каждая taint-политика состоит из трех частей:

```text
<ключ> = <значение>:<эффект>
```

Список доступных taint-эффектов:
* `NO_SCHEDULE` — запретить запуск новых подов на узлах группы (уже запущенные поды продолжат работу);
* `PREFER_NO_SCHEDULE` — избегать запуска подов на узлах группы, если для запуска этих подов есть свободные ресурсы в других группах;
* `NO_EXECUTE` — завершить работу подов на узлах этой группы, расселить их в другие группы, а запуск новых подов запретить.

_Tolerations_ — это исключения из taint-политик. С помощью tolerations можно разрешить определенным подам работать на узлах, даже если taint-политика группы узлов препятствует этому.

Tolerations бывают двух типов:

  * `Equal` — срабатывает, если в taint-политике и toleration совпадают ключ, значение и эффект. Используется по умолчанию.

  * `Exists` — срабатывает, если в taint-политике и toleration совпадают ключ и эффект. Значение ключа не учитывается.

  Например, если для узлов в группе настроена taint-политика `key1=value1:NoSchedule`, разместить поды на узле с помощью tolerations можно так:

  ```yaml
  apiVersion: v1
  kind: Pod
  ...
  spec:
    ...
    tolerations:
    - key: "key1"
      operator: "Equal"
      value: "value1"
      effect: "NoSchedule"
  ```
  Или так:

  ```yaml
  apiVersion: v1
  kind: Pod
  ...
  spec:
    ...
    tolerations:
    - key: "key1"
      operator: "Exists"
      effect: "NoSchedule"
  ```

{% note info %}

Для системных подов автоматически назначаются tolerations, позволяющие им работать на всех доступных узлах.

{% endnote %}

Подробнее о taint-политиках и исключениях см. в [документации Kubernetes](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/).

### Метки узлов {#node-labels}

_Метки узлов_ — механизм группировки узлов в Managed Service for Kubernetes. Существуют два вида меток узлов:

* [Облачные метки](../../resource-manager/concepts/labels.md) — используются для логического разделения и маркировки ресурсов. Например, с помощью облачных меток можно [следить за расходами](../../billing/operations/get-folder-report.md#format) на различные группы узлов. Обозначаются в CLI как `template-labels` и в Terraform — как `labels`.

  Облачные метки узлов составляются по следующим правилам:

    Параметры ключа метки:
    
      * Может содержать строчные буквы латинского алфавита, цифры и символы `-_./\@`.
      * Первый символ — буква.
      * Максимальная длина — 63 символа.
    
    Параметры значения метки:
    
      * Может содержать строчные буквы латинского алфавита, цифры и символы `-_./\@`.
      * Максимальная длина — 63 символа.

  Об управлении облачными метками читайте в разделе [Изменение группы узлов](../operations/node-group/node-group-update.md#manage-label).

* [Kubernetes-метки](https://kubernetes.io/ru/docs/concepts/overview/working-with-objects/labels/) — используются для группировки объектов Kubernetes и [распределения подов по узлам кластера](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes). Обозначаются в CLI как `node-labels` и в Terraform — как `node_labels`.

  При назначении Kubernetes-меток указывайте характеристики узлов, по которым вы будете группировать объекты. Примеры Kubernetes-меток см. в [документации Kubernetes](https://kubernetes.io/ru/docs/concepts/overview/working-with-objects/labels/#причины-использования).

  Набор Kubernetes-меток `ключ: значение` может быть определен для каждого объекта. Для него все ключи должны быть уникальными.

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

  Для управления Kubernetes-метками доступны [API Managed Service for Kubernetes](../managed-kubernetes/api-ref/index.md) и [API Kubernetes](https://kubernetes.io/ru/docs/concepts/overview/kubernetes-api). Их особенности:

  * Kubernetes-метки, добавленные через API Kubernetes, могут быть потеряны, так как во время [обновления или изменения групп узлов](../operations/node-group/node-group-update.md) часть узлов пересоздается с другим именем, а часть старых — удаляется.
  * Если Kubernetes-метки созданы через API Managed Service for Kubernetes, их не получится удалить через API Kubernetes. Иначе метки будут восстановлены после удаления.

  {% note warning %}

  Чтобы избежать потери меток, используйте API Managed Service for Kubernetes.

  {% endnote %}

  О добавлении и удалении Kubernetes-меток читайте в разделе [Управление Kubernetes-метками узлов](../operations/node-group/node-label-management.md). Если добавить или удалить метку, группа узлов не пересоздается.

Оба вида меток могут использоваться одновременно, например, при [создании группы узлов](../operations/node-group/node-group-create.md) через CLI или Terraform.

### Подключение к узлам группы {#node-connect-ssh}

К узлам группы можно подключаться следующими способами:
* через SSH-клиент с помощью стандартной пары SSH-ключей, см. [Подключение к узлу по SSH](../operations/node-connect-ssh.md);
* через SSH-клиент и CLI с помощью OS Login, см. [Подключение к узлу через OS Login](../operations/node-connect-oslogin.md).

## Под {#pod}

_Под_ — запрос на запуск одного или более контейнеров на одном узле группы. В рамках кластера Kubernetes каждый под имеет уникальный IP-адрес, чтобы приложения не конфликтовали при использовании портов.

Контейнеры описываются в поде через объект, написанный на языке JSON или YAML. Подключаться к терминалам запущенных контейнеров можно с помощью [kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/) или [напрямую из консоли управления](../operations/kubernetes-console/pod-terminal.md).

### Маскарадинг IP-адресов подов {#pod-ip-masquerade}

Если поду требуется доступ к ресурсам за пределами кластера, его IP-адрес будет заменен на IP-адрес узла, на котором работает под. Для этого в кластере используется механизм [маскарадинга IP-адресов](https://kubernetes.io/docs/tasks/administer-cluster/ip-masq-agent/).

По умолчанию, маскарадинг включен в направлении всего диапазона IP-адресов, кроме направлений CIDR подов и CIDR [адресов link-local](https://ru.wikipedia.org/wiki/Link-local_address).

Для реализации механизма маскарадинга на каждом узле кластера развернут под `ip-masq-agent`. Настройки этого пода хранятся в объекте ConfigMap с именем `ip-masq-agent`. Если необходимо отключить маскарадинг IP-адресов подов в определенном направлении, например, для доступа к ним через [VPN](../../glossary/vpn.md) или [Yandex Cloud Interconnect](../../interconnect/index.md), укажите в параметре `data.config.nonMasqueradeCIDRs` нужные диапазоны IP-адресов:

```yaml
...
data:
  config: |+
    nonMasqueradeCIDRs:
      - <CIDR_IP-адресов_в_направлении_которых_не_требуется_маскарадинг>
...
```

Чтобы посмотреть, как строятся правила для маскарадинга IP-адресов в `iptables` на конкретном узле, [подключитесь к узлу по SSH](../operations/node-connect-ssh.md) и выполните команду:

```bash
sudo iptables -t nat -L IP-MASQ -v -n
```

Подробнее см. на [странице ip-masq-agent на GitHub](https://github.com/kubernetes-sigs/ip-masq-agent).

## Сервис {#service}

[_Сервис_](service.md) — абстракция, которая обеспечивает функции сетевой балансировки нагрузки. Правила подачи трафика настраиваются для группы подов, объединенных набором меток.

По умолчанию сервис доступен только внутри конкретного кластера Kubernetes, но может быть общедоступным и получать [запросы извне](../operations/create-load-balancer.md#create-lb) кластера Kubernetes.

## Пространство имен {#namespace}

_Пространство имен_ — абстракция, которая логически изолирует ресурсы кластера Kubernetes и распределяет [квоты](https://console.yandex.cloud/cloud?section=quotas) на них. Это полезно для разделения ресурсов разных команд и проектов в одном кластере Kubernetes.

## Сервисные аккаунты {#service-accounts}

В кластерах Managed Service for Kubernetes используется два типа сервисных аккаунтов:
* **Облачные сервисные аккаунты**

  Эти аккаунты существуют на уровне отдельного каталога в облаке и могут использоваться как Managed Service for Kubernetes, так и другими сервисами.

  Подробнее см. в разделе [Управление доступом в Managed Service for Kubernetes](../security/index.md) и [Сервисные аккаунты](../../iam/concepts/users/service-accounts.md).
* **Сервисные аккаунты Kubernetes**

  Эти аккаунты существуют и действуют только на уровне отдельного кластера Managed Service for Kubernetes. Они применяются Kubernetes для:
  * Аутентификации запросов к API кластера от приложений, развернутых в кластере.
  * Настройки прав доступа для этих приложений.

  Набор сервисных аккаунтов Kubernetes автоматически создается в пространстве имен `kube-system` при развертывании кластера Managed Service for Kubernetes.

  Для аутентификации внутри кластера Kubernetes, к которому относится сервисный аккаунт, создайте токен этого аккаунта вручную.

  Подробнее см. в [Создание статического файла конфигурации](../operations/connect/create-static-conf.md), а также в [документации Kubernetes](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/).

{% note warning %}

Не путайте [облачные сервисные аккаунты](../security/index.md#sa-annotation) и сервисные аккаунты Kubernetes.

В документации сервиса под _сервисным аккаунтом_ понимается облачный сервисный аккаунт, если не указано иное.

{% endnote %}

## Статистика кластера Managed Service for Kubernetes {#metrics}

Managed Service for Kubernetes автоматически отправляет метрики кластеров в сервис [Yandex Monitoring](../../monitoring/index.md). Доступны метрики следующих объектов Kubernetes:

* контейнер;
* [мастер](index.md#master);
* [узел](index.md#node-group);
* [под](index.md#pod);
* [постоянный том](volume.md#persistent-volume).

Метрики кластеров можно получить с помощью следующих инструментов:

* [консоль управления](https://console.yandex.cloud);
* [интерфейс Monitoring](https://monitoring.yandex.cloud);
* [API Monitoring](../../monitoring/api-ref/authentication.md);
* приложение [Metrics Provider](https://yandex.cloud/ru/marketplace/products/yc/metric-provider);
* приложение [Prometheus Operator](https://yandex.cloud/ru/marketplace/products/yc/prometheus-operator).

Подробнее читайте в разделе [Мониторинг состояния кластера Managed Service for Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-get-stats.md).

Описание метрик приводится в разделе [Справочник метрик Yandex Monitoring](../metrics.md).

## Примеры использования {#examples}

* [Создание и настройка кластера Kubernetes без доступа в интернет](../tutorials/k8s-cluster-with-no-internet.md)
* [Резервное копирование кластера Managed Service for Kubernetes в Object Storage](../tutorials/kubernetes-backup.md)
* [Мониторинг кластера с помощью Prometheus Operator с поддержкой Yandex Monitoring](../tutorials/prometheus-grafana-monitoring.md)
* [Использование групп узлов с GPU без предустановленных драйверов](../tutorials/driverless-gpu.md)

#### Полезные ссылки {#see-also}

* [Kubernetes: для чего он нужен, как работает и почему стал стандартом в контейнеризации](https://yandex.cloud/ru/blog/posts/2025/03/kubernetes-guide)