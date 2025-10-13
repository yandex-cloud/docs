---
title: Установка приложений из {{ marketplace-full-name }} с помощью {{ TF }}
description: Следуя данной инструкции, вы подключите {{ TF }}-провайдер Helm и сможете устанавливать приложения из {{ marketplace-name }} с помощью манифестов {{ TF }}.
---

# Установка приложений из {{ marketplace-full-name }} с помощью {{ TF }}

[{{ TF }}-провайдер Helm](https://github.com/hashicorp/terraform-provider-helm) позволяет устанавливать в кластер {{ managed-k8s-full-name }} приложения из [{{ marketplace-name }}](/marketplace) и любые другие helm-чарты с помощью манифестов {{ TF }}.

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://registry.terraform.io/providers/hashicorp/helm/latest/docs).

## Перед началом работы {#before-you-begin}

1. [Создайте](kubernetes-cluster/kubernetes-cluster-create.md) кластер {{ managed-k8s-name }} любым удобным способом.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Подключение провайдера {#configure-provider}

1. В отдельной директории создайте файл `provider.tf` с настройками провайдера Helm:

    ```hcl
    terraform {
      required_providers {
        helm = {
          source  = "hashicorp/helm"
          version = "~> 2.13"
        }
      }
      required_version = ">= 1.4.0"
    }

    provider "helm" {
      kubernetes {
        config_path = "~/.kube/config"
        config_context = "<имя_контекста>"
      }
    }
    ```

    Получить список всех контекстов можно с помощью команды `kubectl config get-contexts`, узнать текущий контекст — с помощью команды `kubectl config current-context`.

1. Инициализируйте провайдер Helm:

   ```bash
   terraform init
   ```

## Установка приложений с помощью {{ TF }} {#install-app}

Для установки приложений используется ресурс {{ TF }} [helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release).

В качестве примера рассматривается установка приложения [{{ GLR }}](/marketplace/products/yc/gitlab-runner).

1. В директории, где находится файл `provider.tf`, создайте файл `gitlab-runner.tf`:

    ```hcl
    resource "helm_release" "gitlab_runner" {
      name             = "gitlab-runner"
      chart            = "oci://{{ registry }}/yc-marketplace/yandex-cloud/gitlab-org/gitlab-runner/chart/gitlab-runner"
      version          = "0.54.0-8"
      namespace        = "gitlab-runner"
      create_namespace = true


      values = [yamlencode({
        gitlabDomain            = "https://***.gitlab.yandexcloud.net"
        runnerRegistrationToken = "<регистрационный_токен>"

        replicas     = 2
        nodeSelector = { nodepool = "runners" }
        resources = {
          requests = { cpu = "200m", memory = "256Mi" }
          limits   = { cpu = "500m", memory = "512Mi" }
        }
      })]
    }
    ```

    Где:

    * `name` — название приложения.
    * `chart` — ссылка на Helm-чарт.
    * `version` — версия приложения.
    * `namespace` — новое пространство имен, в котором будет установлено приложение. Если вы укажете пространство имен по умолчанию, {{ GLR }} может работать некорректно.
    * `values` — параметры из конфигурационного файла `values.yaml` Helm-чарта:

      * `gitlabDomain` — домен инстанса {{ GL }}.
      * `runnerRegistrationToken` — регистрационный токен. [Подробнее о получении токена](applications/gitlab-runner.md#before-you-begin).
      * `replicas` — количество подов приложения.
      * `nodeSelector` — назначение подов узлам с меткой `nodepool = "runners"`.
      * `resources` — минимальное и максимальное количество ресурсов, которые будут выделены приложению.

    Запросить список всех параметров из `values.yaml` можно с помощью команды:

    ```bash
    helm show values <ссылка_на_Helm-чарт> --version <версия_приложения>
    ```

1. Установите приложение:

   {% include [terraform-apply-short](../../_includes/mdb/terraform/apply-short.md) %}

{% note tip %}

Для установки приложений из {{ marketplace-name }} также можно использовать [модуль {{ TF }} от {{ yandex-cloud }}](https://github.com/terraform-yc-modules/terraform-yc-kubernetes-marketplace).

[Подробнее о работе с модулями](../../terraform/concepts/modules.md).

{% endnote %}



