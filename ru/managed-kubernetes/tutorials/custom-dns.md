---
title: Как интегрировать кластер {{ managed-k8s-full-name }} с приватной корпоративной зоной DNS
description: Следуя данному руководству, вы сможете интегрировать кластер {{ managed-k8s-full-name }} с приватной корпоративной зоной DNS.
---

# Интеграция с корпоративной зоной DNS


Чтобы интегрировать [кластер {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster) с приватной корпоративной [зоной](../../dns/concepts/dns-zone.md) [DNS](../../glossary/dns.md):

1. [Настройте DNS-сервер](#setup-dns).
1. [Укажите корпоративную зону DNS](#setup-zone).
1. [Создайте под dns-utils](#create-pod).
1. [Проверьте интеграцию DNS](#verify-dns).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ managed-k8s-name }}: использование мастера и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за каждую ВМ (узлы кластера, DNS-сервер, ВМ для управления кластером {{ managed-k8s-name }} без публичного доступа): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за публичные IP-адреса для ВМ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md#prices-public-ip)).
* Плата за DNS-зону и DNS-запросы (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Создайте ресурсы {{ managed-k8s-name }}:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}

     1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

   - {{ TF }} {#tf}

     1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

     1. Скачайте в ту же рабочую директорию файл конфигурации кластера {{ managed-k8s-name }} [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf). В файле описаны:
        * [Сеть](../../vpc/concepts/network.md#network).
        * [Подсеть](../../vpc/concepts/network.md#subnet).
        * Кластер {{ managed-k8s-name }}.
        * Группа узлов {{ managed-k8s-name }}.
        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для создания кластера и группы узлов {{ managed-k8s-name }}.
        * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

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

   {% include [kubectl info](../../_includes/managed-kubernetes/kubectl-info.md) %}

## Настройте DNS-сервер {#setup-dns}

При настройке важно, чтобы была IP-связность между узлами кластера {{ managed-k8s-name }} и DNS-серверами. Сами DNS-серверы могут находиться как в [{{ vpc-full-name }}](../../vpc/), так и быть доступными через [VPN](../../glossary/vpn.md) или [{{ interconnect-full-name }}](../../interconnect/index.yaml). Далее рассматривается случай, когда DNS-сервер имеет адрес `10.129.0.3`, имя `ns.example.com` и обслуживает зону `example.com`.

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

{% note info %}

Если корпоративная зона DNS недоступна, [убедитесь](../operations/connect/security-groups.md), что группы безопасности для кластера {{ managed-k8s-name }} и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../vpc/operations/security-group-add-rule.md). Правила должны разрешать доступ к ресурсам, к которым вы обращаетесь из кластера.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
1. Удалите кластер {{ managed-k8s-name }}:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     [Удалите кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

   - {{ TF }} {#tf}

     {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}

1. [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md) с DNS-сервером.
1. [Удалите зону DNS](../../dns/operations/zone-delete.md).
