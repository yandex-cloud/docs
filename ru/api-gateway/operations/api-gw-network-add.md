---
title: Как указать облачную сеть, в которой будет находиться API-шлюз
description: Следуя данной инструкции, вы сможете указать облачную сеть, в которой будет находиться API-шлюз.
---

# Указать облачную сеть, в которой будет находиться API-шлюз

Вы можете указать [облачную сеть](../../vpc/concepts/network.md#network), в которой будет находиться API-шлюз.

{% include [network](../../_includes/functions/network.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится API-шлюз.
    1. [Перейдите]({{ link-console-main }}/link/api-gateway) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз.
    1. Нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
    1. В поле **{{ ui-key.yacloud.vpc.label_network }}** укажите облачную сеть, в которой будет находиться API-шлюз.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения API-шлюза:

     ```bash
     {{ yc-serverless }} api-gateway update --help
     ```

  1. Получите список API-шлюзов в каталоге по умолчанию:

     ```bash
     {{ yc-serverless }} api-gateway list
     ```

  1. Укажите облачную сеть для нужного API-шлюза:

     ```bash
     {{ yc-serverless }} api-gateway update \
       --id <идентификатор_API-шлюза> \
       --network-name <имя_облачной_сети>
     ```

     Где:
     * `--id` — идентификатор API-шлюза.
     * `--network-name` — имя облачной сети. Вместо имени можно указать идентификатор сети в параметре `--network-id`.

     Чтобы ограничить набор подсетей, в которых будет размещен API-шлюз, вместо сети укажите подсети в параметрах `--subnet-id` или `--subnet-name`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `connectivity` в описание ресурса `yandex_api_gateway`:

     ```hcl
     resource "yandex_api_gateway" "test-api-gateway" {
       name = "<имя_API-шлюза>"
       ...
       connectivity {
         network_id = "<идентификатор_облачной_сети>"
       }
     }
     ```

     Где `network_id` — идентификатор облачной сети, в которой будет находиться API-шлюз.

     Более подробную информацию о параметрах ресурса `yandex_api_gateway` читайте в [документации провайдера]({{ tf-provider-resources-link }}/api_gateway).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить результат можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     {{ yc-serverless }} api-gateway get <идентификатор_API-шлюза>
     ```

- API {#api}

  Чтобы указать облачную сеть, в которой будет находиться API-шлюз, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md).

  В параметре `updateMask` укажите `connectivity`, а в параметре `connectivity.networkId` — идентификатор облачной сети.

{% endlist %}

#### Полезные ссылки {#see-also}

[Сетевое взаимодействие в {{ api-gw-name }}](../concepts/networking.md)
