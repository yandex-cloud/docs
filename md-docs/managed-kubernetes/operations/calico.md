[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Kubernetes](../index.md) > [Пошаговые инструкции](index.md) > Сетевые сценарии > Настройка контроллера сетевых политик Calico

# Настройка контроллера сетевых политик Calico

[Calico](https://www.projectcalico.org/) — это плагин для Kubernetes с открытым исходным кодом, с помощью которого можно управлять сетевыми политиками Kubernetes. Calico расширяет стандартные возможности [сетевых политик](../concepts/network-policy.md) Kubernetes, что позволяет:
* Применять политики к любому объекту: [поду](../concepts/index.md#pod), контейнеру, [виртуальной машине](../../compute/concepts/vm.md) или интерфейсу.
* Указывать в правилах политики конкретное действие: запретить, разрешить, логировать.
* Указывать в качестве цели или источника: порт, диапазон портов, протоколы, HTTP- и ICMP-атрибуты, [IP-адрес](../../vpc/concepts/address.md) или [подсеть](../../vpc/concepts/network.md#subnet) и другие объекты.
* Регулировать прохождение трафика с помощью настроек DNAT и политик проброса трафика.

Чтобы настроить контроллер сетевых политик Calico:
1. [Создайте сервис nginx](#create-pod).
1. [Изолируйте поды с помощью сетевых политик](#enable-isolation).
1. [Создайте сетевые политики, разрешающие доступ к сервису](#create-policy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. Создайте инфраструктуру:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. [Создайте облачную сеть](../../vpc/operations/network-create.md) и [подсеть](../../vpc/operations/subnet-create.md).

         {% note warning %}
         
         Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
         
         {% endnote %}

     1. [Создайте группы безопасности](connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

     1. [Создайте кластер Managed Service for Kubernetes](kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](node-group/node-group-create.md) любой подходящей конфигурации. При создании укажите сеть, подсеть и группы безопасности, подготовленные заранее. Также в кластере задействуйте контроллер сетевых политик Calico:
        * В консоли управления, выбрав опцию **Сalico CNI**.
        * С помощью CLI, указав флаг `--enable-network-policy`.
        * С помощью метода [create](../managed-kubernetes/api-ref/Cluster/create.md) для ресурса [Cluster](../managed-kubernetes/api-ref/Cluster/index.md).

   - Terraform {#tf}

     1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
     1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
     1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

     1. Скачайте в ту же рабочую директорию файл конфигурации [кластера Managed Service for Kubernetes](../concepts/index.md#kubernetes-cluster) [k8s-calico.tf](https://github.com/yandex-cloud-examples/yc-mk8s-calico/blob/main/k8s-calico.tf). В файле описаны:
        * [Сеть](../../vpc/operations/network-create.md) и подсеть.

            {% note warning %}
            
            Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
            
            {% endnote %}

        * Кластер Managed Service for Kubernetes.
        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера Managed Service for Kubernetes и [группы узлов](../concepts/index.md#node-group).
        * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

            {% note warning %}
            
            От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
            
            {% endnote %}

     1. Укажите в файле конфигурации:
        * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
        * [Версию Kubernetes](../concepts/release-channels-and-updates.md) для кластера Managed Service for Kubernetes и групп узлов.
        * CIDR кластера Managed Service for Kubernetes.
        * Имя сервисного аккаунта кластера Managed Service for Kubernetes.
     1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
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

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](connect/index.md#kubectl-connect).

1. [Создайте пространство имен](kubernetes-cluster/kubernetes-cluster-namespace-create.md) `policy-test` в кластере Managed Service for Kubernetes.

## Создайте сервис nginx {#create-pod}

1. Создайте под с веб-сервером nginx в [пространстве имен](../concepts/index.md#namespace) `policy-test`. Используйте объект API Kubernetes [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/):

   ```bash
   kubectl create deployment --namespace=policy-test nginx --image=nginx
   ```

   Результат:

   ```text
   deployment.apps/nginx created
   ```

1. Запустите под с nginx как сервис Kubernetes:

   ```bash
   kubectl expose --namespace=policy-test deployment nginx --port=80
   ```

   Результат:

   ```text
   service/nginx exposed
   ```

1. Убедитесь, что веб-сервер nginx доступен. Для этого создайте под `access`:

   ```bash
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   На поде `access` откроется shell-сессия:

   ```text
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Подключитесь к веб-серверу nginx через сессию на поде `access`:

   ```bash
   wget -q nginx -O -
   ```

   Веб-сервер nginx доступен:

   ```html
   <!DOCTYPE html>
   <html>
   <head>
   ...
   <p><em>Thank you for using nginx.</em></p>
   </body>
   </html>
   ```

1. Выйдите из пода:

   ```bash
   / # exit
   ```

   Под удален:

   ```text
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

## Изолируйте поды с помощью сетевых политик {#enable-isolation}

Изолируйте пространство имен `policy-test`. После этого контроллер сетевых политик Calico предотвратит подключения к подам в этом пространстве имен:

```yaml
kubectl create -f - <<EOF
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: deny
  namespace: policy-test
spec:
  podSelector:
    matchLabels: {}
EOF
```

Сетевые политики созданы:

```text
networkpolicy.networking.k8s.io/deny created
```

### Протестируйте изоляцию {#test-isolation}

1. Сетевые политики изолировали веб-сервер nginx. Чтобы это проверить, создайте под `access`:

   ```bash
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   На поде `access` откроется shell-сессия:

   ```text
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Проверьте, есть ли у пода `access` доступ к веб-серверу nginx:

   ```bash
   wget -q --timeout=5 nginx -O -
   ```

   Соединение не установлено:

   ```text
   wget: download timed out
   / #
   ```

1. Выйдите из пода:

   ```bash
   / # exit
   ```

   Под удален:

   ```text
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

## Создайте сетевые политики, разрешающие доступ к сервису {#create-policy}

Разрешите доступ к веб-серверу nginx с помощью сетевых политик. Сетевые политики разрешат подключаться только поду `access`.
1. Создайте сетевые политики `access-nginx`:

   ```yaml
   kubectl create -f - <<EOF
   kind: NetworkPolicy
   apiVersion: networking.k8s.io/v1
   metadata:
     name: access-nginx
     namespace: policy-test
   spec:
     podSelector:
       matchLabels:
         app: nginx
     policyTypes:
     - Ingress
     - Egress
     ingress:
       - from:
         - podSelector:
             matchLabels:
               run: access
     egress:
       - to:
         - podSelector:
             matchLabels:
               app: nginx
   EOF
   ```

   {% note info %}

   Сетевые политики разрешат трафик от подов с [Kubernetes-меткой](../concepts/index.md#node-labels) `run: access` к подам с Kubernetes-меткой `app: nginx`. Метки автоматически добавляются утилитой kubectl и основаны на имени ресурса.

   {% endnote %}

   Сетевые политики созданы:

   ```text
   networkpolicy.networking.k8s.io/access-nginx created
   ```

1. Создайте под `access`:

   ```bash
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   На поде `access` откроется shell-сессия:

   ```text
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Проверьте, есть ли у пода `access` доступ к веб-серверу nginx:

   ```bash
   wget -q --timeout=5 nginx -O -
   ```

   Соединение установлено:

   ```html
   <!DOCTYPE html>
   <html>
   <head>
   <title>Welcome to nginx!</title>
   ...
   ```

1. Выйдите из пода:

   ```bash
   / # exit
   ```

   Под удален:

   ```text
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

### Проверьте, что сетевая изоляция для других подов работает {#check-isolation}

В созданных сетевых политиках `access-nginx` разрешено подключаться подам с Kubernetes-меткой `run: access`.
1. Создайте под без метки `run: access`:

   ```bash
   kubectl run --namespace=policy-test cant-access --rm -ti --image busybox /bin/sh
   ```

   На поде `cant-access` откроется shell-сессия:

   ```text
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Проверьте, есть ли у пода `cant-access` доступ к веб-серверу nginx:

   ```bash
   wget -q --timeout=5 nginx -O -
   ```

   Соединение не установлено:

   ```bash
   wget: download timed out
   / #
   ```

1. Выйдите из пода:

   ```bash
   / # exit
   ```

   Под удален:

   ```text
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "cant-access" deleted
   ```

1. Чтобы удалить данные примера, удалите пространство имен:

   ```bash
   kubectl delete ns policy-test
   ```

   Результат выполнения команды:

   ```text
   namespace "policy-test" deleted
   ```

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер Managed Service for Kubernetes](kubernetes-cluster/kubernetes-cluster-delete.md).
  1. Если вы зарезервировали для кластера Managed Service for Kubernetes публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).

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