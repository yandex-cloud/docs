[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Kubernetes](../index.md) > Вопросы и ответы > Решение проблем

# Решение проблем в Managed Service for Kubernetes

* [Ошибка при создании кластера в облачной сети другого каталога](#neighbour-catalog-permission-denied)

* [Пространство имен удалено, но все еще находится в статусе Terminating и не удаляется](#namespace-terminating)

* [Использую Yandex Network Load Balancer вместе с Ingress-контроллером, почему некоторые узлы моего кластера находятся в состоянии UNHEALTHY?](#nlb-ingress)

* [Почему созданный PersistentVolumeClaim остается в статусе Pending?](#pvc-pending)

* [Почему кластер Managed Service for Kubernetes не запускается после изменения конфигурации его узлов?](#not-starting)

* [Ошибка при обновлении сертификата Ingress-контроллера](#ingress-certificate)

* [Почему в кластере не работает разрешение имен DNS?](#not-resolve-dns)

* [При создании группы узлов через CLI возникает конфликт параметров. Как его решить?](#conflicting-flags)

* [Ошибка при подключении к кластеру с помощью `kubectl`](#connect-to-cluster)

* [Ошибки при подключении к узлу по SSH](#node-connect)

* [Как выдать доступ в интернет узлам кластера Managed Service for Kubernetes?](#internet)

* [Почему я не могу выбрать Docker в качестве среды запуска контейнеров?](#docker-runtime)

* [Ошибка при подключении репозитория GitLab к Argo CD](#argo-cd)

* [При развертывании обновлений приложения в кластере с Yandex Application Load Balancer наблюдается потеря трафика](#alb-traffic-lost)

* [Некорректно отображается системное время в консоли Linux, а также в журналах контейнеров и подов кластера Managed Service for Kubernetes](#time)

* [Что делать, если я удалил сетевой балансировщик нагрузки или целевые группы Yandex Network Load Balancer, автоматически созданные для сервиса типа LoadBalancer?](#deleted-loadbalancer-service)

* [Ошибка при подключении виртуальной машины Yandex Compute Cloud в качестве внешнего узла Managed Service for Kubernetes](#vm-as-external-node)

В этом разделе описаны типичные проблемы, которые могут возникать при работе Managed Service for Kubernetes, и методы их решения.

#### Ошибка при создании кластера в облачной сети другого каталога {#neighbour-catalog-permission-denied}

Текст ошибки:

```text
Permission denied
```

Ошибка возникает из-за отсутствия у [сервисного аккаунта для ресурсов](../security/index.md#sa-annotation) необходимых [ролей](../../iam/concepts/access-control/roles.md) в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), [облачная сеть](../../vpc/concepts/network.md#network) которого выбирается при создании.

Чтобы создать [кластер Managed Service for Kubernetes](../concepts/index.md#kubernetes-cluster) в облачной сети другого каталога, [назначьте](../../iam/operations/sa/assign-role-for-sa.md) [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) для ресурсов следующие роли в этом каталоге:
* [vpc.privateAdmin](../../vpc/security/index.md#vpc-private-admin)
* [vpc.user](../../vpc/security/index.md#vpc-user)

Для использования [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) дополнительно [назначьте](../../iam/operations/sa/assign-role-for-sa.md) роль [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin).

#### Пространство имен удалено, но все еще находится в статусе Terminating и не удаляется {#namespace-terminating}

Такое случается, когда в [пространстве имен](../concepts/index.md#namespace) остаются зависшие ресурсы, которые контроллер пространства не может удалить.

Чтобы устранить проблему, вручную удалите зависшие ресурсы.

{% list tabs %}

- CLI

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. [Подключитесь к кластеру Managed Service for Kubernetes](../operations/connect/index.md).
  1. Узнайте, какие ресурсы остались в пространстве имен:

     ```bash
     kubectl api-resources --verbs=list --namespaced --output=name \
       | xargs --max-args=1 kubectl get --show-kind \
       --ignore-not-found --namespace=<пространство_имен>
     ```

  1. Удалите найденные ресурсы:

     ```bash
     kubectl delete <тип_ресурса> <имя_ресурса> --namespace=<пространство_имен>
     ```

  Если после этого пространство имен все равно находится в статусе `Terminating` и не удаляется, удалите его принудительно, использовав `finalizer`:
  1. Включите проксирование API Kubernetes на ваш локальный компьютер:

     ```bash
     kubectl proxy
     ```

  1. Удалите пространство имен:

     ```bash
     kubectl get namespace <пространство_имен> --output=json \
       | jq '.spec = {"finalizers":[]}' > temp.json && \
     curl --insecure --header "Content-Type: application/json" \
       --request PUT --data-binary @temp.json \
       127.0.0.1:8001/api/v1/namespaces/<пространство_имен>/finalize
     ```

    Не рекомендуется сразу удалять пространство имен в статусе `Terminating` с помощью `finalizer`, так как при этом зависшие ресурсы могут остаться в кластере Managed Service for Kubernetes.

{% endlist %}

#### Использую Yandex Network Load Balancer вместе с Ingress-контроллером, почему некоторые узлы моего кластера находятся в состоянии UNHEALTHY? {#nlb-ingress}

Это нормальное поведение [балансировщика нагрузки](../../network-load-balancer/concepts/index.md) при политике `External Traffic Policy: Local`. Статус `HEALTHY` получают только те [узлы Managed Service for Kubernetes](../concepts/index.md#node-group), [поды](../concepts/index.md#pod) которых готовы принимать пользовательский трафик. Оставшиеся узлы помечаются как `UNHEALTHY`.

Чтобы узнать тип политики балансировщика, созданного с помощью сервиса типа `LoadBalancer`, выполните команду:

```bash
kubectl describe svc <имя_сервиса_типа_LoadBalancer> \
| grep 'External Traffic Policy'
```

Подробнее в разделе [Параметры сервиса типа LoadBalancer](../operations/create-load-balancer.md#advanced).

#### Почему созданный PersistentVolumeClaim остается в статусе Pending? {#pvc-pending}

Это нормальное поведение [PersistentVolumeClaim](../concepts/volume.md#persistent-volume). Созданный PVC находится в статусе **Pending**, пока не будет создан под, который должен его использовать.

Чтобы перевести PVC в статус **Running**:
1. Просмотрите информацию о PVC:

   ```bash
   kubectl describe pvc <имя_PVC> \
     --namespace=<пространство_имен>
   ```

   Где `--namespace` — пространство имен, в котором находится PVC.

   Сообщение `waiting for first consumer to be created before binding` означает, что PVC ожидает создания пода.
1. [Создайте под](../operations/volumes/dynamic-create-pv.md#create-pod) для этого PVC.

#### Почему кластер Managed Service for Kubernetes не запускается после изменения конфигурации его узлов? {#not-starting}

Проверьте, что новая конфигурация узлов Managed Service for Kubernetes не превышает [квоты](../concepts/limits.md):

{% list tabs %}

- CLI

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы провести диагностику узлов кластера Managed Service for Kubernetes:
  1. [Подключитесь к кластеру Managed Service for Kubernetes](../operations/connect/index.md).
  1. Проверьте состояние узлов Managed Service for Kubernetes:

     ```bash
     yc managed-kubernetes cluster list-nodes <идентификатор_кластера>
     ```

     Сообщение о том, что ресурсы кластера Managed Service for Kubernetes исчерпаны, отображается в первом столбце вывода команды. Пример:

     ```text
     +--------------------------------+-----------------+------------------+-------------+--------------+
     |         CLOUD INSTANCE         | KUBERNETES NODE |     RESOURCES    |     DISK    |    STATUS    |
     +--------------------------------+-----------------+------------------+-------------+--------------+
     | fhmil14sdienhr5uh89no          |                 | 2 100% core(s),  | 64.0 GB hdd | PROVISIONING |
     | CREATING_INSTANCE              |                 | 4.0 GB of memory |             |              |
     | [RESOURCE_EXHAUSTED] The limit |                 |                  |             |              |
     | on total size of network-hdd   |                 |                  |             |              |
     | disks has exceeded.,           |                 |                  |             |              |
     | [RESOURCE_EXHAUSTED] The limit |                 |                  |             |              |
     | on total size of network-hdd   |                 |                  |             |              |
     | disks has exceeded.            |                 |                  |             |              |
     +--------------------------------+-----------------+------------------+-------------+--------------+
     ```

{% endlist %}

Чтобы кластер Managed Service for Kubernetes запустился, [увеличьте квоты](../concepts/limits.md).

#### После изменения маски подсети узлов в настройках кластера количество подов, размещаемых на узлах, не соответствует ожидаемому {#count-pods}

**Решение**: пересоздайте группу узлов.

#### Ошибка при обновлении сертификата Ingress-контроллера {#ingress-certificate}

Текст ошибки:

```text
ERROR controller-runtime.manager.controller.ingressgroup Reconciler error
{"name": "some-prod", "namespace": , "error": "rpc error: code = InvalidArgument
desc = Validation error:\nlistener_specs[1].tls.sni_handlers[2].handler.certificate_ids:
Number of elements must be less than or equal to 1"}
```

Ошибка возникает, если для одного обработчика Ingress-контроллера указаны разные сертификаты.

**Решение**: исправьте и примените спецификации Ingress-контроллера таким образом, чтобы в описании каждого обработчика был указан только один сертификат.

#### Почему в кластере не работает разрешение имен DNS? {#not-resolve-dns}

Кластер Managed Service for Kubernetes может не выполнять разрешение имен внутренних и внешних DNS-запросов по нескольким причинам. Чтобы устранить проблему:
1. [Проверьте версию кластера Managed Service for Kubernetes и групп узлов](#check-version).
1. [Убедитесь, что CoreDNS работает](#check-coredns).
1. [Убедитесь, что кластеру Managed Service for Kubernetes достаточно ресурсов CPU](#check-cpu).
1. [Настройте автоматическое масштабирование](#dns-autoscaler).
1. [Настройте локальное кеширование DNS](#node-local-dns).

##### Проверьте версию кластера и групп узлов {#check-version}

1. Получите список актуальных версий Kubernetes:

   ```bash
   yc managed-kubernetes list-versions
   ```

1. Узнайте версию кластера Managed Service for Kubernetes:

   ```bash
   yc managed-kubernetes cluster get <имя_или_идентификатор_кластера> | grep version:
   ```

   Идентификатор и имя кластера Managed Service for Kubernetes можно получить со [списком кластеров в каталоге](../operations/kubernetes-cluster/kubernetes-cluster-list.md#list).
1. Узнайте версию группы узлов Managed Service for Kubernetes:

   ```bash
   yc managed-kubernetes node-group get <имя_или_идентификатор_группы_узлов> | grep version:
   ```

   Идентификатор и имя группы узлов Managed Service for Kubernetes можно получить со [списком групп узлов в кластере](../operations/node-group/node-group-list.md#list).
1. Если версии кластера Managed Service for Kubernetes или групп узлов не входят в список актуальных версий Kubernetes, [обновите их](../operations/update-kubernetes.md).

##### Убедитесь, что CoreDNS работает {#check-coredns}

Получите список подов CoreDNS и их состояние:

```bash
kubectl get pods -n kube-system -l k8s-app=kube-dns -o wide
```

Все поды должны находится в состоянии `Running`.

##### Убедитесь, что кластеру достаточно ресурсов CPU {#check-cpu}

1. Перейдите на [страницу каталога](https://console.yandex.cloud) и выберите сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного кластера Managed Service for Kubernetes и выберите вкладку **Управление узлами**.
1. Перейдите во вкладку **Узлы** и нажмите на имя любого узла Managed Service for Kubernetes.
1. Перейдите во вкладку **Мониторинг**.
1. Убедитесь, что на графике **CPU, [cores]** значения используемой мощности CPU `used` не достигают значений доступной мощности CPU `total`. Проверьте это для всех узлов кластера Managed Service for Kubernetes.

##### Настройте автоматическое масштабирование {#dns-autoscaler}

Настройте [автоматическое масштабирование DNS по размеру кластера Managed Service for Kubernetes](../tutorials/dns-autoscaler.md).

##### Настройте локальное кеширование DNS {#node-local-dns}

[Настройте NodeLocal DNS Cache](../tutorials/node-local-dns.md). Чтобы применить оптимальные настройки, [установите NodeLocal DNS Cache из Yandex Cloud Marketplace](../operations/applications/node-local-dns.md#marketplace-install).

#### При создании группы узлов через CLI возникает конфликт параметров. Как его решить? {#conflicting-flags}

Проверьте, указаны ли параметры `--location`, `--network-interface` и `--public-ip` в одной команде. Если передать эти параметры вместе, возникают ошибки:
* Для пар `--location` и `--public-ip` или `--location` и `--network-interface`:

  ```text
  ERROR: rpc error: code = InvalidArgument desc = Validation error:
  allocation_policy.locations[0].subnet_id: can't use "allocation_policy.locations[0].subnet_id" together with "node_template.network_interface_specs"
  ```

* Для пары `--network-interface` и `--public-ip`:

  ```text
  ERROR: flag --public-ip cannot be used together with --network-interface. Use '--network-interface' option 'nat' to get public address
  ```

Передавайте в команде только один из трех параметров. Расположение группы узлов Managed Service for Kubernetes достаточно указать в `--location` либо `--network-interface`.

Чтобы выдать доступ в интернет узлам кластера Managed Service for Kubernetes, выполните одно из действий:
* Назначьте [публичные IP-адреса](../../vpc/concepts/address.md#public-addresses) узлам кластера, указав `--network-interface ipv4-address=nat` или `--network-interface ipv6-address=nat`.
* [Включите доступ к узлам Managed Service for Kubernetes из интернета](../operations/node-group/node-group-update.md#node-internet-access) после того, как создадите группу узлов.

#### Ошибка при подключении к кластеру с помощью `kubectl` {#connect-to-cluster}

Текст ошибки:

```text
ERROR: cluster has empty endpoint
```

Ошибка возникает, если [подключаться к кластеру](../operations/connect/index.md#kubectl-connect) без публичного IP-адреса, а учетные данные для `kubectl` получить для публичного IP-адреса с помощью команды:

```bash
yc managed-kubernetes cluster \
   get-credentials <имя_или_идентификатор_кластера> \
   --external
```

Для подключения к внутреннему IP-адресу кластера с ВМ, находящейся в той же сети, получите учетные данные для `kubectl` с помощью команды:

```bash
yc managed-kubernetes cluster \
   get-credentials <имя_или_идентификатор_кластера> \
   --internal
```

Если вам нужно подключиться к кластеру из интернета, [пересоздайте кластер и предоставьте](../operations/kubernetes-cluster/kubernetes-cluster-create.md) ему публичный IP-адрес.

#### Ошибки при подключении к узлу по SSH {#node-connect}

Тексты ошибок:

```text
Permission denied (publickey,password)
```

```text
Too many authentication failures
```

Ошибки возникают [при подключении к узлу Managed Service for Kubernetes](../operations/node-connect-ssh.md) в следующих ситуациях:
* Публичный [SSH-ключ](../../glossary/ssh-keygen.md) не добавлен в метаданные группы узлов Managed Service for Kubernetes.

  **Решение**: [обновите ключи группы узлов Managed Service for Kubernetes](../operations/node-connect-ssh.md#node-add-metadata).
* Публичный SSH-ключ добавлен в метаданные группы узлов Managed Service for Kubernetes, но неправильно.

  **Решение**: [приведите файл с публичными ключами к необходимому формату](../operations/node-connect-ssh.md#key-format) и [обновите ключи группы узлов Managed Service for Kubernetes](../operations/node-connect-ssh.md#node-add-metadata).
* Приватный SSH-ключ не добавлен в аутентификационный агент (ssh-agent).

  **Решение**: добавьте приватный ключ с помощью команды `ssh-add <путь_к_файлу_приватного_ключа>`.

#### Как выдать доступ в интернет узлам кластера Managed Service for Kubernetes? {#internet}

Если узлам кластера Managed Service for Kubernetes не выдан доступ в интернет, при попытке подключения к интернету возникнет ошибка:

```text
Failed to pull image "cr.yandex/***": rpc error: code = Unknown desc = Error response from daemon: Gethttps://cr.yandex/v2/: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```

Есть несколько способов выдать доступ в интернет узлам кластера Managed Service for Kubernetes:
* Создайте и настройте [NAT-шлюз](../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../vpc/tutorials/nat-instance/index.md). В результате с помощью [статической маршрутизации](../../vpc/concepts/routing.md) трафик будет направлен через шлюз или отдельную [виртуальную машину](../../compute/concepts/vm.md) с функциями NAT.
* [Назначьте публичные IP-адреса группе узлов Managed Service for Kubernetes](../operations/node-group/node-group-update.md#node-internet-access).

{% note info %}

Если вы назначили публичные IP-адреса узлам кластера и затем настроили NAT-шлюз или NAT-инстанс, доступ в интернет через публичные адреса пропадет. Подробнее читайте в [документации сервиса Yandex Virtual Private Cloud](../../vpc/concepts/routing.md#internet-routes).

{% endnote %}

#### Почему я не могу выбрать Docker в качестве среды запуска контейнеров? {#docker-runtime}

Среда запуска контейнеров Docker не поддерживается в кластерах с версией Kubernetes 1.24 и выше. Доступна только среда [containerd](https://containerd.io/).

#### Ошибка при подключении репозитория GitLab к Argo CD {#argo-cd}

Текст ошибки:

```text
FATA[0000] rpc error: code = Unknown desc = error testing repository connectivity: authorization failed
```

Ошибка возникает, если доступ в GitLab по протоколу HTTP(S) отключен.

**Решение**: включите доступ. Для этого:

  1. В GitLab на панели слева выберите **Admin → Settings → General**.
  1. В блоке **Visibility and access controls** найдите настройку **Enabled Git access protocols**.
  1. Выберите в списке пункт, разрешающий доступ по протоколу HTTP(S).

  [Подробнее в документации GitLab](https://docs.gitlab.com/administration/settings/visibility_and_access_controls/#configure-enabled-git-access-protocols).

#### При развертывании обновлений приложения в кластере с Yandex Application Load Balancer наблюдается потеря трафика {#alb-traffic-lost}

Если трафик вашего приложения управляется балансировщиком Application Load Balancer и для Ingress-контроллера балансировщика включена [политика управления трафиком](../nlb-ref/service.md#servicespec) `externalTrafficPolicy: Local`, то запросы обслуживаются приложением на том узле, куда запрос передал балансировщик. Передача трафика между узлами исключается.

[Проверка состояния по умолчанию](../../network-load-balancer/concepts/health-check.md) отслеживает состояние узла, а не приложения. Поэтому трафик с Application Load Balancer может направляться на узел, где отсутствует работающее приложение. При развертывании новой версии приложения в кластере [Ingress-контроллер Application Load Balancer](../../application-load-balancer/tools/k8s-ingress-controller/index.md) передает запрос балансировщику на изменение конфигурации группы бэкендов. Обработка запроса занимает не менее 30 секунд, и в течение этого времени приложение может не получать пользовательский трафик.

Чтобы исключить такую ситуацию, рекомендуется настраивать проверки состояния бэкендов на балансировщике Application Load Balancer. Благодаря проверкам состояния балансировщик своевременно отслеживает недоступные бэкенды и направляет трафик на другие бэкенды. После обновления приложения трафик будет снова распределен на все бэкенды.

Подробнее в разделах [Рекомендации по настройке проверок состояния Yandex Application Load Balancer](../../application-load-balancer/concepts/best-practices.md) и [Аннотации (metadata.annotations)](../../application-load-balancer/k8s-ref/service-for-ingress.md#annotations).

#### Некорректно отображается системное время на узлах, а также в журналах контейнеров и подов кластера Managed Service for Kubernetes {#time}

Время кластера Managed Service for Kubernetes может расходиться со временем других ресурсов, например виртуальной машины, если они используют для синхронизации часов разные источники. Например, кластер Managed Service for Kubernetes синхронизируется со служебным сервером времени (по умолчанию), а ВМ синхронизируется с собственным или публичным NTP-сервером.

**Решение**: настройте синхронизацию времени кластера Managed Service for Kubernetes с собственным NTP-сервером. Для этого:

1. Укажите адреса NTP-серверов в [настройках DHCP](../../vpc/concepts/dhcp-options.md) подсетей мастера.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. Перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Kubernetes**.
     1. Нажмите на имя нужного кластера Kubernetes.
     1. В блоке **Конфигурация мастера** нажмите на имя подсети.
     1. Нажмите кнопку ![subnets](../../_assets/console-icons/pencil.svg) **Редактировать** в правом верхнем углу.
     1. В открывшемся окне раскройте блок **Настройки DHCP**.
     1. Нажмите кнопку **Добавить NTP-сервер** и укажите IP-адрес NTP-сервера.
     1. Нажмите **Сохранить изменения**.

   - CLI {#cli}

     Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

     По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

     1. Посмотрите описание команды CLI для обновления параметров подсети:

         ```bash
         yc vpc subnet update --help
         ```

     1. Выполните команду `subnet` с параметром `--ntp-server`, указав IP-адрес NTP-сервера: 

         ```bash
         yc vpc subnet update <идентификатор_подсети> --ntp-server <адрес_сервера>
         ```

     {% note tip %}
     
     Чтобы узнать идентификаторы подсетей, в которых находится кластер, [получите подробную информацию о кластере](../operations/kubernetes-cluster/kubernetes-cluster-list.md#get).
     
     {% endnote %}

   - Terraform {#tf}

     1. В файле конфигурации Terraform измените описание подсети кластера. Добавьте блок `dhcp_options` (если он отсутствует) с параметром `ntp_servers` и укажите IP-адрес NTP-сервера:

        ```hcl
        ...
        resource "yandex_vpc_subnet" "lab-subnet-a" {
          ...
          v4_cidr_blocks = ["<IPv4-адрес>"]
          network_id     = "<идентификатор_сети>"
          ...
          dhcp_options {
            ntp_servers = ["<IPv4-адрес>"]
            ...
          }
        }
        ...
        ```

        Подробная информация о параметрах ресурса `yandex_vpc_subnet` в Terraform приведена в [документации провайдера](../../terraform/resources/vpc_subnet.md).

     1. Примените изменения:

        1. В терминале перейдите в директорию с конфигурационным файлом.
        1. Проверьте корректность конфигурации с помощью команды:
        
           ```bash
           terraform validate
           ```
        
           Если конфигурация является корректной, появится сообщение:
        
           ```bash
           Success! The configuration is valid.
           ```
        
        1. Выполните команду:
        
           ```bash
           terraform plan
           ```
        
           В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
        1. Примените изменения конфигурации:
        
           ```bash
           terraform apply
           ```
        
        1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
        
        Terraform изменит все требуемые ресурсы. Проверить изменение подсети можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

        ```bash
        yc vpc subnet get <имя_подсети>
        ```
     
   - API {#api}
   
     Воспользуйтесь методом [update](../../vpc/api-ref/Subnet/update.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) и передайте в запросе:

     * IP-адрес NTP-сервера в параметре `dhcpOptions.ntpServers`.
     * Обновляемый параметр `dhcpOptions.ntpServers` в параметре `updateMask`.
     
     {% note tip %}
     
     Чтобы узнать идентификаторы подсетей, в которых находится кластер, [получите подробную информацию о кластере](../operations/kubernetes-cluster/kubernetes-cluster-list.md#get).
     
     {% endnote %}

   {% endlist %}

   {% note warning %}

   Для высокодоступного мастера, который размещается в трех зонах доступности, изменения необходимо внести в каждую из трех подсетей.

   {% endnote %}

1. Разрешите подключение из кластера к NTP-серверам.
   
   [Создайте правило](../../vpc/operations/security-group-add-rule.md) для исходящего трафика в [группе безопасности кластера и групп узлов](../operations/connect/security-groups.md#rules-internal-cluster):

   * **Диапазон портов** — `123`. Если вместо порта `123` вы используете на NTP-сервере другой порт, укажите его.
   * **Протокол** — `UDP`.
   * **Назначение** — `CIDR`.
   * **CIDR блоки** — `<IP-адрес_NTP-сервера>/32`. Для мастера, который размещается в трех зонах доступности, укажите три блока: `<IP-адрес_NTP-сервера_в_подсети1>/32`, `<IP-адрес_NTP-сервера_в_подсети2>/32`, `<IP-адрес_NTP-сервера_в_подсети3>/32`.

1. Обновите сетевые параметры в группе узлов кластера одним из следующих способов:

   * Подключитесь к каждому узлу группы [по SSH](../operations/node-connect-ssh.md) или [через OS Login](../operations/node-connect-oslogin.md) и выполните команду `sudo dhclient -v -r && sudo dhclient`.
   * Перезагрузите узлы группы в удобное для вас время.

   {% note warning %}

   Обновление сетевых параметров может привести к недоступности сервисов внутри кластера на несколько минут.

   {% endnote %}

#### Что делать, если я удалил сетевой балансировщик нагрузки или целевые группы Yandex Network Load Balancer, автоматически созданные для сервиса типа LoadBalancer? {#deleted-loadbalancer-service}

Восстановить сетевой балансировщик или целевые группы Network Load Balancer вручную нельзя. [Пересоздайте](../operations/create-load-balancer.md#lb-create) сервис типа `LoadBalancer` — балансировщик и целевые группы будут созданы автоматически.

#### Ошибка при подключении виртуальной машины Yandex Compute Cloud в качестве внешнего узла Managed Service for Kubernetes {#vm-as-external-node}

Текст ошибки:

```text
Unable to create remote dir /home/kubernetes/bin/: ssh run `mkdir -p -m 0644 /home/kubernetes/bin/': Process exited with status 142
Please login as the user "NONE" rather than the user "root".
```

Чтобы устранить проблему, [пересоздайте](../../compute/operations/index.md#vm-create) виртуальную машину, указав в метаданных для ключа `user-data` параметр `disable_root: false`.

{% cut "Пример метаданных" %}

```yaml
#cloud-config
datasource:
 Ec2:
  strict_id: false
disable_root: false
users:
- name: <имя_пользователя>
  sudo: ALL=(ALL) NOPASSWD:ALL
  shell: /bin/bash
  ssh_authorized_keys:
  - ssh-rsa <публичный_ключ_доступа_к_ВМ>
```

{% endcut %}