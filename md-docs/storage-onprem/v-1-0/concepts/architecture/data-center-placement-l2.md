# Размещение в датацентрах с L2-балансировщиком

## Пример размещения в одном датацентре {#single-data-center}

* Используется четыре VIP-адреса для S3-API.
* Все четыре адреса должны быть в DNS.
* Для MGMT-адресов — по одному VIP (например, S3-Console).

![single-data-center](../../_assets/data-center-placement-l2/single-data-center.svg)


### Отказ ноды {#node-failure}

При отказе ноды ее VIP-адреса переезжают на любой из доступных серверов.

![node-failure](../../_assets/data-center-placement-l2/node-failure.svg)


### Доступ к S3-API через отдельный L2-сегмент {#separate-l2-segment}

S3-client должен иметь доступ к DATA-сегменту, но не к MGMT.

![separate-l2-segment](../../_assets/data-center-placement-l2/separate-l2-segment.svg)

![separate-l2-segment-2](../../_assets/data-center-placement-l2/separate-l2-segment-2.svg)


## Доступ администратора {#admin-access}

Администратор должен иметь доступ к MGMT.

![admin-access](../../_assets/data-center-placement-l2/admin-access.svg)


## Пример размещения в трех датацентрах и с разделенным DNS {#three-data-centers}

* Шесть VIP-адресов для S3-API. По два на датацентр.
* Три VIP-адреса для S3-Console, по одному на датацентр.
* Split-DNS. Клиенты в каждом датацентре должны получать только адреса из этого датацентра.

![three-data-centers](../../_assets/data-center-placement-l2/three-data-centers.svg)


### Отказ одного датацентра {#data-center-failure}

В случае отказа одного сервера его VIP-адреса переедут на соседний сервер в том же датацентре.

![data-center-failure](../../_assets/data-center-placement-l2/data-center-failure.svg)


### Отказ всех машин в датацентре {#dc-all-machines-failure}

В случае отказа всех машин в датацентре VIP-адреса в этом датацентре станут недоступны — для продолжения работы потребуется внести изменения в DNS. Отказ датацентра не повлияет на работу клиентов из других датацентров.

![dc-all-machines-failure](../../_assets/data-center-placement-l2/dc-all-machines-failure.svg)