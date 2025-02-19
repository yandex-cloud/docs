---
title: Каталоги метаданных в виртуальных машинах {{ compute-name }}
description: Из этой статьи вы узнаете о каталогах и содержащихся в них ключах, доступных в сервисе метаданных виртуальных машин {{ compute-full-name }}.
---

# Каталоги метаданных

[Сервис метаданных](../vm-metadata.md) ВМ предоставляет доступ к следующим каталогам с метаданными:

| **Каталог** | **Путь** |
| --- | --- |
| `computeMetadata` | [/computeMetadata/v1/](#dir-compute) |
| `user-data` | [/latest/user-data/](#dir-user) |

## computeMetadata {#dir-compute}

Каталог `computeMetadata` содержит следующие основные ключи:

#|
|| **Название ключа (путь)** | **Описание** | **Пример значения** ||
|| instance/attributes/enable-oslogin | Ключ, отвечающий за доступ к ВМ через [{{ oslogin }}](../../../organization/concepts/os-login.md). Возможные значения:</br>- `true` — доступ включен;</br>- `false` — доступ выключен. | `true` ||
|| instance/attributes/install-unified-agent | Ключ, отвечающий за установку на ВМ агента [{{ unified-agent-short-name }}](../../../monitoring/concepts/data-collection/unified-agent/index.md). Возможные значения:</br>- `1` — агент установлен;</br>- `0` — агент не установлен. | `0` ||
|| instance/attributes/serial-port-enable | Ключ, отвечающий за доступ к ВМ через [серийную консоль](../../operations/serial-console/index.md). Возможные значения:</br>- `1` — доступ включен;</br>- `0` — доступ выключен. | `0` ||
|| instance/description | Описание ВМ. | `VM description` ||
|| instance/hostname | Полное внутренне имя ВМ ([FQDN](../network.md#hostname)). | `my-vm.{{ region-id }}.internal` ||
|| instance/id | Идентификатор ВМ. | `epdhfouo8bgq********` ||
|| instance/maintenance-event | Ключ, указывающий, наступило ли событие по [обслуживанию ВМ](../vm-policies.md). | `NONE` ||
|| instance/name | Имя ВМ. | `my-vm-name` ||
|| instance/zone | Идентификатор [зоны доступности](../../../overview/concepts/geo-scope.md) в формате `projects/<cloud-id>/zones/<zone-id>`. | `projects/b1g3o1qx3ra2********/zones/{{ region-id }}-d` ||
|| instance/disks/ | Список индексов [дисков](../disk.md) ВМ. | `0/` ||
|| instance/disks/<индекс_диска>/device-name | Идентификатор диска. | `epds95ahfikq********` ||
|| instance/disks/<индекс_диска>/mode | Режим работы диска. | `READ_WRITE` ||
|| instance/disks/<индекс_диска>/type | [Тип](../disk.md#disks-types) диска. | `PERSISTENT` ||
|| instance/disks/<индекс_диска>/index | Индекс в списке индексов дисков ВМ. | `0` ||
|| instance/network-interfaces/ | Список индексов [сетевых интерфейсов](../network.md) ВМ. | `0/` ||
|| instance/network-interfaces/<индекс_интерфейса>/ip | [Внутренний IPv4-адрес](../network.md#internal-ip) сетевого интерфейса ВМ. | `10.128.0.27` ||
|| instance/network-interfaces/<индекс_интерфейса>/mac | [MAC-адрес](../network.md#mac-address) сетевого интерфейса ВМ. | `d0:0d:12:2f:84:2e` ||
|| instance/network-interfaces/<индекс_интерфейса>/network | Идентификатор [подсети](../../../vpc/concepts/network.md#subnet), к которой подключен сетевой интерфейс. | `e2lqsms4cdl3********` ||
|| instance/network-interfaces/<индекс_интерфейса>/access-configs/<индекс_интерфейса>/external-ip | [Публичный IP-адрес](../network.md#public-ip) сетевого интерфейса ВМ. | `178.1**.2**.123` ||
|| instance/network-interfaces/<индекс_интерфейса>/access-configs/<индекс_интерфейса>/type | Тип внешней связности сетевого интерфейса ВМ. | `ONE_TO_ONE_NAT` ||
|| instance/service-accounts/ | Ключ, указывающий, привязан ли к ВМ [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Если сервисный аккаунт не привязан, ключ ничего не возвращает. | `default/` ||
|| instance/service-accounts/default/token | [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта в формате [JSON](https://ru.wikipedia.org/wiki/JSON). | 
```
\{"access_token":"t1.9euelZ*********dXkMXAQ",
"expires_in":42617,"token_type":"Bearer"\}
```
||
|| instance/vendor/cloud-id | Идентификатор [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud), в котором создана ВМ. | `b1gia87mbaom********` ||
|| instance/vendor/folder-id | Идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создана ВМ. | `b1gt6g8ht345********` ||
|| instance/vendor/identity/document | [Идентификационный документ](./identity-document.md) в формате JSON, в котором содержится информация об идентификаторе ВМ (`instanceId`), идентификаторе образа (`imageId`), из которого данная ВМ была создана, а также дополнительная информация об образе ВМ. | 
```
\{"instanceId":"epdhfouo8bgq********",
"productCodes":null,"imageId":"fd8a1rd5b389********",
"productIds":["f2ev7krjsaqc********","f2eokm18lqng********"],
"createdAt":"2024-05-09T20:47:02Z","version":"2023-03-01"\}
```
||
|| instance/vendor/identity/base64 | [Криптографическая подпись](./identity-document.md#signed-identity-documents) идентификационного документа в формате [Base64](https://www.base64encode.org/). | `U9UfLdKb91Zd********0bBs8ta0g==` ||
|| instance/vendor/identity/dsa | Криптографическая подпись идентификационного документа в формате [DSA](https://ru.wikipedia.org/wiki/DSA). | 
```
-----BEGIN PKCS7-----MIIB+QYJKoZIhvc
******/RaHgWi0=-----END PKCS7-----
```
||
|| instance/vendor/labels | Список ключей [меток](../../../resource-manager/concepts/labels.md), которые привязаны к ВМ. | `env` ||
|| instance/vendor/labels/<ключ_метки> | Значение для выбранного ключа метки из списка. | `prod` ||
|| instance/vendor/environment | Облачный [регион](../../../overview/concepts/region.md). | `{{ region-id }}` ||
|| yandex/folder-id | Идентификатор каталога, в котором создана ВМ. | `b1gt6g8ht345********` ||
|#


## user-data {#dir-user}

Каталог `user-data` не содержит отдельных ключей, и все данные отдаются сразу целиком при обращении к корневому ключу каталога `/latest/user-data/`.

В этом каталоге хранится метаинформация, которая задается пользователем при [создании](../../operations/index.md#vm-create) или [изменении](../../operations/vm-control/vm-update.md#change-metadata) ВМ. Получателем этой информации является процесс [cloud-init](https://cloudinit.readthedocs.io/en/latest/index.html), который запускается при старте ВМ.

Чтобы получить информацию из этого каталога, нужно [выполнить запрос](../../operations/vm-info/get-info.md#example4).

{% note alert %}

Все данные в каталоге метаданных `user-data` будут доступны в открытом виде любому пользователю, имеющему терминальный доступ к ВМ.

{% endnote %}

#### См. также {#see-also}

* [{#T}](../vm-metadata.md)
* [{#T}](./public-image-keys.md)
* [{#T}](./sending-metadata.md)
* [{#T}](./accessing-metadata.md)
* [{#T}](./identity-document.md)