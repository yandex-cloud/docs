# Общие вопросы про Биллинг

#### Могу ли я использовать свою лицензию ОС на виртуальных машинах в {{ yandex-cloud }}? {#os-license}

Да. Подробнее смотри в разделе [Создание виртуальной машины](../../compute/operations/vm-create/create-linux-vm.md) документации сервиса [Yandex Compute Cloud](../../compute/).

#### Где можно ознакомиться с Соглашением об уровне обслуживания (SLA)? {#sla}

В {{ yandex-cloud }} для каждого сервиса предусмотрен свой SLA. Ознакомиться с SLA можно в разделе [Правовые документы]{% if product == "yandex-cloud" %}{% if lang == "ru" %}(https://yandex.ru/legal/cloud_sla/?lang=ru){% endif %}{% if lang == "en" %}(https://yandex.ru/legal/cloud_sla/?lang=en){% endif %}{% endif %}{% if product == "cloud-il" %}(https://nebius.com/il/docs/legal/sla){% endif %}.

#### Где я могу найти реквизиты {{ yandex-cloud }}? {#requisites}

{% if region == "ru" %}

Банковские реквизиты вы можете найти {% if lang == "ru" %}в документе [Учетная карточка ООО «Яндекс.Облако»](https://{{ s3-storage-host }}/doc-files/Yandex.Cloud_requisites.pdf), а также {% endif %}в разделе [Правовые документы]{% if lang == "ru" %}(https://yandex.ru/legal/cloud_oferta/){% endif %}{% if lang == "en" %}(https://yandex.ru/legal/cloud_oferta/?lang=en){% endif %} (пункт **18. Реквизиты Яндекса**).

{% endif %}

{% if region == "kz" %}

Банковские реквизиты вы можете найти в разделе [Правовые документы](https://yandex.com/legal/cloud_oferta_kz/) (пункт **18. Реквизиты Яндекса**).

{% endif %}

{% if region == "int" %}

Банковские реквизиты вы можете найти в разделе [Правовые документы](https://yandex.com/legal/cloud_customer_agreement/) (пункт **19. Реквизиты Яндекса**).

{% endif %}

#### Как обратиться в службу технической поддержки? {#support}

В зависимости от тарифного плана, вы можете [обратиться в службу технической поддержки]({{ link-console-support }}) одним из способов:

{% include [support-channels](../../_includes/support/channels.md) %}