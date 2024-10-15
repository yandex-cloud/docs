# Референсная архитектура для облачной инфраструктуры в изолированном режиме без доступа в интернет

Одним из клиентских сценариев в {{ yandex-cloud }} является развертывание облачной инфраструктуры без доступа в интернет. Облачные ресурсы должны быть доступны только из собственной инфраструктуры клиента ([on‑premise](https://en.wikipedia.org/wiki/On-premises_software)) и недоступны из интернет. Если для работы облачных ресурсов требуется сетевое взаимодействие с внешними ресурсами в интернет, то этот трафик должен проходить через собственную инфраструктуру клиента (например, межсетевые экраны), осуществляющую контроль доступа в интернет.

Раздел содержит рекомендации для реализации данного сценария.

## Организация сетевого взаимодействия

Для данного сценария рекомендуемым способом организации сетевой IP-связности между ресурсами в собственной инфраструктуре клиента и облачными ресурсами в {{ yandex-cloud }} является подключение [{{ interconnect-name }}](../../interconnect/concepts/):
* С использованием выделенных физических каналов сетевое оборудование клиента подключается к оборудованию {{ yandex-cloud }} в [точках присутствия](../../interconnect/concepts/pops) напрямую с помощью кроссировки или через операторов связи.
* Через подключения {{ interconnect-name }} возможна организация логических соединений как в [облачные сети](../../interconnect/concepts/priv-con) клиента, так и к [сервисам](../../interconnect/concepts/pub-con) {{ yandex-cloud }} (например, [{{ objstorage-name }}](../../storage)).
* Для обеспечения отказоустойчивости в предоставлении услуги {{ interconnect-name }} рекомендуется организовывать подключения на нескольких [точках присутствия](../../interconnect/concepts/pops).
* Подробные инструкции для подключения и управления услугой {{ interconnect-name }} приведены в [документации](../../interconnect/operations/).

## Управление ресурсами и доступом
Ресурсная модель {{ yandex-cloud }} предполагает, что любой пользователь облака с правами `editor` или `admin` на ресурс может изменять его характеристики. В сценарии изолированной инфраструктуры возникает риск несанкционированного изменения характеристик ресурса, что нарушает модель угроз с точки зрения изоляции. Подобные события рекомендуется отслеживать через логи аудита сервиса ([{{ at-name }}](../../audit-trails/)) и настройку оповещений в [SIEM](https://ru.wikipedia.org/wiki/SIEM), однако существует и проактивный подход к контролю изменений защищаемой среды.

GitOps - подход к управлению инфраструктурой через формальное описание продуктовой инфраструктуры в коде ([Infrastructure as Code](https://ru.wikipedia.org/wiki/%D0%98%D0%BD%D1%84%D1%80%D0%B0%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0_%D0%BA%D0%B0%D0%BA_%D0%BA%D0%BE%D0%B4)) согласно модели угроз и применение изменений всех компонентов инфраструктуры через пул-реквесты в репозиторий исходного кода с последующим применением изменений в контексте сервисного аккаунта {{ yandex-cloud }}. Всем пользователям облака при этом должна быть назначена роль `auditor` или `viewer` на все сервисы продуктивной среды. Это позволяет нивелировать риски:
* несанкционированного доступа к ресурсам и данным;
* несанкционированного копирования или удаления ресурсов и данных администраторами облака;
* несанкционированного изменения ресурсов, влекущего нарушение модели угроз (например назначение публичного IP-адреса на сетевой интерфейс или создание шлюза в сеть интернет);
* любых неформализованных ("ручных") изменений с использованием повышенных привилегий.

Так как любое изменение подразумевает создание пул-реквеста в репозиторий исходного кода согласно принципам DevOps, то верификация и принятие решения о применении изменений зависит от ревьюеров (ответственных сотрудников). Изменения проверяются на корректность другими сотрудниками, исключая единоличное принятие решения автором пул-реквеста. При таком подходе вся история изменений ведется средствами системы управления репозиториями кода. На уровне организации {{ yandex-cloud }} у пользователей не должно быть административных привилегий, а все необходимые роли для различных сред следует выдавать через членство в группах субъектов.

Для управления репозиториями с кодом {{ yandex-cloud }} предоставляет сервис [{{ mgl-full-name }}](../../managed-gitlab).

## Требования к облачным сервисам

Ниже рассмотрены рекомендации по реализации данного сценария на примере основных сервисов {{ yandex-cloud }}: 
* [{{ compute-name }}](#computecloud)
* [{{ vpc-name }}](#virtualprivatecloud)
* [{{ network-load-balancer-name }}](#networkloadbalancer)
* [{{ alb-name }}](#applicationloadbalancer)
* [{{ managed-k8s-name }}](#managedserviceforkubernetes)
* [{{ mpg-name }}](#managedserviceforpostgresql)
* [{{ mch-name }}](#managedserviceforclickhouse)
* [{{ sf-name }} и {{ serverless-containers-name }}](#cloudfunctionsiserverlesscontainers)

По особенностям реализации доступа в интернет для других сервисов {{ yandex-cloud }} рекомендуется обращаться к [документации](../..) соответствующего сервиса.

### {{ compute-name }} {#computecloud}

Виртуальные машины не должны иметь [публичных IP-адресов](../../compute/concepts/network#public-ip). 

{% list tabs group=instructions %}

- Консоль управления {#console}

   {% note info %}
   
   Способ проверки через консоль не показывает публичных IP-адресов остановленных ВМ. В таком случае рекомендуется использовать проверку через CLI.
   
   {% endnote %}

   1. Откройте [консоль управления]({{ link-console-main }}) в вашем браузере.
   1. Перейдите в нужный каталог.
   1. Перейдите в раздел **{{ ui-key.yacloud.component.navigation-menu.label_vpc }} / {{ ui-key.yacloud.vpc.addresses.label_title }}**.
   1. Если Вы видите сообщение `У вас пока нет публичных IP-адресов` или зарезервированные публичные IP-адреса не используются для ВМ, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

- CLI {#cli}

   1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:
      
      ```
      yc organization-manager organization list
      ```
      
   1. Выполните команду для поиска всех ВМ с публичными IP-адресами:
      
      ```bash
      export ORG_ID=<ID организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do VM_LIST=$(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.network_interfaces[].primary_v4_address.one_to_one_nat)' | jq -r '.id');
      if [ -n "$VM_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nVM_ID:\n$VM_LIST\n-----\n"; fi;
      done;
      done
      ```
    
   1. Если вывод команды пустой, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}


**Инструкции и решения по выполнению:**
* Не выдавайте пользователям [ролей](../../vpc/security/), позволяющих создавать публичные IP-адреса для виртуальных машин. Роли, которые дают возможность назначения публичных IP-адресов для ВМ: `admin`, `editor`, `vpc.admin`, `vpc.publicAdmin`.
* В случае наличия публичных IP-адресов на ВМ [отвяжите](../../compute/operations/vm-control/vm-detach-public-ip) их и, если это были статические IP-адреса, [удалите](../../vpc/operations/address-delete) их.

### {{ vpc-name }} {#virtualprivatecloud}

В облачной сети не должно быть [NAT-шлюзов](../../vpc/concepts/gateways), через которые может быть предоставлен доступ в интернет для облачных ресурсов.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Откройте [консоль управления]({{ link-console-main }}) в вашем браузере.
   1. Перейдите в нужный каталог.
   1. Перейдите в раздел **{{ ui-key.yacloud.component.navigation-menu.label_vpc }} / {{ ui-key.yacloud.vpc.gateways.label_gateways }}**.
   1. Если Вы видите сообщение `Нет ни одного шлюза`, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

- CLI {#cli}

   1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:
      
      ```
      yc organization-manager organization list
      ```

   1. Выполните команду для поиска наличия NAT-шлюзов:
      
      ```bash
      export ORG_ID=<ID организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do NAT_GW_LIST=$(yc vpc gateway list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.id)' | jq -r '.id');
      if [ -n "$NAT_GW_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nNAT_GW:\n$NAT_GW_LIST\n-----\n"; fi;
      done;
      done
      ```

   1. Если вывод команды пустой, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**
* Не выдавайте пользователям [ролей](../../vpc/security/), позволяющих создавать NAT-шлюзы. Роли, которые дают возможность создания NAT-шлюзов: `admin`, `editor`, `vpc.gateways.editor`, `vpc.admin`, `vpc.publicAdmin`.
* В случае наличия NAT-шлюзов [удалите](../../vpc/operations/delete-nat-gateway) их.

### {{ network-load-balancer-name }} {#networkloadbalancer}

Сетевой балансировщик [{{ network-load-balancer-name }}](../../network-load-balancer/concepts/) можно развернуть в следующих вариантах:
* Внешний балансировщик — создается по умолчанию. Имеет публичный IP-адрес и используется для обработки трафика из интернета. 
* Внутренний балансировщик — используется для обработки трафика внутри {{ vpc-short-name }}. Имеет внутренний IP-адрес.

В облачной инфраструктуре не должно быть внешних балансировщиков. Допустимо использование внутренних балансировщиков. 

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Откройте [консоль управления]({{ link-console-main }}) в вашем браузере.
   1. Перейдите в нужный каталог.
   1. Перейдите в раздел **{{ ui-key.yacloud.component.navigation-menu.label_load-balancer }} / {{ ui-key.yacloud.load-balancer.network-load-balancer.label_list }}**.
   1. Если в списке отсутствуют балансировщики с типом `EXTERNAL`, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

- CLI {#cli}

   1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:
      
      ```
      yc organization-manager organization list
      ```
      
   1. Выполните команду для поиска всех внешних балансировщиков:
      
      ```bash
      export ORG_ID=<ID организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do NLB_LIST=$(yc load-balancer network-load-balancer list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.type == "EXTERNAL")' | jq -r '.id');
      if [ -n "$NLB_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nNLB_ID:\n$NLB_LIST\n-----\n"; fi;
      done;
      done
      ```
      
   1. Если вывод команды пустой, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**
* Не выдавайте пользователям [ролей](../../network-load-balancer/security/), позволяющих создавать внешние балансировщики. Роли, которые дают возможность создания внешних балансировщиков: `admin`, `editor`, `load-balancer.admin`.
* В случае наличия внешних балансировщиков [удалите](../../network-load-balancer/operations/load-balancer-delete) их.

### {{ alb-name }} {#applicationloadbalancer}

У L7-балансировщиков [{{ alb-name }}](../../application-load-balancer/concepts/application-load-balancer) не должно быть публичных IP-адресов на обработчиках. Допускается использование внутренних IP-адресов на обработчиках.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Откройте [консоль управления]({{ link-console-main }}) в вашем браузере.
   1. Перейдите в нужный каталог.
   1. Перейдите в раздел **{{ ui-key.yacloud.component.navigation-menu.label_vpc }} / {{ ui-key.yacloud.vpc.addresses.label_title }}**.
   1. Если Вы видите сообщение `У вас пока нет публичных IP-адресов` или зарезервированные публичные IP-адреса не используются для обработчиков L7-балансировщиков, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

- CLI {#cli}

   1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:
      
      ```
      yc organization-manager organization list
      ```
      
   1. Выполните команду для поиска всех L7-балансировщиков с публичными IP-адресами на обработчиках:
      
      ```bash
      export ORG_ID=<ID организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do ALB_LIST=$(yc application-load-balancer load-balancer list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(has("listeners")) | select(.listeners[].endpoints[].addresses[].external_ipv4_address)' | jq -r '.id' );
      if [ -n "$ALB_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nALB_ID:\n$ALB_LIST\n-----\n" | sort -u; fi;
      done;
      done
      ```

   1. Если вывод команды пустой, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**
* Не выдавайте пользователям [ролей](../../application-load-balancer/security/), позволяющих назначать публичные IP-адреса на обработчики L7-балансировщиков. Роли, которые дают возможность назначения публичных IP-адресов на обработчики L7-балансировщиков: `admin`, `editor`, `vpc.admin`, `vpc.publicAdmin`.
* В случае наличия публичных IP-адресов на обработчиках L7-балансировщиках [удалите эти обработчики](../../application-load-balancer/operations/application-load-balancer-update#delete-listener) и, если это были статические IP-адреса, [удалите](../../vpc/operations/address-delete) их.

### {{ managed-k8s-name }} {#managedserviceforkubernetes}

У кластера и группы узлов {{ managed-k8s-name }} не должно быть [публичных IP-адресов](../../managed-kubernetes/concepts/network#public-access-to-a-host). В облачной сети, где размещается кластер и группа узлов, не должно быть [NAT-шлюзов](../../vpc/concepts/gateways). У сервисных аккаунтов для кластера не должно быть ролей на создание балансировщиков, имеющих доступ в интернет (см. пункт «Инструкции и решения по выполнению»).

Подробности по созданию и настройке кластера {{ managed-k8s-name }} без доступа в интернет смотрите в [практическом руководстве](../../managed-kubernetes/tutorials/k8s-cluster-with-no-internet). В руководстве указаны минимальные роли, которые необходимо назначить сервисным аккаунтам для создания такого кластера.

{% list tabs group=instructions %}

- Консоль управления {#console}

   {% note info %}
   
   Способ проверки через консоль подразумевает проверку наличия публичного доступа для каждого кластера по отдельности. При большом количестве кластеров рекомендуется использовать проверку через CLI.
   
   {% endnote %}

   {% note info %}
   
   Способ проверки через консоль не показывает публичных IP-адресов узлов остановленного кластера. В таком случае рекомендуется использовать проверку через CLI.
   
   {% endnote %}

   1. Откройте [консоль управления]({{ link-console-main }}) в вашем браузере.
   1. Перейдите в нужный каталог.
   1. Перейдите в раздел **{{ ui-key.yacloud.component.navigation-menu.label_managed-kubernetes }}** и выберите кластер.
   1. Если на вкладке **{{ ui-key.yacloud.k8s.cluster.overview.label_title }}** поле `Публичный IPv4` у кластера отсутствует, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».
   1. Перейдите в раздел **{{ ui-key.yacloud.component.navigation-menu.label_vpc }} / {{ ui-key.yacloud.vpc.addresses.label_title }}**.
   1. Если Вы видите сообщение `У вас пока нет публичных IP-адресов` или зарезервированные публичные IP-адреса не используются для ВМ (узлов кластера) или L7-балансировщиков, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».
   1. Перейдите в раздел **{{ ui-key.yacloud.component.navigation-menu.label_vpc }} / {{ ui-key.yacloud.vpc.gateways.label_gateways }}**.
   1. Если Вы видите сообщение `Нет ни одного шлюза`, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».
   1. Перейдите в раздел **{{ ui-key.yacloud.component.navigation-menu.label_load-balancer }} / {{ ui-key.yacloud.load-balancer.network-load-balancer.label_list }}**.
   1. Если в списке отсутствуют балансировщики с типом `EXTERNAL`, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

- CLI {#cli}

   1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:
      
      ```
      yc organization-manager organization list
      ```
      
   1. Выполните команду для поиска всех кластеров с публичными адресами:
      
      ```bash
      export ORG_ID=<ID организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do CLUSTER_LIST=$(yc managed-kubernetes cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.master.endpoints.external_v4_endpoint)' | jq -r '.id');
      if [ -n "$CLUSTER_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nK8S_CLUSTER_ID:\n$CLUSTER_LIST\n-----\n"; fi;
      done;
      done
      ```

   1. Выполните команду для поиска всех групп узлов с публичными IP-адресами:
      
      ```bash
      export ORG_ID=<ID организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do NODE_GROUP_LIST=$(yc managed-kubernetes node-group list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.node_template.network_interface_specs[].primary_v4_address_spec.one_to_one_nat_spec)' | jq -r '.id');
      if [ -n "$NODE_GROUP_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nNODE_GROUP:\n$NODE_GROUP_LIST\n-----\n"; fi;
      done;
      done
      ```
      
   1. Выполните команду для поиска наличия NAT-шлюзов:
      
      ```bash
      export ORG_ID=<ID организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do NAT_GW_LIST=$(yc vpc gateway list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.id)' | jq -r '.id');
      if [ -n "$NAT_GW_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nNAT_GW:\n$NAT_GW_LIST\n-----\n"; fi;
      done;
      done
      ```
      
   1. Выполните команду для поиска наличия внешних балансировщиков NLB:
      
      ```bash
      export ORG_ID=<ID организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do NLB_LIST=$(yc load-balancer network-load-balancer list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.type == "EXTERNAL")' | jq -r '.id');
      if [ -n "$NLB_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nNLB_ID:\n$NLB_LIST\n-----\n"; fi;
      done;
      done
      ```
      
   1. Выполните команду для поиска всех L7-балансировщиков с публичными IP-адресами на обработчиках:
      
      ```bash
      export ORG_ID=<ID организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do ALB_LIST=$(yc application-load-balancer load-balancer list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(has("listeners")) | select(.listeners[].endpoints[].addresses[].external_ipv4_address)' | jq -r '.id' );
      if [ -n "$ALB_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nALB_ID:\n$ALB_LIST\n-----\n" | sort -u; fi;
      done;
      done
      ```

   1. Если выводы всех команд пустые, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**
* Не выдавайте сервисным аккаунтам для кластера {{ k8s }} [ролей](../../managed-kubernetes/security/), позволяющих использовать публичные IP-адреса для кластера или группы узлов и создавать балансировщики, имеющие доступ в интернет. Роли, которые дают возможность создавать кластера с доступом в интернет: `admin`, `editor`, `load-balancer.admin`, `vpc.admin`, `vpc.publicAdmin`.
* В случае наличия кластеров с публичными IP-адресами [удалите](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete) их. Для таких кластеров нет возможности удалить непосредственно публичный IP-адрес. Перед удалением кластеров перенесите рабочую нагрузку на кластера Kubernetes без публичных IP-адресов.
* В случае наличия групп узлов с публичными IP-адресами [измените](../../managed-kubernetes/operations/node-group/node-group-update) их, чтобы публичные IP-адреса не назначались узлам.
* В случае наличия внешних балансировщиков для [ресурсов Service](../../managed-kubernetes/nlb-ref/service) удалите их. 
* В случае наличия  публичных IP-адресов для [Ingress-контроллеров {{ alb-name }}](../../managed-kubernetes/alb-ref/ingress) удалите их. 
* Не выдавайте пользователям [ролей](../../vpc/security/), позволяющих создавать NAT-шлюзы. Роли, которые дают возможность создания NAT-шлюзов: `admin`, `editor`, `vpc.gateways.editor`, `vpc.admin`, `vpc.publicAdmin`.
* В случае наличия NAT-шлюзов [удалите](../../vpc/operations/delete-nat-gateway) их.


### {{ mpg-name }} { #managedserviceforpostgresql }

У хостов в кластере не должно быть [публичного доступа](../../managed-postgresql/concepts/network#public-access-to-a-host).

{% list tabs group=instructions %}

- Консоль управления {#console}

   {% note info %}
   
   Способ проверки через консоль подразумевает проверку наличия публичного доступа у хостов для каждого кластера по отдельности. При большом количестве кластеров рекомендуется использовать проверку через CLI.
   
   {% endnote %}

   1. Откройте [консоль управления]({{ link-console-main }}) в вашем браузере.
   1. Перейдите в нужный каталог.
   1. Перейдите в раздел **{{ ui-key.yacloud.component.navigation-menu.label_managed-postgresql }}**. Зайдите в кластер и перейдите в раздел **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**. 
   1. Если в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_public-ip }}** для всех хостов кластера указано значение `Нет`, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

- CLI {#cli}

   1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:
      
      ```
      yc organization-manager organization list
      ```
      
   1. Выполните команду для поиска всех хостов с публичными IP-адресами в кластерах:
      
      ```bash
      export ORG_ID=<ID организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for PG_CLUSTER_ID in $(yc managed-postgresql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      do HOST_LIST=$(yc managed-postgresql hosts list --cluster-id=$PG_CLUSTER_ID --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.assign_public_ip)' | jq -r '.name' );
      if [ -n "$HOST_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nPG_CLUSTER_ID: $PG_CLUSTER_ID\nHOST_NAME:\n$HOST_LIST\n-----\n"; fi
      done;
      done;
      done
      ```

   1. Если вывод команды пустой, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**
* Не выдавайте пользователям [ролей](../../managed-postgresql/security/), позволяющих настроить публичный доступ к хостам кластера. Роли, которые дают возможность настроить публичный доступ к хостам: `admin`, `editor`, `vpc.admin`, `vpc.publicAdmin`.
* В случае наличия публичного доступа у хостов в кластере [выключите](../../managed-postgresql/operations/hosts#update) для них опцию публичного доступа.

### {{ mch-name }} { #managedserviceforclickhouse }

У хостов в кластере не должно быть [публичного доступа](../../managed-clickhouse/concepts/network#public-access-to-a-host).

{% list tabs group=instructions %}

- Консоль управления {#console}

   {% note info %}

   Способ проверки через консоль подразумевает проверку наличия публичного доступа у хостов для каждого кластера по отдельности. При большом количестве кластеров рекомендуется использовать проверку через CLI.

   {% endnote %}

   1. Откройте [консоль управления]({{ link-console-main }}) в вашем браузере.
   1. Перейдите в нужный каталог.
   1. Перейдите в раздел **{{ ui-key.yacloud.component.navigation-menu.label_managed-clickhouse }}**. Зайдите в кластер и перейдите в раздел **{{ ui-key.yacloud.clickhouse.cluster.switch_hosts }}**. 
   1. Если в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_public-ip }}** для всех хостов кластера указано значение `Нет`, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

- CLI {#cli}

   1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:
      
      ```
      yc organization-manager organization list
      ```
      
   2. Выполните команду для поиска всех хостов с публичными IP-адресами в кластерах:
      
      ```bash
      export ORG_ID=<ID организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for CH_CLUSTER_ID in $(yc managed-clickhouse cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      do HOST_LIST=$(yc managed-clickhouse hosts list --cluster-id=$CH_CLUSTER_ID --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.assign_public_ip)' | jq -r '.name' );
      if [ -n "$HOST_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nCH_CLUSTER_ID: $CH_CLUSTER_ID\nHOST_NAME:\n$HOST_LIST\n-----\n"; fi
      done;
      done;
      done
      ```

   3. Если вывод команды пустой, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**
* Не выдавайте пользователям [ролей](../../managed-clickhouse/security), позволяющих настроить публичный доступ к хостам кластера. Роли, которые дают возможность настроить публичный доступ к хостам: `admin`, `editor`, `vpc.admin`, `vpc.publicAdmin`.
* В случае наличия публичного доступа у хостов в кластере [выключите](../../managed-clickhouse/operations/hosts#update)  для них опцию публичного доступа.

### {{ sf-name }} и {{ serverless-containers-name }} { #cloudfunctionsiserverlesscontainers }

В облачной инфраструктуре не должно быть функций или контейнеров. 

По умолчанию функция или контейнер запускается в изолированной IP-сети с включенным NAT-шлюзом. Из функции или контейнера доступны публичные IPv4-адреса. В настройках [функции](../../functions/concepts/networking#user-network) или [контейнера](../../serverless-containers/concepts/networking#user-network) можно указать облачную сеть. Тогда функция будет иметь доступ не только в интернет, но и к пользовательским ресурсам, которые находятся в указанной {{ vpc-short-name }}, например базам данным, виртуальным машинам и другим ресурсам.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Откройте [консоль управления]({{ link-console-main }}) в вашем браузере.
   1. Перейдите в нужный каталог.
   1. Перейдите в раздел **{{ ui-key.yacloud.component.navigation-menu.label_serverless-functions }}**.
   1. Если Вы видите сообщение `Создайте вашу первую функцию`, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».
   1. Перейдите в раздел **{{ ui-key.yacloud.component.navigation-menu.label_serverless-containers }}**.
   1. Если Вы видите сообщение `Создайте ваш первый контейнер`, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

- CLI {#cli}

   1. Посмотрите доступные вам организации и зафиксируйте необходимый `ID`:
      
      ```
      yc organization-manager organization list
      ```
      
   1. Выполните команду для поиска всех функций:
      
      ```bash
      export ORG_ID=<ID организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do FUNC_LIST=$(yc serverless function list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      if [ -n "$FUNC_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nFUNCTION_ID:\n$FUNC_LIST\n-----\n"; fi;
      done;
      done
      ```
      
   1. Если вывод команды пустой, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

   1. Выполните команду для поиска всех контейнеров:

      ```bash
      export ORG_ID=<ID организации>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do CONT_LIST=$(yc serverless containers list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      if [ -n "$CONT_LIST" ]; then printf "FOLDER_ID: $FOLDER_ID\nCONTAINER_ID:\n$CONT_LIST\n-----\n"; fi;
      done;
      done
      ```

   1. Если вывод команды пустой, рекомендация выполняется. В противном случае перейдите к пункту «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**
* Не выдавайте пользователям ролей, позволяющих создавать функции и контейнеры. [Роли](../../functions/security/), которые дают возможность создания функций: `admin`, `editor`, `functions.admin`, `functions.editor`. [Роли](../../serverless-containers/security/), которые дают возможность создания контейнеров: `admin`, `editor`, `serverless-containers.admin`, `serverless-containers.editor`.
* В случае наличия функций или контейнеров [удалите функции](../../functions/operations/function/function-delete) или [контейнеры](../../serverless-containers/operations/delete).