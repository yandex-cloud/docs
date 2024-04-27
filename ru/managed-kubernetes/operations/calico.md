---
title: "Как настроить контроллер сетевых политик Calico в {{ managed-k8s-full-name }}"
description: "Следуя данной инструкции, вы сможете настроить контроллер сетевых политик Calico." 
---

# Настройка контроллера сетевых политик Calico

[Calico](https://www.projectcalico.org/) — это плагин для {{ k8s }} с открытым исходным кодом, с помощью которого можно управлять сетевыми политиками {{ k8s }}. Calico расширяет стандартные возможности [сетевых политик](../concepts/network-policy.md) {{ k8s }}, что позволяет:
* Применять политики к любому объекту: [поду](../concepts/index.md#pod), контейнеру, [виртуальной машине](../../compute/concepts/vm.md) или интерфейсу.
* Указывать в правилах политики конкретное действие: запретить, разрешить, логировать.
* Указывать в качестве цели или источника: порт, диапазон портов, протоколы, HTTP- и ICMP-атрибуты, [IP-адрес](../../vpc/concepts/address.md) или [подсеть](../../vpc/concepts/network.md#subnet) и другие объекты.
* Регулировать прохождение трафика с помощью настроек DNAT и политик проброса трафика.

Чтобы настроить контроллер сетевых политик Calico:
1. [{#T}](#create-pod).
1. [{#T}](#enable-isolation).
1. [{#T}](#create-policy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. Создайте инфраструктуру:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. [Создайте облачную сеть](../../vpc/operations/network-create.md) и [подсеть](../../vpc/operations/subnet-create.md).
     1. [Создайте кластер {{ managed-k8s-name }}](kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](node-group/node-group-create.md) любой подходящей конфигурации. При создании [кластера {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster) задействуйте контроллер сетевых политик Calico:
        * В консоли управления, выбрав опцию **{{ ui-key.yacloud.k8s.clusters.create.field_network-policy }}**.
        * С помощью CLI, указав флаг `--enable-network-policy`.
        * С помощью метода [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster).
     1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

   - {{ TF }} {#tf}

     1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

     1. Скачайте в ту же рабочую директорию файл конфигурации [кластера {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster) [k8s-calico.tf](https://github.com/yandex-cloud-examples/yc-mk8s-calico/blob/main/k8s-calico.tf). В файле описаны:
        * [Сеть](../../vpc/operations/network-create.md).
        * Подсеть.
        * Кластер {{ managed-k8s-name }}.
        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера {{ managed-k8s-name }} и [группы узлов](../concepts/index.md#node-group).
        * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. Укажите в файле конфигурации:
        * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
        * [Версию {{ k8s }}](../concepts/release-channels-and-updates.md) для кластера {{ managed-k8s-name }} и групп узлов.
        * CIDR кластера {{ managed-k8s-name }}.
        * Имя сервисного аккаунта кластера {{ managed-k8s-name }}.
     1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
     1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Создайте пространство имен](kubernetes-cluster/kubernetes-cluster-namespace-create.md) `policy-test` в кластере {{ managed-k8s-name }}.

## Создайте сервис nginx {#create-pod}

1. Создайте под с веб-сервером nginx в [пространстве имен](../concepts/index.md#namespace) `policy-test`. Используйте объект API {{ k8s }} [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/):

   ```bash
   kubectl create deployment --namespace=policy-test nginx --image=nginx
   ```

   Результат:

   ```text
   deployment.apps/nginx created
   ```

1. Запустите под с nginx как сервис {{ k8s }}:

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
networkpolicy.networking.k8s.io/default-deny created
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
     ingress:
       - from:
         - podSelector:
             matchLabels:
               run: access
   EOF
   ```

   {% note info %}

   Сетевые политики разрешат трафик от подов с [{{ k8s }}-меткой](../concepts/index.md#node-labels) `run: access` к подам с {{ k8s }}-меткой `app: nginx`. Метки автоматически добавляются утилитой kubectl и основаны на имени ресурса.

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

В созданных сетевых политиках `access-nginx` разрешено подключаться подам с {{ k8s }}-меткой `run: access`.
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

  1. [Удалите кластер {{ managed-k8s-name }}](kubernetes-cluster/kubernetes-cluster-delete.md).
  1. Если вы зарезервировали для кластера {{ managed-k8s-name }} публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

  1. В командной строке перейдите в директорию, в которой расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  1. Удалите конфигурационный файл `k8s-calico.tf`.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     Все ресурсы, которые были описаны в конфигурационном файле `k8s-calico.tf`, будут удалены.

{% endlist %}
