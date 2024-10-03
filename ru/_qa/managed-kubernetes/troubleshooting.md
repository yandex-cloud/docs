# Решение проблем в {{ managed-k8s-name }}

В этом разделе описаны типичные проблемы, которые могут возникать при работе {{ managed-k8s-name }}, и методы их решения.

#### Ошибка при создании кластера в облачной сети другого каталога {#neighbour-catalog-permission-denied}

Текст ошибки:

```text
Permission denied
```

Ошибка возникает из-за отсутствия у [сервисного аккаунта для ресурсов](../../managed-kubernetes/security/index.md#sa-annotation) необходимых [ролей](../../iam/concepts/access-control/roles.md) в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), [облачная сеть](../../vpc/concepts/network.md#network) которого выбирается при создании.

Чтобы создать [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) в облачной сети другого каталога, [назначьте](../../iam/operations/sa/assign-role-for-sa.md) [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) для ресурсов следующие роли в этом каталоге:
* [{{ roles-vpc-private-admin }}](../../vpc/security/index.md#vpc-private-admin)
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user)

Для использования [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) дополнительно [назначьте](../../iam/operations/sa/assign-role-for-sa.md) роль [{{ roles-vpc-public-admin }}](../../vpc/security/index.md#vpc-public-admin).

#### Пространство имен удалено, но все еще находится в статусе Terminating и не удаляется {#namespace-terminating}

Такое случается, когда в [пространстве имен](../../managed-kubernetes/concepts/index.md#namespace) остаются зависшие ресурсы, которые контроллер пространства не может удалить.

Чтобы устранить проблему, вручную удалите зависшие ресурсы.

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. [Подключитесь к кластеру {{ managed-k8s-name }}](../../managed-kubernetes/operations/connect/index.md).
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
  1. Включите проксирование API {{ k8s }} на ваш локальный компьютер:

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

    Не рекомендуется сразу удалять пространство имен в статусе `Terminating` с помощью `finalizer`, так как при этом зависшие ресурсы могут остаться в кластере {{ managed-k8s-name }}.

{% endlist %}

#### Использую {{ network-load-balancer-full-name }} вместе с Ingress-контроллером, почему некоторые узлы моего кластера находятся в состоянии UNHEALTHY? {#nlb-ingress}

Это нормальное поведение [балансировщика нагрузки](../../network-load-balancer/concepts/index.md) при политике `External Traffic Policy: Local`. Статус `HEALTHY` получают только те [узлы {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#node-group), [поды](../../managed-kubernetes/concepts/index.md#pod) которых готовы принимать пользовательский трафик. Оставшиеся узлы помечаются как `UNHEALTHY`.

Чтобы узнать тип политики балансировщика, созданного с помощью сервиса типа `LoadBalancer`, выполните команду:

```bash
kubectl describe svc <имя_сервиса_типа_LoadBalancer> \
| grep 'External Traffic Policy'
```

Подробнее в разделе [Параметры сервиса типа LoadBalancer](../../managed-kubernetes/operations/create-load-balancer.md#advanced).

#### Почему созданный PersistentVolumeClaim остается в статусе Pending? {#pvc-pending}

Это нормальное поведение [PersistentVolumeClaim](../../managed-kubernetes/concepts/volume.md#persistent-volume). Созданный PVC находится в статусе **Pending**, пока не будет создан под, который должен его использовать.

Чтобы перевести PVC в статус **Running**:
1. Просмотрите информацию о PVC:

   ```bash
   kubectl describe pvc <имя_PVC> \
     --namespace=<пространство_имен,_в_котором_находится_PVC>
   ```

   Сообщение `waiting for first consumer to be created before binding` означает, что PVC ожидает создания пода.
1. [Создайте под](../../managed-kubernetes/operations/volumes/dynamic-create-pv.md#create-pod) для этого PVC.

#### Почему кластер {{ managed-k8s-name }} не запускается после изменения конфигурации его узлов? {#not-starting}

Проверьте, что новая конфигурация узлов {{ managed-k8s-name }} не превышает [квоты](../../managed-kubernetes/concepts/limits.md):

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы провести диагностику узлов кластера {{ managed-k8s-name }}:
  1. [Подключитесь к кластеру {{ managed-k8s-name }}](../../managed-kubernetes/operations/connect/index.md).
  1. Проверьте состояние узлов {{ managed-k8s-name }}:

     ```bash
     yc managed-kubernetes cluster list-nodes <идентификатор_кластера>
     ```

     Сообщение о том, что ресурсы кластера {{ managed-k8s-name }} исчерпаны, отображается в первом столбце вывода команды. Пример:

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

Чтобы кластер {{ managed-k8s-name }} запустился, [увеличьте квоты](../../managed-kubernetes/concepts/limits.md).

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

Кластер {{ managed-k8s-name }} может не выполнять разрешение имен внутренних и внешних DNS-запросов по нескольким причинам. Чтобы устранить проблему:
1. [Проверьте версию кластера {{ managed-k8s-name }} и групп узлов](#check-version).
1. [Убедитесь, что CoreDNS работает](#check-coredns).
1. [Убедитесь, что кластеру {{ managed-k8s-name }} достаточно ресурсов CPU](#check-cpu).
1. [Настройте автоматическое масштабирование](#dns-autoscaler).
1. [Настройте локальное кеширование DNS](#node-local-dns).

##### Проверьте версию кластера и групп узлов {#check-version}

1. Получите список актуальных версий {{ k8s }}:

   ```bash
   yc managed-kubernetes list-versions
   ```

1. Узнайте версию кластера {{ managed-k8s-name }}:

   ```bash
   yc managed-kubernetes cluster get <имя_или_идентификатор_кластера> | grep version:
   ```

   Идентификатор и имя кластера {{ managed-k8s-name }} можно получить со [списком кластеров в каталоге](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md#list).
1. Узнайте версию группы узлов {{ managed-k8s-name }}:

   ```bash
   yc managed-kubernetes node-group get <имя_или_идентификатор_группы_узлов> | grep version:
   ```

   Идентификатор и имя группы узлов {{ managed-k8s-name }} можно получить со [списком групп узлов в кластере](../../managed-kubernetes/operations/node-group/node-group-list.md#list).
1. Если версии кластера {{ managed-k8s-name }} или групп узлов не входят в список актуальных версий {{ k8s }}, [обновите их](../../managed-kubernetes/operations/update-kubernetes.md).

##### Убедитесь, что CoreDNS работает {#check-coredns}

Получите список подов CoreDNS и их состояние:

```bash
kubectl get pods -n kube-system -l k8s-app=kube-dns -o wide
```

Все поды должны находится в состоянии `Running`.

##### Убедитесь, что кластеру достаточно ресурсов CPU {#check-cpu}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
1. Перейдите во вкладку **{{ ui-key.yacloud.k8s.nodes.label_nodes }}** и нажмите на имя любого узла {{ managed-k8s-name }}.
1. Перейдите во вкладку **{{ ui-key.yacloud.k8s.node.overview.label_monitoring }}**.
1. Убедитесь, что на графике **CPU, [cores]** значения используемой мощности CPU `used` не достигают значений доступной мощности CPU `total`. Проверьте это для всех узлов кластера {{ managed-k8s-name }}.

##### Настройте автоматическое масштабирование {#dns-autoscaler}

Настройте [автоматическое масштабирование DNS по размеру кластера {{ managed-k8s-name }}](../../managed-kubernetes/tutorials/dns-autoscaler.md).

##### Настройте локальное кеширование DNS {#node-local-dns}

[Настройте NodeLocal DNS Cache](../../managed-kubernetes/tutorials/node-local-dns.md). Чтобы применить оптимальные настройки, [установите NodeLocal DNS Cache из {{ marketplace-full-name }}](../../managed-kubernetes/operations/applications/node-local-dns.md#marketplace-install).

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

Передавайте в команде только один из трех параметров. Расположение группы узлов {{ managed-k8s-name }} достаточно указать в `--location` либо `--network-interface`.

{% include [assign-public-ip-addresses](../../_includes/managed-kubernetes/assign-public-ip-addresses.md) %}

#### Ошибка при подключении к кластеру с помощью `kubectl` {#connect-to-cluster}

Текст ошибки:

```text
ERROR: cluster has empty endpoint
```

Ошибка возникает, если [подключаться к кластеру](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) без публичного IP-адреса, а учетные данные для `kubectl` получить для публичного IP-адреса с помощью команды:

```bash
{{ yc-k8s }} cluster \
   get-credentials <имя_или_идентификатор_кластера> \
   --external
```

Для подключения к внутреннему IP-адресу кластера с ВМ, находящейся в той же сети, получите учетные данные для `kubectl` с помощью команды:

```bash
{{ yc-k8s }} cluster \
   get-credentials <имя_или_идентификатор_кластера> \
   --internal
```

Если вам нужно подключиться к кластеру из интернета, [пересоздайте кластер и предоставьте](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) ему публичный IP-адрес.

#### Ошибки при подключении к узлу по SSH {#node-connect}

Тексты ошибок:

```text
Permission denied (publickey,password)
```

```text
Too many authentication failures
```

Ошибки возникают [при подключении к узлу {{ managed-k8s-name }}](../../managed-kubernetes/operations/node-connect-ssh.md) в следующих ситуациях:
* Публичный [SSH-ключ](../../glossary/ssh-keygen.md) не добавлен в метаданные группы узлов {{ managed-k8s-name }}.

  **Решение**: [обновите ключи группы узлов {{ managed-k8s-name }}](../../managed-kubernetes/operations/node-connect-ssh.md#node-add-metadata).
* Публичный SSH-ключ добавлен в метаданные группы узлов {{ managed-k8s-name }}, но неправильно.

  **Решение**: [приведите файл с публичными ключами к необходимому формату](../../managed-kubernetes/operations/node-connect-ssh.md#key-format) и [обновите ключи группы узлов {{ managed-k8s-name }}](../../managed-kubernetes/operations/node-connect-ssh.md#node-add-metadata).
* Приватный SSH-ключ не добавлен в аутентификационный агент (ssh-agent).

  **Решение**: добавьте приватный ключ с помощью команды `ssh-add <путь_к_файлу_приватного_ключа>`.

#### Как выдать доступ в интернет узлам кластера {{ managed-k8s-name }}? {#internet}

Если узлам кластера {{ managed-k8s-name }} не выдан доступ в интернет, при попытке подключения к интернету возникнет ошибка:

```text
Failed to pull image "{{ registry }}/***": rpc error: code = Unknown desc = Error response from daemon: Gethttps://{{ registry }}/v2/: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```

Есть несколько способов выдать доступ в интернет узлам кластера {{ managed-k8s-name }}:
* Создайте и настройте [NAT-шлюз](../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../vpc/tutorials/nat-instance/index.md). В результате с помощью [статической маршрутизации](../../vpc/concepts/routing.md) трафик будет направлен через шлюз или отдельную [виртуальную машину](../../compute/concepts/vm.md) с функциями NAT.
* [Назначьте публичный IP-адрес группе узлов {{ managed-k8s-name }}](../../managed-kubernetes/operations/node-group/node-group-update.md#update-settings).

{% note info %}

Если вы назначили публичные IP-адреса узлам кластера и затем настроили NAT-шлюз или NAT-инстанс, доступ в интернет через публичные адреса пропадет. Подробнее см. в [документации сервиса {{ vpc-full-name }}](../../vpc/concepts/routing.md#internet-routes).

{% endnote %}

#### Почему я не могу выбрать Docker в качестве среды запуска контейнеров? {#docker-runtime}

Среда запуска контейнеров Docker не поддерживается в кластерах с версией {{ k8s }} 1.24 и выше. Доступна только среда [containerd](https://containerd.io/).
