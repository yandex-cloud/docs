{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать приватное соединение.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}** и выберите нужный виртуальный сегмент сети.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}** нажмите кнопку **{{ ui-key.yacloud.baremetal.action_add-vrf-interconnect }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud.baremetal.label_vrf-interconnect-select-type }}** выберите вариант `{{ ui-key.yacloud.baremetal.field_interconnect-direct-id }}` и в поле **{{ ui-key.yacloud.baremetal.label_vrf-interconnect-direct-type }}** вставьте идентификатор приватного соединения `Routing Instance`.

          Вы также можете выбрать вариант `{{ ui-key.yacloud.baremetal.field_interconnect-from-folder }}`. В этом случае в появившемся списке выберите нужный `Routing Instance`.

          В результате в форме отобразятся CIDR подсетей {{ vpc-name }}, которые будут [анонсироваться](../../interconnect/concepts/priv-con.md#prc-announce) в {{ interconnect-name }}.

          {% include [no-subnet-overlapping-warn](../../_tutorials/_tutorials_includes/bm-vrf-and-vpc-interconnect/no-subnet-overlapping-warn.md) %}
      1. Чтобы создать приватное соединение с указанными CIDR подсетей, нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

В результате на странице с информацией о VRF в блоке **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}** отобразится идентификатор созданного соединения и его статус.

{% note info %}

Создание приватного соединения может занять до двух рабочих дней — в это время соединение будет находиться в статусе `Creating`. После создания статус соединения изменится на `Ready`.

{% endnote %}

Приватное соединение c облачными сетями может находиться в одном из следующих статусов:

* `CREATING` — соединение создается.
* `READY` — соединение сконфигурировано и готово к работе.
* `ERROR` — возникла проблема с приватным соединением, для устранения необходимо обратиться в поддержку.
* `DELETING` — соединение удаляется.
* `UPDATING` — настройки приватного соединения обновляются.