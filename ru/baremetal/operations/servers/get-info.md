---
title: Как получить информацию о сервере {{ baremetal-full-name }}
description: 'Следуя данной инструкции, вы сможете получить информацию о настройках сервера {{ baremetal-full-name }}: конфигурация сервера, сетевые настройки, операционная система и другие данные.'
---

# Получить информацию о сервере

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}** и в открывшемся списке серверов выберите нужный сервер.

      На открывшейся странице доступны следующие сведения:

      * В блоке **{{ ui-key.yacloud.common.overview }}** — общая информация о сервере, в т.ч. его имя, идентификатор, [статус](../../concepts/servers.md#server-status), [зона доступности](../../../overview/concepts/geo-scope.md) и [пул серверов](../../concepts/servers.md#server-pools).
      * В блоке **{{ ui-key.yacloud.baremetal.title_section-resources }}** — информация об аппаратной [конфигурации](../../concepts/server-configurations.md) сервера.
      * В блоке **{{ ui-key.yacloud.baremetal.title_section-server-marketplace-app }}** — информация об установленной на сервере операционной системе.
      * В блоке **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}** — информация о [публичной сети](../../concepts/network.md#public-network) сервера, в т.ч. идентификатор, тип и CIDR публичной подсети, адрес шлюза по умолчанию и [MAC-адреса](https://ru.wikipedia.org/wiki/MAC-адрес) сетевого интерфейса в публичной сети.
      * В блоке **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}** — информация о [приватной сети](../../concepts/network.md#private-network) сервера, в т.ч. о [приватной подсети](../../concepts/network.md#private-subnet), а также приватный IP-адрес и MAC-адреса сетевого интерфейса в приватной сети.
      * В блоке **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}** — информация об условиях аренды сервера, в т.ч. о периоде и сроке аренды, и ее автопродлении.
      * В блоках **{{ ui-key.yacloud.baremetal.title_section-backup }}** и **{{ ui-key.yacloud.baremetal.title_section-accesses }}** — информация о подключении сервера к [{{ backup-full-name }}](../../../backup/index.yaml) и публичный [SSH-ключ](../../../glossary/ssh-keygen.md) root-пользователя соответственно.

{% endlist %}