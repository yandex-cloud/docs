---
title: "Начало работы с управляемым {{ k8s }}"
description: "В этой инструкции вы создайте кластер {{ k8s }} и группу узлов, научитесь управлять ими с помощью kubectl — командной оболочки {{ k8s }}. Для начала создайте кластер {{ k8s }}, добавьте учетные данные в конфигурационный файл kubectl, создайте группу узлов."
---

# Начало работы c {{ managed-k8s-name }}

Создайте [кластер {{ k8s }}](concepts/index.md#kubernetes-cluster) и [группу узлов](concepts/index.md#node-group), и управляйте ими с помощью kubectl — командной оболочки {{ k8s}}.

## Перед началом работы {#before-you-begin}

Чтобы начать работать c сервисом {{ managed-k8s-name }}:
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.


1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).


1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md).
1. Установите [{{ k8s }} CLI (kubectl)]({{ k8s-docs }}/tasks/tools/install-kubectl/).
1. Убедитесь, что у вас достаточно [свободных ресурсов в облаке](concepts/limits.md).
1. Если у вас еще нет сети, [создайте ее](../vpc/operations/network-create.md).
1. Если у вас еще нет подсетей, [создайте их](../vpc/operations/subnet-create.md) в зонах доступности, где будут созданы кластер {{ k8s }} и группа узлов.
1. Создайте [сервисные аккаунты](../iam/operations/sa/create.md):
   * Сервисный аккаунт для ресурсов с ролью [{{ roles-editor }}](../resource-manager/security/index.md#roles-list) на каталог, в котором создается кластер {{ k8s }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
   * Сервисный аккаунт для узлов с ролью [{{ roles-cr-puller }}](../container-registry/security/index.md#required-roles) на каталог с реестром Docker-образов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.

   Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

## Создайте кластер {{ k8s }} {#kubernetes-cluster-create}

{% include [create-cluster](../_includes/managed-kubernetes/cluster-create.md) %}

## Добавьте учетные данные в конфигурационный файл kubectl {#add-conf}

{% list tabs %}

- CLI

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}

  Чтобы добавить учетные данные кластера {{ k8s }} в конфигурационный файл kubectl:
  1. Выполните команду:

     ```bash
     yc managed-kubernetes cluster get-credentials test-k8s-cluster --external
     ```

     * По умолчанию учетные данные добавляются в директорию `$HOME/.kube/config`.
     * Если необходимо изменить расположение конфигураций, используйте флаг `--kubeconfig <путь к файлу>`.
  1. Проверьте конфигурацию kubectl после добавления учетных данных:

     ```bash
     kubectl config view
     ```

     Результат выполнения:

     ```
     apiVersion: v1
     clusters:
       - cluster:
         certificate-authority-data: DATA+OMITTED
     ...
     ```

{% endlist %}

## Создайте группу узлов {#node-group-create}

{% include [create-node-group](../_includes/managed-kubernetes/node-group-create.md) %}

## Что дальше {#what-is-next}

* Ознакомьтесь с [концепциями сервиса](concepts/index.md).
* Узнайте, как [работать с кластером {{ k8s }} и группами узлов](operations/index.md).