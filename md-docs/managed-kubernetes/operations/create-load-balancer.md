# Обеспечение доступа к приложению, запущенному в кластере Kubernetes

В примере ниже рассматривается приложение Kubernetes, которое отвечает на HTTP-запросы на порт 8080. Для предоставления доступа к приложению используйте публичные или внутренние [сервисы](../concepts/service.md). Их IP-адреса не меняются в отличие от адресов подов и узлов кластера.

Чтобы опубликовать приложение, воспользуйтесь сервисом типа `LoadBalancer`. Вы можете организовать два вида доступа:

* Публичный доступ по IP-адресу с внешним сетевым балансировщиком нагрузки [Yandex Network Load Balancer](../../network-load-balancer/concepts/index.md).
* Доступ из внутренних сетей по IP-адресу с [внутренним](../../network-load-balancer/concepts/nlb-types.md) сетевым балансировщиком.

  Приложение будет доступно:
  * Из [подсетей](../../vpc/concepts/network.md#subnet) Yandex Virtual Private Cloud.
  * Из внутренних подсетей организации, подключенных к Yandex Cloud с помощью сервиса [Yandex Cloud Interconnect](../../interconnect/index.md).
  * Через [VPN](../../glossary/vpn.md).

При использовании внешнего балансировщика нагрузки в поле `loadBalancerIP` [можно указать](#advanced) статический [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses). Такой адрес необходимо [зарезервировать заранее](../../vpc/operations/get-static-ip.md). Во время резервирования публичного IP-адреса можно активировать [защиту от DDoS-атак](../../vpc/ddos-protection/index.md). Если не указывать статический публичный IP-адрес, то сетевому балансировщику нагрузки будет назначен динамический публичный IP-адрес.

{% note info %}

В отличие от IP-адреса пода или узла, который может меняться в случае обновления ресурсов группы узлов, статический публичный IP-адрес сервиса типа `LoadBalancer` не изменяется.

{% endnote %}

При использовании внутреннего балансировщика нагрузки можно указать [внутренний IP-адрес](../../vpc/concepts/address.md#internal-addresses). Убедитесь, что указанный внутренний IP-адрес не назначен какому-либо ресурсу в той же облачной сети.

{% note warning %}

Если вы в дальнейшем удалите из спецификации внутренний IP-адрес, он может быть автоматически назначен другому ресурсу в той же облачной сети. Рекомендуем выбирать IP-адрес ближе к концу диапазона IP-адресов выбранной подсети.

{% endnote %}

Чтобы обеспечить доступ к приложению Kubernetes:
1. [Подготовьтесь к работе](#before-you-begin)
1. [Создайте приложение Kubernetes](#create-application)
1. [Создайте сервис типа LoadBalancer](#create-lb)
1. [Проверьте доступность приложения](#check-result)
1. [(Опционально) Создайте объект NetworkPolicy](#network-policy)

{% cut "Как обеспечить доступ к приложению с помощью HTTPS?" %}

Читайте документацию:

* [Создание нового Kubernetes-проекта в Yandex Cloud](../tutorials/new-kubernetes-project.md)
* [Настройка L7-балансировщика Yandex Application Load Balancer с помощью Ingress-контроллера](../tutorials/alb-ingress-controller.md)

{% endcut %}

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](connect/index.md#kubectl-connect).

1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

      1. Создайте [облачную сеть](../../vpc/operations/network-create.md) и [подсеть](../../vpc/operations/subnet-create.md).
      1. Создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с [ролями](../../iam/concepts/access-control/roles.md) `k8s.clusters.agent`, `vpc.publicAdmin` и `load-balancer.admin`. Роль `load-balancer.admin` нужна для создания [сетевого балансировщика нагрузки](../../network-load-balancer/concepts/index.md).
      1. [Создайте группы безопасности](connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

          {% note warning %}
          
          От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
          
          {% endnote %}

      1. [Создайте кластер Managed Service for Kubernetes](kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](node-group/node-group-create.md) с публичным доступом в интернет и с группами безопасности, подготовленными ранее.

    - Terraform {#tf}

      1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
      1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
      1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

      1. Скачайте в ту же рабочую директорию файл конфигурации кластера Managed Service for Kubernetes [k8s-load-balancer.tf](https://github.com/yandex-cloud-examples/yc-mk8s-load-balancer/blob/main/k8s-load-balancer.tf). В файле описаны:
          * [Сеть](../../vpc/concepts/network.md#network).
          * [Подсеть](../../vpc/concepts/network.md#subnet).
          * Кластер Managed Service for Kubernetes.
          * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и [группы узлов Managed Service for Kubernetes](../concepts/index.md#node-group).
          * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

            {% note warning %}
            
            От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
            
            {% endnote %}

      1. Укажите в файле конфигурации:
          * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
          * [Версию Kubernetes](../concepts/release-channels-and-updates.md) для кластера и групп узлов Managed Service for Kubernetes.
          * Имя сервисного аккаунта кластера Managed Service for Kubernetes.
      1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

          ```bash
          terraform validate
          ```

          Если в файлах конфигурации есть ошибки, Terraform на них укажет.
      1. Создайте необходимую инфраструктуру:

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

          В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

          {% note warning "Ограничения по времени" %}
          
          Провайдер Terraform ограничивает время на выполнение операций с кластером и группой узлов Managed Service for Kubernetes:
          
          * создание и изменение кластера — 30 минут;
          * создание и изменение группы узлов — 60 минут;
          * удаление группы узлов — 20 минут.
          
          Операции, которые длятся дольше указанного времени, прерываются.
          
          {% cut "Как изменить эти ограничения?" %}
          
          Добавьте к описанию кластера и группы узлов блоки `timeouts` (ресурсы `yandex_kubernetes_cluster` и `yandex_kubernetes_node_group` соответственно).
          
          Пример:
          
          ```hcl
          resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
            ...
            timeouts {
              create = "1h30m"
              update = "1h30m"
              delete = "30m"
            }
          }
          ```
          
          {% endcut %}
          
          {% endnote %}

    {% endlist %}

## Создайте приложение Kubernetes {#create-application}

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
           image: cr.yandex/crpjd37scfv653nl11i9/hello:1.1
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

Когда вы создаете сервис типа `LoadBalancer`, контроллер Yandex Cloud в вашем каталоге устанавливает сетевой балансировщик нагрузки. Он тарифицируется по установленным в Network Load Balancer [правилам тарификации](../../network-load-balancer/pricing.md).

{% note warning %}

* Созданный сетевой балансировщик тарифицируется согласно установленным [правилам тарификации](../../network-load-balancer/pricing.md).
* Не изменяйте и не удаляйте сетевой балансировщик и целевые группы, которые будут автоматически созданы в вашем каталоге, через интерфейсы Yandex Cloud (консоль управления, Terraform, CLI и API). Это может привести к некорректной работе кластера.

{% endnote %}

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
             <Kubernetes-метки>
         ```

         В спецификации укажите:

         * `spec.ports.port` — порт приложения.

            В примере предполагается, что приложение Kubernetes доступно по протоколу HTTP, поэтому укажите значение `80`. Если нужен доступ к приложению по HTTPS, укажите значение `443`.

         * `spec.selector` — Kubernetes-метки, заданные в поле `spec.selector.matchLabels` ресурса `Deployment`.

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
             <Kubernetes-метки>
         ```

         В спецификации укажите:

         * `yandex.cloud/subnet-id` — идентификатор подсети, в которой расположен кластер. Идентификатор можно [получить вместе с информацией о подсети](../../vpc/operations/subnet-get-info.md).
         * `spec.ports.port` — порт приложения.

            В примере предполагается, что приложение Kubernetes доступно по протоколу HTTP, поэтому укажите значение `80`. Если нужен доступ к приложению по HTTPS, укажите значение `443`.

         * `spec.selector` — Kubernetes-метки, заданные в поле `spec.selector.matchLabels` ресурса `Deployment`.

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

   * **Cluster** — трафик направляется на разные узлы Kubernetes (значение по умолчанию). В результате трафик распределяется равномерно, но у такого подхода есть недостатки:
   
      * Пакет может прийти на прокси одного узла и без необходимости перенаправиться на другой узел. Такое поведение вызвает задержки во время выполнения операций и отправки пакетов.
      * Под, который получает пакет, видит IP-адрес проксирующего узла, а не клиента. В результате исходный IP-адрес клиента не сохраняется.
   
   * **Local** — трафик проксируется и распределяется между подами на одном и том же узле. Трафик направляется на узел через порт, указанный в сервисе [типа LoadBalancer или NodePort](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types).
   
      Так как трафик приходит на конкретный узел, он распределяется между узлами неравномерно. Зато IP-адрес клиента сохраняется.
   
   Подробнее о политиках управления внешним трафиком читайте в [документации Kubernetes](https://kubernetes.io/docs/reference/networking/virtual-ips/#external-traffic-policy).

1. (Опционально) Подключите [проверки доступности узлов](../../network-load-balancer/concepts/health-check.md) (health checks).

   Сервисы типа `LoadBalancer` в Managed Service for Kubernetes могут выполнять запросы на проверку состояния [целевой группы](../../network-load-balancer/concepts/target-resources.md). На основе полученных метрик Managed Service for Kubernetes принимает решение о доступности узлов.

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

     1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог по умолчанию.
     1. Перейдите в сервис **Network Load Balancer**.
     1. На вкладке **Балансировщики** отображен сетевой балансировщик нагрузки с префиксом `k8s` в имени и уникальным идентификатором вашего кластера Kubernetes в описании.

        Скопируйте адрес балансировщика в столбце **IP-адрес**.

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

      1. В подсети кластера Managed Service for Kubernetes [создайте виртуальную машину Linux](../../compute/operations/vm-create/create-linux-vm.md).

         Так как вы развернули внутренний сетевой балансировщик нагрузки, проверить доступ к приложению Kubernetes можно только из подсети кластера.

      1. [Подключитесь к ВМ по SSH](../../compute/operations/vm-connect/ssh.md).
      1. Проверьте доступность приложения Kubernetes:

         ```bash
         curl http://<IP-адрес_балансировщика>
         ```

         Результат:

         ```text
         Hello, world!
         Running in 'hello-********'
         ```

   {% endlist %}

   {% note info %}
   
   Если ресурс недоступен по указанному URL, то [убедитесь](connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../vpc/operations/security-group-add-rule.md).
   
   {% endnote %}

## (Опционально) Создайте объект NetworkPolicy {#network-policy}

Чтобы подключиться с определенных IP-адресов к сервисам, опубликованным через Network Load Balancer, включите [сетевые политики](../concepts/network-policy.md) в кластере. Для настройки доступа через балансировщик создайте объект [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/#networkpolicy-resource) с политикой типа `Ingress`.

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

        [Удалите кластер Managed Service for Kubernetes](kubernetes-cluster/kubernetes-cluster-delete.md).

    - Terraform {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        
            {% note warning %}
        
            Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
        
            {% endnote %}
        
        1. Удалите ресурсы:
        
            1. Выполните команду:
        
                ```bash
                terraform destroy
                ```
        
            1. Подтвердите удаление ресурсов и дождитесь завершения операции.
        
            Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

    {% endlist %}

1. Если для доступа к кластеру Managed Service for Kubernetes или узлам использовались статические [публичные](../../vpc/concepts/address.md#public-addresses) IP-адреса, освободите и удалите их.