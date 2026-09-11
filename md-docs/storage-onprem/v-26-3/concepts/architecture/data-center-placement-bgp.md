[Документация Yandex Cloud](../../../../index.md) > [On-premises Yandex Object Storage](../../../index.md) > Версия 26.3 > [Концепции](../../index.md) > [Архитектура продукта](index.md) > Примеры балансировки > Размещение в датацентрах с BGP-балансировкой

# Размещение в дата-центрах с BGP-балансировкой

Ключевые свойства BGP-балансировки:

* Все VIP-адреса анонсируются со всех узлов во всех дата-центрах.
* Минимально нужен один VIP-адрес для S3 API, дополнительно по одному адресу на каждый сервис — консоль управления, observability-инструменты и т. д.
* Для доступа к интерфейсам администратора можно использовать один общий VIP-адрес.
* Балансировка происходит с помощью ECMP на маршрутизаторе, не нужен отдельный узел для балансировки.
* Отказоустойчивость обеспечивается за счет работы BGP в сочетании с BFD — быстрым протоколом обнаружения отказов.
* VIP-адреса не должны быть из той же подсети, что и L2-адреса на интерфейсах.
* Есть возможность в каждом дата-центре анонсировать отдельный набор адресов. Настройка не рекомендуется, так как требует использования split-horizon DNS и снижает отказоустойчивость, но может использоваться, если есть требования по изоляции данных.

## Пример размещения в одном дата-центре {#single-data-center}

Object Storage может быть развернут в одном дата-центре.

[![single-data-center](../../_assets/data-center-placement-bgp/single-data-center1.svg)](https://storage.yandexcloud.net/doc-files/data-center-placement/bgp/single-data-center1.svg)

Клиенты из других дата-центров могут обращаться к Object Storage, если между дата-центрами настроено межсетевое соединение (интерконнект).

[![single-data-center](../../_assets/data-center-placement-bgp/single-data-center2.svg)](https://storage.yandexcloud.net/doc-files/data-center-placement/bgp/single-data-center2.svg)

### Отказ узла {#node-failure}

При отказе узла BGP-сессия с ним завершается, и маршрутизатор перестает направлять трафик на этот узел. Остальные узлы продолжают обслуживать запросы без изменений в DNS.

[![bgp-down](../../_assets/data-center-placement-bgp/bgp-down.svg)](https://storage.yandexcloud.net/doc-files/data-center-placement/bgp/bgp-down.svg)


## Доступ администратора {#admin-access}

Доступ к интерфейсам администратора (консоль управления, observability-инструменты) организуется через выделенную сеть MGMT, разграничить доступ администраторов и пользователей можно при помощи файрвола. Также благодаря выделенной сети MGMT доступ к интерфейсам управления остается стабильным даже при высокой нагрузке на DATA.

[![admin-ui-access](../../_assets/data-center-placement-bgp/admin-ui-access.svg)](https://storage.yandexcloud.net/doc-files/data-center-placement/bgp/admin-ui-access.svg)


## Пример размещения в нескольких дата-центрах {#multiple-data-centers}

Если дата-центров несколько, маршрутизатор автоматически определяет, нужно ли перенаправлять трафик между ними. Также трафик локализуется внутри дата-центра без использования split-horizon DNS, и клиент получает ответ от ближайшего узла.

[![multiple-data-centers](../../_assets/data-center-placement-bgp/multiple-data-centers.svg)](https://storage.yandexcloud.net/doc-files/data-center-placement/bgp/multiple-data-centers.svg)

При отказе всех узлов дата-центра маршрутизатор автоматически перенаправит трафик в другие дата-центры — изменения в DNS не требуются.

[![bgp-down-all-nodes](../../_assets/data-center-placement-bgp/bgp-down-all-nodes.svg)](https://storage.yandexcloud.net/doc-files/data-center-placement/bgp/bgp-down-all-nodes.svg)

Если в дата-центре клиента нет узлов хранения, трафик также направляется в дата-центры, где узлы хранения присутствуют.

[![no-storage-nodes](../../_assets/data-center-placement-bgp/no-storage-nodes.svg)](https://storage.yandexcloud.net/doc-files/data-center-placement/bgp/no-storage-nodes.svg)