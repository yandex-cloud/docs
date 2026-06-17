# Интеграция Yandex Managed Service for Kubernetes с корпоративной зоной DNS

# Интеграция с корпоративной зоной DNS


Чтобы интегрировать [кластер Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) с приватной корпоративной [зоной](../../dns/concepts/dns-zone.md) [DNS](../../glossary/dns.md):

1. [Настройте DNS-сервер](#setup-dns).
1. [Укажите корпоративную зону DNS](#setup-zone).
1. [Создайте под dns-utils](#create-pod).
1. [Проверьте интеграцию DNS](#verify-dns).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик ([тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за каждую ВМ (узлы кластера, DNS-сервер, ВМ для управления кластером Managed Service for Kubernetes без публичного доступа): использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичные IP-адреса для ВМ ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Плата за DNS-зону и DNS-запросы ([тарифы Cloud DNS](../../dns/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Создайте ресурсы Managed Service for Kubernetes:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

     1. [Создайте кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) Managed Service for Kubernetes. При создании укажите группы безопасности, подготовленные ранее.
        
        Если вы планируете работать с кластером в пределах сети Yandex Cloud, выделять кластеру публичный IP-адрес не нужно. Для подключений извне предоставьте кластеру публичный адрес.

     1. [Создайте группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). Выделите ей публичный адрес, чтобы предоставить доступ в интернет и возможность скачивать Docker-образы и компоненты. Укажите группы безопасности, подготовленные ранее.

   - Terraform {#tf}

     1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
     1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
     1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
     1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

     1. Скачайте в ту же рабочую директорию файл конфигурации кластера Managed Service for Kubernetes [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf). В файле описаны:
        * [Сеть](../../vpc/concepts/network.md#network).
        * [Подсеть](../../vpc/concepts/network.md#subnet).
        * Кластер Managed Service for Kubernetes.
        * Группа узлов Managed Service for Kubernetes.
        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для создания кластера и группы узлов Managed Service for Kubernetes.
        * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

            {% note warning %}
            
            От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
            
            {% endnote %}

     1. Укажите в файле конфигурации [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
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

   {% endlist %}

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

   Если для кластера не предоставлен публичный адрес и `kubectl` настроен через внутренний адрес кластера, выполняйте команды `kubectl` на ВМ Yandex Cloud, находящейся в одной сети с кластером.

## Настройте DNS-сервер {#setup-dns}

При настройке важно, чтобы была IP-связность между узлами кластера Managed Service for Kubernetes и DNS-серверами. Сами DNS-серверы могут находиться как в [Yandex Virtual Private Cloud](../../vpc/index.md), так и быть доступными через [VPN](../../glossary/vpn.md) или [Yandex Cloud Interconnect](../../interconnect/index.md). Далее рассматривается случай, когда DNS-сервер имеет адрес `10.129.0.3`, имя `ns.example.com` и обслуживает зону `example.com`.

## Укажите корпоративную зону DNS {#setup-zone}

1. Подготовьте файл `custom-zone.yaml` со следующим содержимым:

   ```yaml
   kind: ConfigMap
   apiVersion: v1
   metadata:
     name: coredns-user
     namespace: kube-system
     labels:
       addonmanager.kubernetes.io/mode: EnsureExists
   data:
     Corefile: |
       # User can put their additional configurations here, for example:
       example.com {
         errors
         cache 30
         forward . 10.129.0.3
       }
   ```

1. Выполните команду:

   ```bash
   kubectl replace -f custom-zone.yaml
   ```

   Результат:

   ```text
   configmap/coredns-user replaced
   ```

## Создайте под dns-utils {#create-pod}

1. Создайте [под](../../managed-kubernetes/concepts/index.md#pod):

   ```bash
   kubectl run jessie-dnsutils \
     --image=registry.k8s.io/jessie-dnsutils \
     --restart=Never \
     --command sleep infinity
   ```

   Результат:

   ```text
   pod/jessie-dnsutils created
   ```

1. Просмотрите информацию о созданном поде:

   ```bash
   kubectl describe pod jessie-dnsutils
   ```

    Результат:

   ```text
   ...
   Status:  Running
   ...
   ```

## Проверьте интеграцию DNS {#verify-dns}

Выполните команду `nslookup` в запущенном контейнере:

```bash
kubectl exec jessie-dnsutils -- nslookup ns.example.com
```

Результат:

```text
Server:   10.96.128.2
Address:  10.96.128.2#53
Name:     ns.example.com
Address:  10.129.0.3
```

{% note info %}

Если корпоративная зона DNS недоступна, [убедитесь](../../managed-kubernetes/operations/connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../vpc/operations/security-group-add-rule.md). Правила должны разрешать доступ к ресурсам, к которым вы обращаетесь из кластера.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
1. Удалите кластер Managed Service for Kubernetes:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     [Удалите кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).

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

1. [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md) с DNS-сервером.
1. [Удалите зону DNS](../../dns/operations/zone-delete.md).