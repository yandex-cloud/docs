---
title: Обеспечение доступа к приложению, запущенному в кластере {{ k8s }}
---

# Обеспечение доступа к приложению, запущенному в кластере {{ k8s }}

В примере ниже рассматривается приложение {{ k8s }}, которое отвечает на HTTP-запросы на порт 8080. Для предоставления доступа к приложению используйте публичные или внутренние [сервисы](../concepts/service.md). Их IP-адреса не меняются в отличие от адресов подов и узлов кластера.

Чтобы опубликовать приложение, воспользуйтесь сервисом типа `LoadBalancer`. Вы можете организовать два вида доступа:

* Публичный доступ по IP-адресу с внешним сетевым балансировщиком нагрузки [{{ network-load-balancer-full-name }}](../../network-load-balancer/concepts/index.md).
* Доступ из внутренних сетей по IP-адресу с [внутренним](../../network-load-balancer/concepts/nlb-types.md) сетевым балансировщиком.

  Приложение будет доступно:
  * Из [подсетей](../../vpc/concepts/network.md#subnet) {{ vpc-full-name }}.
  * Из внутренних подсетей организации, подключенных к {{ yandex-cloud }} с помощью сервиса [{{ interconnect-full-name }}](../../interconnect/index.yaml).
  * Через [VPN](../../glossary/vpn.md).

При использовании внешнего балансировщика нагрузки в поле `loadBalancerIP` [можно указать](#advanced) статический [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses). Такой адрес необходимо [зарезервировать заранее](../../vpc/operations/get-static-ip.md). Во время резервирования публичного IP-адреса можно активировать [защиту от DDoS-атак](../../vpc/ddos-protection/index.md). Если не указывать статический публичный IP-адрес, то сетевому балансировщику нагрузки будет назначен динамический публичный IP-адрес.

{% note info %}

В отличие от IP-адреса пода или узла, который может меняться в случае обновления ресурсов группы узлов, статический публичный IP-адрес сервиса типа `LoadBalancer` не изменяется.

{% endnote %}

При использовании внутреннего балансировщика нагрузки можно указать [внутренний IP-адрес](../../vpc/concepts/address.md#internal-addresses). Убедитесь, что указанный внутренний IP-адрес не назначен какому-либо ресурсу в той же облачной сети.

{% note warning %}

Если вы в дальнейшем удалите из спецификации внутренний IP-адрес, он может быть автоматически назначен другому ресурсу в той же облачной сети. Рекомендуем выбирать IP-адрес ближе к концу диапазона IP-адресов выбранной подсети.

{% endnote %}

Чтобы обеспечить доступ к приложению {{ k8s }}:
1. [Подготовьтесь к работе](#before-you-begin)
1. [{#T}](#create-application)
1. [{#T}](#create-lb)
1. [{#T}](#check-result)
1. [{#T}](#network-policy)

{% cut "Как обеспечить доступ к приложению с помощью HTTPS?" %}

См. документацию:

* [{#T}](../tutorials/new-kubernetes-project.md)
* [{#T}](../tutorials/alb-ingress-controller.md)
* [{#T}](../tutorials/ingress-cert-manager.md)
* [Установка Ingress-контроллера NGINX с сертификатом из {{ certificate-manager-full-name }}](../tutorials/nginx-ingress-certificate-manager.md#check-service-availability)

{% endcut %}

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

      1. Создайте [облачную сеть](../../vpc/operations/network-create.md) и [подсеть](../../vpc/operations/subnet-create.md).
      1. Создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с [ролями](../../iam/concepts/access-control/roles.md) `k8s.clusters.agent`, `vpc.publicAdmin` и `load-balancer.admin`. Роль `load-balancer.admin` нужна для создания [сетевого балансировщика нагрузки](../../network-load-balancer/concepts/index.md).
      1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

          {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

      1. [Создайте кластер {{ managed-k8s-name }}](kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](node-group/node-group-create.md) с публичным доступом в интернет и с группами безопасности, подготовленными ранее.

    - {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

      1. Скачайте в ту же рабочую директорию файл конфигурации кластера {{ managed-k8s-name }} [k8s-load-balancer.tf](https://github.com/yandex-cloud-examples/yc-mk8s-load-balancer/blob/main/k8s-load-balancer.tf). В файле описаны:
          * [Сеть](../../vpc/concepts/network.md#network).
          * [Подсеть](../../vpc/concepts/network.md#subnet).
          * Кластер {{ managed-k8s-name }}.
          * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и [группы узлов {{ managed-k8s-name }}](../concepts/index.md#node-group).
          * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

      1. Укажите в файле конфигурации:
          * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
          * [Версию {{ k8s }}](../concepts/release-channels-and-updates.md) для кластера и групп узлов {{ managed-k8s-name }}.
          * Имя сервисного аккаунта кластера {{ managed-k8s-name }}.
      1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

          ```bash
          terraform validate
          ```

          Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Создайте необходимую инфраструктуру:

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

          {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

          {% include [Terraform timeouts](../../_includes/managed-kubernetes/terraform-timeout-both.md) %}

    {% endlist %}

## Создайте приложение {{ k8s }} {#create-application}

1. Создайте файл `hello.yaml` и добавьте в него спецификацию ресурса [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) для создания приложения:

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: hello
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: hello
     template:
       metadata:
         labels:
           app: hello
       spec:
         containers:
         - name: hello-app
           image: {{ registry }}/crpjd37scfv653nl11i9/hello:1.1
   ```

1. Создайте приложение:

   ```bash
   kubectl apply -f hello.yaml
   ```

1. Убедитесь, что приложение создано:

   ```bash
   kubectl get deployment 
   ```

   Результат:

   ```text
   NAME    READY   UP-TO-DATE   AVAILABLE   AGE
   hello   2/2     2            2           17h
   ```

## Создайте сервис типа LoadBalancer {#create-lb}

Когда вы создаете сервис типа `LoadBalancer`, контроллер {{ yandex-cloud }} в вашем каталоге устанавливает сетевой балансировщик нагрузки. Он тарифицируется по установленным в {{ network-load-balancer-name }} [правилам тарификации](../../network-load-balancer/pricing.md).

{% include [note-nlb](../../_includes/managed-kubernetes/note-nlb.md) %}

Чтобы создать сервис типа `LoadBalancer`:

1. Выберите и подготовьте спецификацию сервиса в зависимости от нужного типа балансировщика:

   {% list tabs group=instructions %}

   * Внешний балансировщик {#external-balancer}

      1. Создайте файл `load-balancer.yaml` и добавьте в него следующую спецификацию сервиса:

         ```yaml
         apiVersion: v1
         kind: Service
         metadata:
           name: hello
         spec:
           type: LoadBalancer
           ports:
           - port: <порт_приложения>
             name: plaintext
             targetPort: 8080
           selector:
             <{{ k8s }}-метки>
         ```

         В спецификации укажите:

         * `spec.ports.port` — порт приложения.

            В примере предполагается, что приложение {{ k8s }} доступно по протоколу HTTP, поэтому укажите значение `80`. Если нужен доступ к приложению по HTTPS, укажите значение `443`.

         * `spec.selector` — {{ k8s }}-метки, заданные в поле `spec.selector.matchLabels` ресурса `Deployment`.

            В созданном ранее ресурсе `Deployment` используется метка `app: hello`, поэтому укажите ее.

         Подробнее о спецификации в [справочнике сервиса](../nlb-ref/service.md).

      1. (Опционально) [Зарезервируйте статический публичный IP-адрес](../../vpc/operations/get-static-ip.md) и добавьте его в спецификацию:

         ```yaml
         ...
         spec:
           loadBalancerIP: <статический_IP-адрес>
           ...
         ```

         {% note info %}

         Если не указать статический IP-адрес, сетевому балансировщику нагрузки будет назначен динамический IP-адрес.

         {% endnote %}

   * Внутренний балансировщик {#internal-balancer}

      1. Создайте файл `load-balancer.yaml` и добавьте в него следующую спецификацию сервиса:

         ```yaml
         apiVersion: v1
         kind: Service
         metadata:
           name: hello
           annotations:
             yandex.cloud/load-balancer-type: internal
             yandex.cloud/subnet-id: <идентификатор_подсети_кластера>
         spec:
           type: LoadBalancer
           ports:
           - port: <порт_приложения>
             name: plaintext
             targetPort: 8080
           selector:
             <{{ k8s }}-метки>
         ```

         В спецификации укажите:

         * `yandex.cloud/subnet-id` — идентификатор подсети, в которой расположен кластер. Идентификатор можно [получить вместе с информацией о подсети](../../vpc/operations/subnet-get-info.md).
         * `spec.ports.port` — порт приложения.

            В примере предполагается, что приложение {{ k8s }} доступно по протоколу HTTP, поэтому укажите значение `80`. Если нужен доступ к приложению по HTTPS, укажите значение `443`.

         * `spec.selector` — {{ k8s }}-метки, заданные в поле `spec.selector.matchLabels` ресурса `Deployment`.

            В созданном ранее ресурсе `Deployment` используется метка `app: hello`, поэтому укажите ее.

         Подробнее о спецификации в [справочнике сервиса](../nlb-ref/service.md).

      1. (Опционально) [Зарезервируйте статический внутренний IP-адрес](../../vpc/operations/private-ip-reserve.md) и добавьте его в спецификацию:

         ```yaml
         ...
         spec:
           loadBalancerIP: <статический_IP-адрес>
           ...
         ```

         {% note info %}

         Если не указать статический IP-адрес, сетевому балансировщику нагрузки будет назначен динамический IP-адрес.

         {% endnote %}

   {% endlist %}

1. (Опционально) Добавьте политику управления трафиком:

   ```yaml
   ...
   spec:
     externalTrafficPolicy: <Cluster_или_Local>
     ...
   ```

   Возможные значения:

   {% include [externalTrafficPolicy-description](../../_includes/managed-kubernetes/externalTrafficPolicy.md) %}

1. (Опционально) Подключите [проверки доступности узлов](../../network-load-balancer/concepts/health-check.md) (health checks).

   Сервисы типа `LoadBalancer` в {{ managed-k8s-name }} могут выполнять запросы на проверку состояния [целевой группы](../../network-load-balancer/concepts/target-resources.md). На основе полученных метрик {{ managed-k8s-name }} принимает решение о доступности узлов.

   Чтобы включить проверки доступности узлов, укажите следующие аннотации в спецификации сервиса:

   ```yaml
   ...
   metadata:
     ...
     annotations:
       yandex.cloud/load-balancer-healthcheck-healthy-threshold: "2"
       yandex.cloud/load-balancer-healthcheck-interval: "2s"
   ```

   Используемые аннотации:

   * `yandex.cloud/load-balancer-healthcheck-healthy-threshold` — количество последовательных удачных проверок, при достижении которого узел кластера считается доступным.
   * `yandex.cloud/load-balancer-healthcheck-interval` — интервал выполнения проверок в секундах.

1. Создайте сетевой балансировщик нагрузки:

   ```bash
   kubectl apply -f load-balancer.yaml
   ```

## Проверьте доступность приложения {#check-result}

1. Посмотрите информацию о созданном сетевом балансировщике нагрузки и получите его IP-адрес:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог по умолчанию.
     1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. На вкладке **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_list }}** отображен сетевой балансировщик нагрузки с префиксом `k8s` в имени и уникальным идентификатором вашего кластера {{ k8s }} в описании.

        Скопируйте адрес балансировщика в столбце **{{ ui-key.yacloud.load-balancer.network-load-balancer.column_ip-address }}**.

   - kubectl {#kubectl}

     ```bash
     kubectl describe service hello
     ```

     Результат:

     ```text
     Name:                     hello
     Namespace:                default
     Labels:                   <none>
     Annotations:              <none>
     Selector:                 app=hello
     Type:                     LoadBalancer
     IP:                       172.20.169.7
     LoadBalancer Ingress:     130.193.50.111
     Port:                     plaintext 80/TCP
     TargetPort:               8080/TCP
     NodePort:                 plaintext 32302/TCP
     Endpoints:                10.1.130.4:8080
     Session Affinity:         None
     External Traffic Policy:  Cluster
     Events:
       Type    Reason                Age    From                Message
       ----    ------                ----   ----                -------
       Normal  EnsuringLoadBalancer  2m43s  service-controller  Ensuring load balancer
       Normal  EnsuredLoadBalancer   2m17s  service-controller  Ensured load balancer
     ```

     Скопируйте адрес балансировщика в поле `LoadBalancer Ingress`.

   {% endlist %}

1. Убедитесь, что приложение доступно. Процесс проверки зависит от типа балансировщика:

   {% list tabs group=instructions %}

   * Внешний балансировщик {#external-balancer}

      Выполните команду:

      ```bash
      curl http://<IP-адрес_балансировщика>
      ```

      Результат:

      ```text
      Hello, world!
      Running in 'hello-********'
      ```

   * Внутренний балансировщик {#internal-balancer}

      1. В подсети кластера {{ managed-k8s-name }} [создайте виртуальную машину Linux](../../compute/operations/vm-create/create-linux-vm.md).

         Так как вы развернули внутренний сетевой балансировщик нагрузки, проверить доступ к приложению {{ k8s }} можно только из подсети кластера.

      1. [Подключитесь к ВМ по SSH](../../compute/operations/vm-connect/ssh.md).
      1. Проверьте доступность приложения {{ k8s }}:

         ```bash
         curl http://<IP-адрес_балансировщика>
         ```

         Результат:

         ```text
         Hello, world!
         Running in 'hello-********'
         ```

   {% endlist %}

   {% include [Настройка групп безопасности при недоступности ресурса](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

## (Опционально) Создайте объект NetworkPolicy {#network-policy}

Чтобы подключиться с определенных IP-адресов к сервисам, опубликованным через {{ network-load-balancer-name }}, включите [сетевые политики](../concepts/network-policy.md) в кластере. Для настройки доступа через балансировщик создайте объект [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/#networkpolicy-resource) с политикой типа `Ingress`.

{% cut "Пример настройки объекта NetworkPolicy" %}

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: whitelist-netpol
  namespace: ns-example
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  ingress:
  - from:
    # Диапазоны адресов, используемые балансировщиком для проверки состояния узлов.
    - ipBlock:
        cidr: 198.18.235.0/24
    - ipBlock:
        cidr: 198.18.248.0/24
    # Диапазоны адресов подов.
    - ipBlock:
        cidr: 172.16.1.0/12
    - ipBlock:
        cidr: 172.16.2.0/12
```

{% endcut %}

Подробнее в [справочнике](../nlb-ref/networkpolicy.md) ресурса `NetworkPolicy`.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. Удалите ресурсы в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        [Удалите кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}

1. Если для доступа к кластеру {{ managed-k8s-name }} или узлам использовались статические [публичные](../../vpc/concepts/address.md#public-addresses) IP-адреса, освободите и удалите их.