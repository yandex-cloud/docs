---
title: "Как интегрировать кластер {{ managed-k8s-full-name }} с приватной корпоративной зоной DNS"
description: "Следуя данному руководству, вы сможете интегрировать кластер {{ managed-k8s-full-name }} с приватной корпоративной зоной DNS." 
---

# Интеграция с корпоративной зоной DNS

Чтобы интегрировать [кластер {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster) с приватной корпоративной [зоной](../../dns/concepts/dns-zone.md) [DNS](../../glossary/dns.md):
1. [{#T}](#setup-zone).
1. [{#T}](#create-pod).
1. [{#T}](#verify-dns).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

В примерах этого сценария DNS-сервер имеет адрес `10.129.0.3`, имя `ns.example.com` и обслуживает зону `example.com`. Ваши DNS-серверы могут находиться в [{{ vpc-full-name }}](../../vpc/) или быть доступны через [VPN](../../glossary/vpn.md) или [{{ interconnect-full-name }}](../../interconnect/index.yaml). Необходимое условие — IP-связность между [узлами](../concepts/index.md#node-group) кластера {{ managed-k8s-name }} и DNS-серверами.
1. Создайте ресурсы {{ managed-k8s-name }}:

   {% list tabs %}

   - Вручную

     1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}

     1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

     1. [Настройте группы безопасности кластера и группы узлов {{ managed-k8s-name }}](../operations/connect/security-groups.md). [Группа безопасности](../../vpc/concepts/security-groups.md) кластера {{ managed-k8s-name }} должна разрешать входящие подключения к портам `443` и `6443`.

   - С помощью {{ TF }}

     1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

     1. Скачайте в ту же рабочую директорию файл конфигурации кластера {{ managed-k8s-name }} [k8s-cluster.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster.tf). В файле описаны:
        * [Сеть](../../vpc/concepts/network.md#network).
        * [Подсеть](../../vpc/concepts/network.md#subnet).
        * [Группа безопасности](../../vpc/concepts/security-groups.md) по умолчанию и [правила](../operations/connect/security-groups.md), необходимые для работы кластера {{ managed-k8s-name }}:
          * Правила для служебного трафика.
          * Правила для доступа к API {{ k8s }} и управления кластером {{ managed-k8s-name }} с помощью `kubectl` (через порты 443 и 6443).
        * Кластер {{ managed-k8s-name }}.
        * Группа узлов {{ managed-k8s-name }}.
        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для создания кластера и группы узлов {{ managed-k8s-name }}.
     1. Укажите в файле конфигурации [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
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

## Настройте DNS-сервер {#setup-dns}

При настройке важно, чтобы была IP-связность между узлами кластера {{ managed-k8s-name }} и DNS-серверами. Сами DNS-серверы могут находиться как в {{ vpc-name }}, так и быть доступными через VPN или {{ interconnect-name }}. Далее рассматривается случай, когда DNS-сервер имеет адрес `10.129.0.3`, имя `ns.example.com` и обслуживает зону `example.com`.

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

1. Создайте [под](../concepts/index.md#pod):

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

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
1. Удалите кластер {{ managed-k8s-name }}:

   {% list tabs %}

   - Вручную

     [Удалите кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

   - С помощью {{ TF }}

     1. В командной строке перейдите в директорию, в которой расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
     1. Удалите ресурсы с помощью команды:

        ```bash
        terraform destroy
        ```

        {% note alert %}

        {{ TF }} удалит все ресурсы, которые были созданы с его помощью: кластеры {{ managed-k8s-name }}, сети, подсети, [виртуальные машины](../../compute/concepts/vm.md) и т. д.

        {% endnote %}

     1. Подтвердите удаление ресурсов.

    {% endlist %}

1. [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md) с DNS-сервером.
1. [Удалите зону DNS](../../dns/operations/zone-delete.md).