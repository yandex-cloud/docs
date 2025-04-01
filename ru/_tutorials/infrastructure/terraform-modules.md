# Использование модулей {{ yandex-cloud }} в {{ TF }}


{{ yandex-cloud }} предоставляет ![](../../_assets/overview/solution-library-icon.svg)[набор модулей для Terraform](https://github.com/terraform-yc-modules). Модули {{ TF }} объединяют несколько облачных ресурсов, которые должны работать вместе. Благодаря модулям конфигурация облачной инфраструктуры упрощается, блоки легче переиспользовать, а все необходимые для создания ресурсов параметры можно указать в переменных. 

На этой странице рассказано, как подключить модули и использовать их для создания тестовой инфраструктуры: [облачной сети](../../vpc/concepts/network.md#network) с тремя [подсетями](../../vpc/concepts/network.md#subnet) [{{ vpc-full-name }}](../../vpc/) и [кластера {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

Чтобы создать вашу первую инфраструктуру в {{ yandex-cloud }} с помощью {{ TF }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Установите {{ TF }}](#install-terraform).
1. [Получите данные для аутентификации](#get-credentials).
1. [Создайте файл конфигурации {{ TF }}](#configure-terraform).
1. [Настройте провайдер](#configure-provider).

Если ресурсы больше вам не нужны, [удалите их](#delete-resources).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры, разворачиваемой через {{ TF }} в этом руководстве, входят:
* Плата за [высокодоступный мастер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master) (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за постоянно запущенные [виртуальные машины](../../compute/concepts/vm.md) в [группе узлов {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#node-group) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамических [публичных IP-адресов](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md#prices-public-ip)).

## Установите {{ TF }} {#install-terraform}

{% include [terraform_install](../../_tutorials/_tutorials_includes/terraform-install.md) %}

## Получите данные для аутентификации {#get-credentials}

{% include [terraform-credentials-sa](../../_tutorials/_tutorials_includes/terraform-credentials-sa.md) %}

{% cut "Управление ресурсами от имени аккаунта на Яндексе или федеративного аккаунта" %}

{% include [terraform-credentials-user](../../_tutorials/_tutorials_includes/terraform-credentials-user.md) %}

{% endcut %}

## Создайте файл конфигурации {{ TF }} {#configure-terraform}

{% include [terraform-configure](../../_tutorials/_tutorials_includes/terraform-configure.md) %}

## Настройте провайдер {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/_tutorials_includes/terraform-configure-provider.md) %}

## Подключите модуль управления виртуальными сетями {#vpc-module}

Добавьте в конфигурацию модуль `terraform-yc-vpc` — с его помощью можно управлять сетевой инфраструктурой вашего [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud): сетями, подсетями, [шлюзами](../../vpc/concepts/gateways.md) и другими объектами {{ vpc-name }}. Создайте тестовую сеть с тремя подсетями в разных [зонах доступности](../../overview/concepts/geo-scope.md):

```hcl
module "yc-vpc" {
  source              = "github.com/terraform-yc-modules/terraform-yc-vpc.git"
  network_name        = "test-module-network"
  network_description = "Test network created with module"
  private_subnets = [{
    name           = "subnet-1"
    zone           = "{{ region-id }}-a"
    v4_cidr_blocks = ["10.10.0.0/24"]
  },
  {
    name           = "subnet-2"
    zone           = "{{ region-id }}-b"
    v4_cidr_blocks = ["10.11.0.0/24"]
  },
  {
    name           = "subnet-3"
    zone           = "{{ region-id }}-d"
    v4_cidr_blocks = ["10.12.0.0/24"]
  }
  ]
}
```

## Подключите модуль {{ managed-k8s-name }} {#k8s-module}

Добавьте в конфигурацию модуль `terraform-yc-vpc` и конфигурацию кластера {{ managed-k8s-name }} с высокодоступным мастером и двумя группами узлов:

```hcl
module "kube" {
  source     = "github.com/terraform-yc-modules/terraform-yc-kubernetes.git"
  network_id = "${module.yc-vpc.vpc_id}"

  master_locations  = [
    for s in module.yc-vpc.private_subnets:
      {
        zone      = s.zone,
        subnet_id = s.subnet_id
      }
    ]

  master_maintenance_windows = [
    {
      day        = "monday"
      start_time = "23:00"
      duration   = "3h"
    }
  ]

  node_groups = {
    "yc-k8s-ng-01"  = {
      description   = "{{ k8s }} nodes group 01"
      fixed_scale   = {
        size = 3
      }
      node_labels   = {
        role        = "worker-01"
        environment = "testing"
      }
    },

    "yc-k8s-ng-02"  = {
      description   = "{{ k8s }} nodes group 02"
      auto_scale    = {
        min         = 2
        max         = 4
        initial     = 2
      }
      node_labels   = {
        role        = "worker-02"
        environment = "dev"
      }

      max_expansion   = 1
      max_unavailable = 1
    }
  }
}
```

## Проверьте и отформатируйте файлы конфигураций {#check-resources}

{% include [check-resources](../../_tutorials/_tutorials_includes/terraform-check-resources.md) %}

## Создайте ресурсы {#create-resources}

{% include [create-resources](../../_tutorials/_tutorials_includes/terraform-create-resources.md) %}

## Как удалить созданные ресурсы {#delete-resources}

{% include [delete-resources](../../_tutorials/_tutorials_includes/terraform-delete-resources.md) %}

## См. также {#see-also}

* [Начало работы с {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Загрузка состояний {{ TF }} в {{ objstorage-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md).
* [Блокировка состояний {{ TF }} с помощью {{ ydb-name }}](../../tutorials/infrastructure-management/terraform-state-lock.md).
* [Источники данных {{ TF }}](../../tutorials/infrastructure-management/terraform-data-sources.md).