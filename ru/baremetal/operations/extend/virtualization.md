---
title: Подключить {{ baremetal-extend-virtualization-name }}
description: Следуя этой инструкции, вы сможете отправить заявку на подключение {{ baremetal-extend-virtualization-name }}.
---

# Подключить {{ baremetal-extend-virtualization-name }}

{{ baremetal-extend-virtualization-name }} позволяет арендовать кластер серверов {{ baremetal-name }} с предустановленной платформой виртуализации. Решение предоставляется в партнерстве с K2 Cloud. Чтобы согласовать аппаратную конфигурацию, хранилище, сетевую схему и условия предоставления, отправьте заявку.

Перед отправкой заявки определите:

* требуемое количество ядер vCPU и объем оперативной памяти;
* требуемый объем хранилища;
* предполагаемое количество и характеристики виртуальных машин;
* требования к сетевой связности и публичному доступу;
* контактные данные технического специалиста.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите разместить кластер.
  1. [Перейдите]({{ link-console-main }}/link/baremetal/extend) в раздел **{{ ui-key.yacloud.baremetal.label_extend }}** сервиса **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}** и выберите **{{ ui-key.yacloud.baremetal.label_extend-virtualization }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.extend.VirtualizationListPage.leaveRequest }}**.
  1. Укажите параметры требуемой инфраструктуры:

      * **{{ ui-key.yacloud.baremetal.extend.RequestClusterDialog.fieldVcpu }}**;
      * **{{ ui-key.yacloud.baremetal.extend.RequestClusterDialog.fieldRam }}**;
      * **{{ ui-key.yacloud.baremetal.extend.RequestClusterDialog.fieldStorage }}**;
      * **{{ ui-key.yacloud.baremetal.extend.RequestClusterDialog.fieldTask }}** — опишите назначение кластера, требования к виртуальным машинам, сети и отказоустойчивости.

  1. Укажите компанию, имя и фамилию, номер телефона и электронную почту для связи.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.extend.RequestClusterDialog.actionSubmit }}**.

{% endlist %}

Отправка заявки не создает кластер автоматически. Специалист {{ yandex-cloud }} свяжется с вами по указанным контактам, чтобы уточнить требования и согласовать конфигурацию. После развертывания кластер появится в подразделе **{{ ui-key.yacloud.baremetal.label_extend-virtualization }}**, а входящие в него серверы — в списке серверов {{ baremetal-name }}.

#### См. также {#see-also}

* [{#T}](../../concepts/extend/virtualization.md)
* [{#T}](../../concepts/server-configurations.md)
* [{#T}](../../concepts/network.md)
