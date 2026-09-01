---
title: Создать кластер {{ baremetal-extend-stackland-name }}
description: Следуя этой инструкции, вы сможете создать кластер {{ baremetal-extend-stackland-name }} на серверах {{ baremetal-name }}.
---

# Создать кластер {{ baremetal-extend-stackland-name }}

{{ baremetal-extend-stackland-name }} автоматически подготавливает серверы и разворачивает на них кластер {{ stackland-name }}. Через консоль управления можно отправить заявку на подключение решения. Если доступ уже предоставлен, кластер можно создать с помощью CLI.

Перед отправкой заявки подготовьте описание задачи и определите, какие компоненты {{ stackland-name }} планируете использовать.

Перед созданием кластера с помощью CLI подготовьте:

* лицензионный ключ {{ stackland-name }};
* приватную подсеть {{ baremetal-name }} и CIDR для узлов кластера;
* базовый DNS-домен кластера;
* SSH-ключ и пароль для доступа к бастионному хосту; пароль можно хранить в [секрете {{ lockbox-name }}](../../../lockbox/concepts/secret.md);
* конфигурации и количество серверов для каждой роли узлов.

{% note warning %}

Если вы добавляете в кластер уже арендованные серверы, {{ baremetal-extend-stackland-name }} переустановит на них операционную систему. Все данные на дисках этих серверов будут удалены.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого хотите отправить заявку.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.baremetal.label_extend }}**, затем — **{{ ui-key.yacloud.baremetal.label_extend-stackland }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.extend.StacklandListPage.leaveRequest }}**.
  1. Опишите задачу, которую планируете решать с помощью {{ stackland-name }}.
  1. Выберите компоненты {{ stackland-name }}, которые планируете использовать.
  1. Заполните контактные данные и нажмите кнопку **{{ ui-key.yacloud.baremetal.extend.RequestClusterDialog.actionSubmit }}**.

  Специалист {{ yandex-cloud }} свяжется с вами по указанным контактам, чтобы уточнить требования и порядок предоставления решения.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Создайте YAML-шаблон запроса:

      ```bash
      yc baremetal v2 extend stackland-cluster create --example-yaml > stackland-cluster.yaml
      ```

  1. Откройте файл `stackland-cluster.yaml` и укажите:

      * идентификаторы облака и каталога;
      * имя, описание и метки кластера;
      * идентификатор пула серверов, пресет и версию {{ stackland-name }};
      * лицензионный ключ и базовый DNS-домен;
      * группы узлов и их роли, конфигурации, количество и идентификаторы уже арендованных серверов;
      * параметры бастионного хоста, SSH-ключ и один способ передачи пароля;
      * CIDR приватной подсети;
      * доступ в публичную сеть, если он требуется.

      Описание полей приведено в [справочнике команды](../../cli-ref/v2/extend/stackland-cluster/create.md).

      {% note info %}

      Параметр доступа в публичную сеть задается только при создании кластера. В полях с несколькими альтернативными способами передачи значения, например SSH-ключа или пароля, оставьте только один способ.

      {% endnote %}

  1. Создайте кластер:

      ```bash
      yc baremetal v2 extend stackland-cluster create \
        --request-file stackland-cluster.yaml
      ```

  1. Проверьте состояние кластера:

      ```bash
      yc baremetal v2 extend stackland-cluster list \
        --cloud-id <идентификатор_облака> \
        --folder-id <идентификатор_каталога>
      ```

{% endlist %}

Создание и подготовка серверов занимают некоторое время. Когда кластер будет готов, откройте его страницу в подразделе **{{ ui-key.yacloud.baremetal.label_extend-stackland }}**. На странице отображаются узлы, их роли, конфигурации, приватные IP-адреса и бастионный хост.

#### См. также {#see-also}

* [{#T}](../../concepts/extend/stackland.md)
* [Подготовка к работе с {{ stackland-name }}](../../../stackland/quickstart.md#prerequisites)
* [Установка {{ stackland-name }} на {{ baremetal-name }}](../../../stackland/tutorials/install-on-yc-bms.md)
