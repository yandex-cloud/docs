# Подключение {{ TF }}-провайдера {{ k8s }}

Вы можете создать ресурсы {{ k8s }} с помощью манифестов {{ TF }}. Для этого подключите {{ TF }}-провайдер `kubernetes`. Он поддерживает {{ TF }}-ресурсы, которые соответствуют конфигурационным файлам YAML для различных {{ k8s }}-ресурсов.

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs).

## Перед началом работы {#before-you-begin}

Чтобы подключить провайдер `kubernetes`, [создайте](kubernetes-cluster/kubernetes-cluster-create.md) кластер {{ k8s }} с помощью {{ TF }}.

{% note warning %}

После создания кластера не удаляйте конфигурационные файлы {{ TF }} — они понадобятся для подключения провайдера.

{% endnote %}

Провайдер `kubernetes` инициализируется только после создания и настройки кластера {{ k8s }}, так как:

* Провайдеру нужны данные кластера.
* Провайдер служит для создания ресурсов {{ k8s }}. Их можно создать только когда готов кластер.

## Подключение провайдера {#configure-provider}

1. Перейдите в рабочую директорию с файлами {{ TF }}.

1. Откройте файл `.tf` с настройками провайдера `yandex`, который вы использовали при создании кластера {{ k8s }}. У него должна быть следующая структура:

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
          host                   = yandex_kubernetes_cluster.<имя_кластера_{{ k8s }}>.master[0].external_v4_endpoint
          cluster_ca_certificate = yandex_kubernetes_cluster.<имя_кластера_{{ k8s }}>.master[0].cluster_ca_certificate
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
      host                   = yandex_kubernetes_cluster.<имя_кластера_{{ k8s }}>.master[0].external_v4_endpoint
      cluster_ca_certificate = yandex_kubernetes_cluster.<имя_кластера_{{ k8s }}>.master[0].cluster_ca_certificate
      token                  = data.yandex_client_config.client.iam_token
    }
    ```

1. Инициализируйте провайдер `kubernetes`:

   ```bash
   terraform init
   ```

## См. также {see-also}

Руководство [Управление ресурсами {{ k8s }} с помощью провайдера {{ TF }}](../../managed-kubernetes/tutorials/kubernetes-terraform-provider.md).