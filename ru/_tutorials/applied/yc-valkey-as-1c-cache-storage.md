# Использование кластера {{ mrd-name }} в качестве хранилища кеша для «1С-Битрикс: Управление сайтом»

Кластер {{ mrd-name }} можно использовать как внешнее хранилище кеша для сайта на «1С-Битрикс: Управление сайтом».

Чтобы настроить кеширование:

1. [Подготовьте инфраструктуру](#deploy-infrastructure).
1. [Настройте «1С-Битрикс: Управление сайтом»](#configure-bitrix).
1. [Проверьте результат](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы ([тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Кластер {{ mrd-name }}: вычислительные ресурсы, объем хранилища и резервных копий ([тарифы {{ mrd-name }}](../../managed-valkey/pricing.md)).

Для этого руководства используется пробная версия «1С-Битрикс» с ознакомительным периодом в 30 дней. Стоимость электронных версий продукта можно уточнить на официальном сайте [«1С-Битрикс»](https://www.1c-bitrix.ru).


## Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group="instructions" %}

- Вручную {#manual}

    1. [Создайте сеть](../../vpc/operations/network-create.md) с именем `network-1c`. При создании сети отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
    1. В сети `network-1c` [создайте подсеть](../../vpc/operations/subnet-create.md) со следующими параметрами:

        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.0.0/24`.

    1. Аналогично создайте в сети `network-1c` еще одну подсеть, например `subnet-b`, в зоне доступности `{{ region-id }}-b` с адресом `192.168.1.0/24`. Она понадобится для хостов кластера {{ mrd-name }}: два хоста кластера нельзя разместить в одной зоне доступности.

    1. В сети `network-1c` [создайте группы безопасности](../../vpc/operations/security-group-create.md):

        1. С именем `bitrix-sg` для ВМ в облаке. [Задайте следующие правила](../../vpc/operations/security-group-add-rule.md) для этой группы безопасности:

            | Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
            |------------------------|----------------------------------------------------------------------------------|---------------------------------------------------------------------------------|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
            | Исходящий              | `ANY`                                                                            | `Весь`                                                                          | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`            | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}`                                                                                    | `0.0.0.0/0`                                                                      |
            | Входящий               | `HTTP`                                                                           | `80`                                                                            | `{{ ui-key.yacloud.common.label_tcp }}`                                       | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}`                                                                                    | `0.0.0.0/0`                                                                      |
            | Входящий               | `EXT-HTTPS`                                                                      | `443`                                                                           | `{{ ui-key.yacloud.common.label_tcp }}`                                       | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}`                                                                                    | `0.0.0.0/0`                                                                      |
            | Входящий               | `SSH`                                                                            | `22`                                                                            | `{{ ui-key.yacloud.common.label_tcp }}`                                       | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}`                                                                                    | `0.0.0.0/0`                                                                      |

        1. С именем `valkey-sg` для кластера {{ mrd-name }}. [Задайте следующие правила](../../vpc/operations/security-group-add-rule.md) для этой группы безопасности:

            | Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
            |------------------------|----------------------------------------------------------------------------------|---------------------------------------------------------------------------------|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
            | Исходящий              | `ANY`                                                                            | `Весь`                                                                          | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`            | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}`                                                                                    | `0.0.0.0/0`                                                                      |
            | Входящий               | `EXT-HTTPS`                                                                      | `6379`                                                                          | `{{ ui-key.yacloud.common.label_tcp }}`                                       | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}`                                                                                    | `0.0.0.0/0`                                                                      |

    1. [Создайте виртуальную машину](../../compute/operations/images-with-pre-installed-software/create.md) в {{ compute-name }} со следующей конфигурацией:

        * В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите образ [1С-Битрикс](/marketplace/products/yc/bitrix-1c-centos-7).
        * В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** задайте настройки:

            * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** — сеть `network-1c` и подсеть `subnet-a`.
            * **{{ ui-key.yacloud.component.compute.network-select.field_external }}** — `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
            * **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** — `bitrix-sg`.
            * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** — `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

    1. [Подключитесь к ВМ](../../compute/operations/images-with-pre-installed-software/operate.md#vm-connect) по SSH и установите PHP-расширения для работы с {{ RD }}:

        ```bash
        sudo yum install -y php-pecl-redis6 php-pecl-igbinary && \
        php -v && php -m | grep -E 'redis|igbinary'
        ```

        Образ «1С-Битрикс» уже содержит PHP (версии 8.1 или выше) со всеми необходимыми расширениями и подключенными репозиториями, поэтому дополнительно устанавливать PHP не требуется. Расширение `php-pecl-redis6` необходимо для подключения к кластеру {{ mrd-name }}, а `php-pecl-igbinary` — для сериализации данных кеша.

    1. Установите «1С-Битрикс: Управление сайтом» на ВМ. Для этого в браузере перейдите по адресу `http://<публичный_IP-адрес_ВМ>/` и следуйте инструкциям установщика.

    1. Создайте тестовый сайт на «1С-Битрикс».

    1. [Создайте кластер](../../managed-valkey/operations/cluster-create.md) {{ mrd-name }} в следующей конфигурации:

        * **{{ ui-key.yacloud.mdb.forms.base_field_version }}** — `9.1`.
        * **{{ ui-key.yacloud.mdb.forms.section_host }}** — не менее двух хостов, чтобы в кластере работала [репликация](../../managed-valkey/concepts/replication.md).
        * **{{ ui-key.yacloud.redis.field_persistence-mode }}** — `{{ ui-key.yacloud.redis.persistence-mode-on-replicas }}`.
        * **{{ ui-key.yacloud.mdb.forms.section_network }}** — сеть `network-1c` и группа безопасности `valkey-sg`.
        * **{{ ui-key.yacloud.mdb.forms.section_settings }}**:
            * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — пароль пользователя с именем `default`. Пароль должен содержать не менее восьми символов.
            * **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** → **Maxmemory policy** — `ALLKEYS LRU`. Эта настройка позволит {{ VLK }} удалять самые старые ключи при заполнении памяти.
        * **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** — включен.


- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
  1. Скачайте в ту же рабочую директорию файл конфигурации [yc-valkey-as-1c-cache-storage.tf](https://github.com/yandex-cloud-examples/yc-valkey-as-1c-cache-storage/blob/main/yc-valkey-as-1c-cache-storage.tf).

      В этом файле описаны:

      * сеть;
      * подсети;
      * группы безопасности;
      * кластер {{ mrd-name }};
      * виртуальная машина с публичным доступом из интернета и предустановленным «1С-Битрикс: Управление сайтом»;
      * настройки для «1С-Битрикс: Управление сайтом».

          {% note info %}

          Конкретные настройки «1С-Битрикс» могут отличаться в зависимости от пользовательской реализации. Примеры конфигурации кеша приведены в [документации продукта](https://dev.1c-bitrix.ru/).

          {% endnote %}

  1. В файле `yc-valkey-as-1c-cache-storage.tf` укажите значение переменной `valkey_password` — пароль пользователя в кластере {{ mrd-name }}.

  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

  После создания ресурсов в терминале будут выведены параметры для подключения:

  * `valkey_endpoint` — эндпоинт для подключения к кластеру {{ mrd-name }}.
  * `bitrix_vm_public_ip` — публичный IP-адрес виртуальной машины с «1С-Битрикс: Управление сайтом».


{% endlist %}

## Настройте «1С-Битрикс» {#configure-bitrix}

{% list tabs group="instructions" %}

- Вручную {#manual}

  1. [Подключитесь к ВМ](../../compute/operations/images-with-pre-installed-software/operate.md#vm-connect) с «1С-Битрикс» по SSH.

  1. Перейдите в каталог сайта и создайте файл дополнительных настроек `bitrix/.settings_extra.php` (по умолчанию он отсутствует на ВМ).

  1. Укажите, что для кеширования используется {{ RD }}, и задайте адрес кластера {{ mrd-name }} и пароль пользователя:

      ```php
      <?php
      return [
          'cache' => [
              'value' => [
                  'type' => [
                      'class_name' => '\Bitrix\Main\Data\CacheEngineRedis',
                  ],
                  'redis' => [
                      'servers' => [
                          [
                              'host' => 'c-<идентификатор_кластера>.rw.mdb.yandexcloud.net',
                              'port' => 6379,
                          ],
                      ],
                      'auth' => '<пароль_пользователя_default>',
                      'serializer' => \Redis::SERIALIZER_IGBINARY ?? null,
                  ],
              ],
              'readonly' => true,
          ],
      ];
      ```

      Идентификатор кластера можно получить со [списком кластеров](../../managed-valkey/operations/cluster-list.md#list-clusters) в каталоге.

      {% note info %}

      Конкретные настройки «1С-Битрикс» могут отличаться в зависимости от пользовательской реализации. Примеры конфигурации кеша приведены в [документации продукта](https://dev.1c-bitrix.ru/).

      {% endnote %}


- {{ TF }} {#tf}

  Настройка «1С-Битрикс: Управление сайтом» происходит при создании ВМ. Дополнительная настройка не требуется.


{% endlist %}

## Проверьте результат {#test}

1. Авторизуйтесь на вашем сайте и перейдите в панель управления.
1. Откройте **Настройки** → **Настройки производительности** → **Панель производительности**.
1. На вкладке **Битрикс** проверьте, что кеширование включено и в качестве хранилища используется {{ RD }}.
1. Убедитесь, что данные действительно попадают в кластер:

    1. В [консоли управления]({{ link-console-main }}) выберите каталог с нужным кластером.
    1. [Перейдите]({{ link-console-main }}/link/managed-valkey) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![chevron-down](../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** → **{{ ui-key.yacloud.redis.cluster.switch_monitoring }}**. На открывшейся странице будут отображены графики, отражающие состояние кластера.
    1. Убедитесь, что появились клиенты, растет объем хранимых данных и трафик, а на репликах есть активность записи на диск из-за включенной персистентности.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group="instructions" %}

- Вручную {#manual}

    1. [Удалите кластер {{ mrd-full-name }}](../../managed-valkey/operations/cluster-delete.md).
    1. [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    1. Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).


- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}


{% endlist %}
