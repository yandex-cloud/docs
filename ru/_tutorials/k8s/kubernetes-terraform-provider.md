# Управление ресурсами {{ k8s }} в кластере {{ managed-k8s-full-name }} с помощью провайдера {{ TF }}

Вы можете создать ресурсы {{ k8s }} с помощью манифестов {{ TF }}. Для этого подключите {{ TF }}-провайдер `kubernetes`. Он поддерживает {{ TF }}-ресурсы, которые соответствуют конфигурационным файлам YAML для различных {{ k8s }}-ресурсов.

Использовать {{ TF }} для создания {{ k8s }}-ресурсов удобно, если через {{ TF }} вы поддерживаете инфраструктуру для [кластера {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). Так вы можете описывать все ресурсы на одном языке разметки.

Кроме того, {{ TF }} отслеживает зависимости между ресурсами и предотвращает создание, изменение или удаление ресурса, если для него не готовы зависимости. Допустим, вы создаете ресурс `PersistentVolumeClaim`. Ему нужно определенное пространство в хранилище для ресурса `PersistentVolume`, но места не хватает. {{ TF }} отследит нехватку места и не позволит создать ресурс `PersistentVolumeClaim`.

Ниже рассматривается пример, как создать стандартные ресурсы {{ k8s }} с помощью {{ TF }}.

Чтобы с помощью {{ TF }} создать ресурсы {{ k8s }}:

1. [Подготовьте инфраструктуру](#prepare-kubernetes-infrastructure).
1. [Подключите провайдер](#apply-kubernetes-provider) `kubernetes`.
1. [Создайте ресурсы {{ k8s }}](#create-standard-resources).
1. [Убедитесь, что приложение кластера доступно из интернета](#verify-setup).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ managed-k8s-name }}: использование мастера и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за сетевой балансировщик нагрузки (см. [тарифы {{ network-load-balancer-name }}](../../network-load-balancer/pricing.md)).
* Плата за использование публичных IP-адресов для ВМ и сетевого балансировщика нагрузки (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).


## Подготовьте инфраструктуру для {{ managed-k8s-name }} {#prepare-kubernetes-infrastructure}

1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}

   На этом шаге файл не должен содержать настройки провайдера `kubernetes`. Они будут добавлены [позднее](#apply-kubernetes-provider).

1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
1. Скачайте в ту же рабочую директорию файл конфигурации [managed-k8s-infrastructure.tf](https://github.com/yandex-cloud-examples/yc-mk8s-terraform-provider-for-k8s/blob/main/terraform-manifests/managed-k8s-infrastructure.tf).

   В этом файле описаны:

   * сеть;
   * подсеть;
   * две группы безопасности — для кластера и группы узлов;
   * облачный сервисный аккаунт с ролями `k8s.clusters.agent`, `vpc.publicAdmin`, `load-balancer.admin` и `container-registry.images.puller`;
   * кластер {{ managed-k8s-name }};
   * группа узлов {{ k8s }}.

1. Укажите значения переменных в файле `managed-k8s-infrastructure.tf`.
1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

   ```bash
   terraform validate
   ```

   Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

1. Создайте инфраструктуру:

   {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Подключите провайдер kubernetes {#apply-kubernetes-provider}

1. В рабочей директории откройте файл с настройками провайдера `yandex`. У него должна быть следующая структура:

    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
      required_version = ">= 0.13"
    }

    provider "yandex" {
      token     = "<IAM-токен>"
      cloud_id  = "<идентификатор_облака>"
      folder_id = "<идентификатор_каталога>"
      zone      = "<зона_доступности_по_умолчанию>"
    }
    ```

1. Укажите в файле параметры, необходимые для работы провайдера `kubernetes`:

    1. В блок `required_providers` добавьте:

        ```hcl
        kubernetes = {
          source = "hashicorp/kubernetes"
        }
        ```

    1. В блоке `required_providers` измените значение `required_version` на `">= 0.14.8"`.

    1. В конце файла разместите новый блок:

        ```hcl
        data "yandex_client_config" "client" {}

        provider "kubernetes" {
          host                   = yandex_kubernetes_cluster.k8s-cluster.master[0].external_v4_endpoint
          cluster_ca_certificate = yandex_kubernetes_cluster.k8s-cluster.master[0].cluster_ca_certificate
          token                  = data.yandex_client_config.client.iam_token
        }
        ```

1. Убедитесь, что в результате файл выглядит так:

    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
        kubernetes = {
          source = "hashicorp/kubernetes"
        }
      }
      required_version = ">= 0.14.8"
    }

    provider "yandex" {
      token     = "<IAM-токен>"
      cloud_id  = "<идентификатор_облака>"
      folder_id = "<идентификатор_каталога>"
      zone      = "<зона_доступности_по_умолчанию>"
    }

    data "yandex_client_config" "client" {}

    provider "kubernetes" {
      host                   = yandex_kubernetes_cluster.k8s-cluster.master[0].external_v4_endpoint
      cluster_ca_certificate = yandex_kubernetes_cluster.k8s-cluster.master[0].cluster_ca_certificate
      token                  = data.yandex_client_config.client.iam_token
    }
    ```

1. Инициализируйте провайдер `kubernetes`:

    ```bash
    terraform init
    ```

## Создайте ресурсы {{ k8s }} {#create-standard-resources}

Создайте тестовое приложение и сервис типа `LoadBalancer`:

1. В рабочей директории создайте файл `deployment.tf`, описывающий ресурс `Deployment`:

    ```hcl
    resource "kubernetes_deployment" "demo-app-deployment" {
      metadata {
        name = "hello"
        labels = {
          app = "hello"
          version = "v1"
        }
      }
      spec {
        replicas = 2
        selector {
          match_labels = {
            app = "hello"
          }
        }
        template {
          metadata {
            labels = {
              app = "hello"
              version = "v1"
            }
          }
          spec {
            container {
              name  = "hello-app"
              image = "{{ registry }}/crpjd37scfv653nl11i9/hello:1.1"
            }
          }
        }
      }
    }
    ```

1. В рабочей директории создайте файл `service.tf`, описывающий ресурс `Service`:

    ```hcl
    resource "kubernetes_service" "demo-lb-service" {
      metadata {
        name = "hello"
      }
      spec {
        selector = {
          app = kubernetes_deployment.demo-app-deployment.spec.0.template.0.metadata[0].labels.app
        }
        type = "LoadBalancer"
        port {
          port = 80
          target_port = 8080
        }
      }
    }
    ```

1. Создайте ресурсы {{ k8s }}:

   {% include [terraform-apply-short](../../_includes/mdb/terraform/apply-short.md) %}

   После команды `terraform apply` может возникнуть ошибка:

   ```text
   Error: Waiting for rollout to finish: 2 replicas wanted; 0 replicas Ready
   │ 
   │   with kubernetes_deployment.demo-app-deployment,
   │   on deployment.tf line 1, in resource "kubernetes_deployment" "demo-app-deployment":
   │   1: resource "kubernetes_deployment" "demo-app-deployment" {
   │ 
   ```

   Она означает, что ресурсы `Deployment` еще не готовы. Проверьте их готовность с помощью команды `kubectl get deployment`, она вернет результат:

   ```text
   NAME         READY   UP-TO-DATE   AVAILABLE   AGE
   hello        0/2     2            0           12m
   ```

   Когда в столбце `READY` будет указано значение `2/2`, выполните команду `terraform apply` снова.

Вы также можете создавать другие стандартные ресурсы {{ k8s }} с помощью манифестов {{ TF }}. В качестве основы используйте конфигурацию YAML для нужного ресурса ([пример для пода](https://kubernetes.io/docs/concepts/workloads/pods/#using-pods)). Из конфигурации заимствуйте структуру и параметры и примените разметку {{ TF }}. Например, параметр `containerPort` в YAML замените на параметр `container_port` в {{ TF }}. Полный список {{ TF }}-ресурсов для {{ k8s }} приведен в [документации провайдера](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs).

О создании [пользовательских ресурсов](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) с помощью {{ TF }} читайте в [документации {{ TF }}](https://developer.hashicorp.com/terraform/tutorials/kubernetes/kubernetes-provider?variants=kubernetes%3Akind#managing-custom-resources).

## Убедитесь, что приложение кластера доступно из интернета {#verify-setup}

1. Посмотрите информацию о созданном балансировщике нагрузки:

     ```bash
     kubectl describe service hello
     ```

     Результат:

     ```bash
      Name:                     hello
      Namespace:                default
      Labels:                   <none>
      Annotations:              <none>
      Selector:                 app=hello
      Type:                     LoadBalancer
      IP Family Policy:         SingleStack
      IP Families:              IPv4
      IP:                       10.96.228.81
      IPs:                      10.96.228.81
      LoadBalancer Ingress:     84.201.148.8
      Port:                     <unset>  80/TCP
      TargetPort:               8080/TCP
      NodePort:                 <unset>  32532/TCP
      Endpoints:                10.112.128.7:8080,10.112.128.8:8080
      Session Affinity:         None
      External Traffic Policy:  Cluster
      Internal Traffic Policy:  Cluster
      Events:
        Type    Reason                Age    From                Message
        ----    ------                ----   ----                -------
        Normal  EnsuringLoadBalancer  5m32s  service-controller  Ensuring load balancer
        Normal  EnsuredLoadBalancer   5m25s  service-controller  Ensured load balancer
     ```

1. Скопируйте IP-адрес из поля `LoadBalancer Ingress`.  

1. Откройте в браузере URL приложения:

    ```http
    http://<скопированный_IP_адрес>
    ```

    Результат:

    ```text
    Hello, world!
    Running in 'hello-5c46b*****-nc**'
    ```

    {% include [Настройка групп безопасности при недоступности ресурса](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

## Удалите созданные ресурсы {#clear-out}

1. В терминале перейдите в директорию с планом инфраструктуры.

1. Выполните команду:

   ```bash
   terraform destroy
   ```

   {{ TF }} удалит все ресурсы, созданные в текущей конфигурации.

#### См. также {#see-also}

* [Документация {{ TF }} по созданию ресурсов {{ k8s }}](https://developer.hashicorp.com/terraform/tutorials/kubernetes/kubernetes-provider)
* [Документация провайдера](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)
