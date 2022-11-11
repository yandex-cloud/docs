# Интеграция с корпоративной зоной DNS

Чтобы настроить резолвинг приватной корпоративной зоны DNS в кластере {{ k8s }} выполните следующие действия:
1. Подготовьте рабочее окружение.

   Для выполнения сценария вам понадобятся сервисный аккаунт, облачная сеть и подсеть. Вы можете использовать существующие ресурсы или создать новые.

   {% cut "Как создать ресурсы" %}

   1. Создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `editor`.
   1. Создайте [облачную сеть](../../vpc/operations/network-create.md).
   1. Создайте в облачной сети [подсеть](../../vpc/operations/subnet-create.md).

   {% endcut %}

1. Настройте сервер DNS.

   В примерах этого сценария DNS-сервер имеет адрес `10.129.0.3`, имя `ns.example.com` и обслуживает зону `example.com`. Ваши DNS-серверы могут находиться в {{ vpc-name }} или быть доступны через VPN или {{ interconnect-name }}. Необходимое условие — IP-связность между узлами кластера {{ k8s }} и DNS-серверами.
1. Создайте кластер {{ k8s }} и группу узлов.

   Вы можете использовать уже работающий кластер и группу узлов {{ k8s }} или создать новые.

   {% cut "Как создать кластер {{ k8s }} и группу узлов" %}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Создайте кластер {{ k8s }}:

   ```bash
   yc managed-kubernetes cluster create \
     --name custom-dns-cluster \
     --service-account-name <имя сервисного аккаунта> \
     --node-service-account-name <имя сервисного аккаунта> \
     --public-ip \
     --zone {{ region-id }}-a \
     --network-name <имя облачной сети>
   ```

   Результат:

   ```text
   done (7m21s)
   ...
   ```

   Создайте группу узлов:

   ```bash
   yc managed-kubernetes node-group create \
     --name custom-dns-group \
     --cluster-name custom-dns-cluster \
     --location zone={{ region-id }}-a \
     --network-interface subnets=<имя подсети для группы узлов>,ipv4-address=nat \
     --fixed-size 1
   ```

   Результат:

   ```text
   done (2m43s)
   ...
   ```

   {% endcut %}

1. [Настройте группы безопасности кластера и группы узлов](../operations/connect/security-groups.md).

1. Настройте kubectl.

   Чтобы запускать команды для кластера {{ k8s }}, установите и настройте консоль управления kubectl.

   {% cut "Как настроить kubectl" %}

   Установите {{ k8s }} CLI [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

   Добавьте учетные данные кластера {{ k8s }} в конфигурационный файл kubectl:

   ```bash
   yc managed-kubernetes cluster get-credentials --external --name custom-dns-cluster
   ```

   Результат:

   ```text
   Context 'yc-custom-dns-cluster' was added as default to kubeconfig '/home/<ваш домашний каталог>/.kube/config'.
   ...
   ```

   {% endcut %}

1. Укажите корпоративную зону DNS:

   Подготовьте файл `custom-zone.yaml` со следующим содержимым:

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

   Выполните команду:

   ```bash
   kubectl replace -f custom-zone.yaml
   ```

   Результат:

   ```text
   configmap/coredns-user replaced
   ```

1. Создайте под:

   ```bash
   kubectl run jessie-dnsutils \
     --image=k8s.gcr.io/jessie-dnsutils \
     --restart=Never \
     --command sleep infinity
   ```

   Результат:

   ```text
   pod/jessie-dnsutils created
   ```

   Просмотрите информацию о созданном поде:

   ```bash
   kubectl describe pod jessie-dnsutils
   ```

   Результат:

   ```text
   ...
   Status:  Running
   ...
   ```

1. Проверьте интеграцию DNS.

   Чтобы проверить доступность вашей DNS-зоны для сервисов кластера {{ k8s }}, выполните команду `nslookup` в запущенном контейнере:

   ```bash
   kubectl exec jessie-dnsutils -- nslookup ns.example.com
   ```

   Результат:

   ```text
   Server:		10.96.128.2
   Address:	10.96.128.2#53

   Name:	ns.example.com
   Address: 10.129.0.3
   ```

1. Удалите созданные ресурсы.

   Чтобы удалить кластер {{ k8s }}, сервисный аккаунт, подсеть и сеть, выполните команды:

   ```bash
   yc managed-kubernetes cluster delete --name custom-dns-cluster
   yc iam service-account delete <имя сервисного аккаунта>
   yc vpc subnet delete <имя облачной подсети>
   yc vpc network delete <имя облачной сети>
   ```