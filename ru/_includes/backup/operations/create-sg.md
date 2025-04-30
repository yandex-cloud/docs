{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно подключить ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. Введите имя [группы безопасности](../../../vpc/concepts/security-groups.md), например `backup-sg`.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите [сеть](../../../vpc/concepts/network.md), в которой находится ВМ.
  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** перейдите на вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** и нажмите **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
  1. Последовательно добавьте следующие правила для исходящего трафика:

      {% include [outgoing traffic](../outgoing-rules.md) %}

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  1. Посмотрите описание команды для создания [группы безопасности](../../../vpc/concepts/security-groups.md):

      ```bash
      yc vpc security-group create --help
      ```

  1. Создайте группу безопасности с [правилами](../../../vpc/concepts/network.md#security-groups-rules), выполнив команду:

      ```bash
      yc vpc security-group create \
        --name <имя_группы_безопасности> \
        --network-id <идентификатор_сети> \
        --rule "direction=egress,port=80,protocol=tcp,v4-cidrs=[213.180.193.0/24]" \
        --rule "direction=egress,port=80,protocol=tcp,v4-cidrs=[213.180.204.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[84.201.181.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[178.176.128.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[213.180.193.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[213.180.204.0/24]" \
        --rule "direction=egress,from-port=7770,to-port=7800,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
        --rule "direction=egress,port=8443,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
        --rule "direction=egress,port=44445,protocol=tcp,v4-cidrs=[51.250.1.0/24]"
      ```

      Где:

      * `name` — имя группы безопасности.
      * `network-id` — идентификатор [сети](../../../vpc/concepts/network.md), в которой находится ВМ.
      * `rule` — описание правила:

          * `direction` — направление трафика. `egress` — исходящий.
          * `port` — порт для получения трафика.
          * `from-port` — первый порт из диапазона портов для трафика.
          * `to-port` — последний порт из диапазона портов для трафика.
          * `protocol` — протокол передачи данных.
          * `v4-cidrs` — список CIDR IPv4 и масок подсетей, куда будет поступать трафик.

      Результат:

      ```bash
      id: enp0v73fe8fs********
      folder_id: b1g86q4m5vej********
      created_at: "2024-07-22T20:17:43Z"
      name: backup-sg
      network_id: enp3srbi9u49********
      status: ACTIVE
      rules:
        - id: enpdadptjl77********
          direction: EGRESS
          ports:
            from_port: "80"
            to_port: "80"
          protocol_name: TCP
          protocol_number: "6"
          cidr_blocks:
            v4_cidr_blocks:
              - 213.180.193.0/24
      ...
        - id: enpji0640a0f********
          direction: EGRESS
          ports:
            from_port: "44445"
            to_port: "44445"
          protocol_name: TCP
          protocol_number: "6"
          cidr_blocks:
            v4_cidr_blocks:
              - 51.250.1.0/24
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_vpc_security_group" "test_sg_outgoing" {
        name        = "<имя_группы_безопасности>"
        network_id  = "<идентификатор_сети>"

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["213.180.193.0/24"]
          port           = 80
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["213.180.204.0/24"]
          port           = 80
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["84.47.172.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["84.201.181.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["178.176.128.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["213.180.193.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["213.180.204.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["84.47.172.0/24"]
          from_port      = 7770
          to_port        = 7800
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["84.47.172.0/24"]
          port           = 8443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["51.250.1.0/24"]
          port           = 44445
        }
      }
      ```

      Где:

      * `name` — имя [группы безопасности](../../../vpc/concepts/security-groups.md).
      * `network_id` — идентификатор [сети](../../../vpc/concepts/network.md), в которой находится ВМ.
      * `egress` — описание [правила](../../../vpc/concepts/network.md#security-groups-rules) для исходящего трафика:

          * `protocol` — протокол передачи данных.
          * `v4-cidrs` — список CIDR IPv4 и масок подсетей, куда будет поступать трафик.
          * `port` — порт для получения трафика.
          * `from_port` — первый порт из диапазона портов для трафика.
          * `to_port` — последний порт из диапазона портов для трафика.

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

    Более подробную информацию о параметрах ресурса `yandex_vpc_security_group` см. в [документации провайдера]({{ tf-provider-datasources-link }}/vpc_security_group).

- API {#api}

  Чтобы создать [группу безопасности](../../../vpc/concepts/security-groups.md), воспользуйтесь методом REST API [create](../../../vpc/api-ref/SecurityGroup/create.md) для ресурса [SecurityGroup](../../../vpc/api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Create](../../../vpc/api-ref/grpc/SecurityGroup/create.md).

{% endlist %}

Подробности см. в разделе [{#T}](../../../vpc/operations/security-group-create.md).