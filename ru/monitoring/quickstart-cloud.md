# Начало работы с Solomon

В этом документе приведена пошаговая инструкция, как начать работу с Solomon, для сервисов, развёрнутых в Яндекс.Облаке или являющихся одним из сервисов Яндекс.Облака.

## Адреса инсталляции {#installation}
В Яндекс.Облаке следует использовать одну из облачных инсталляций Solomon. Общий принцип выбора инсталляции:
- поставлять метрики нужно в Solomon в той же инсталляции, в которой развернуты приложения — из preprod в preprod, из prod в prod, из israel в israel;
- в остальных инсталляциях поставлять метрики нужно в preprod.

Адреса Solomon UI:
- prod: [https://solomon.cloud.yandex-team.ru](https://solomon.cloud.yandex-team.ru)
- preprod: [https://solomon.cloud-preprod.yandex-team.ru](https://solomon.cloud-preprod.yandex-team.ru)
- israel: [https://solomon.yandexcloud.co.il](https://solomon.yandexcloud.co.il)

Monitoring UI для облачных инсталляций будет развёрнут в Q1 2022.

## Получение сетевых доступов {#access}

Для получения сетевых доступов необходимо создать заявку через Puncher от `_C_CLOUD_PROD_SOLOMON_CORE_` к хостам, на которых вы развернёте демонстрационное приложение ([шаблон заявки](https://puncher.yandex-team.ru/?create_sources=_C_CLOUD_PROD_SOLOMON_CORE_&create_protocol=tcp&create_locations=office&create_locations=vpn&create_comment=Solomon%20Cloud%20Prod%20собирает%20метрики%20в%20pull-режиме&create_ports=3451)).

{% note warning %}

Если на хостах, где будет развернуто демонстрационное приложение, используются [группы безопасности (Security Groups)](https://cloud.yandex.ru/docs/vpc/concepts/security-groups), то помимо доступа через Puncher нужно [добавить новое правило](https://cloud.yandex.ru/docs/vpc/operations/security-group-update) в группу безопасности, разрешающее сетевой доступ.

В поле _Источник_ нового правила нужно указать две подсети в CIDR-формате – `2a02:6b8::/32
` и `2a0d:d6c0::/29`.

{% endnote %}

## Создание проекта {#project}

Прежде чем передавать метрики в Solomon, необходимо:
- создать обычное или [сервисное](https://wiki.yandex-team.ru/cloud/devel/selfhost/terraform/#kakdobavitnovyeresursy) облако — оно автоматически появится в списке проектов Solomon в течение одного-двух часов;
- выдать требуемые права доступа к нему через IAM в консоли;
- попросить "пометить проект-облако как внутреннее" и "переключить его на IAM authorizer" через тикет в MONITORINGREQ.

После выполнения этих действий в [https://solomon.cloud.yandex-team.ru](https://solomon.cloud.yandex-team.ru) появится проект с названием, соответствующим идентификатору вашего облака, к которому у вас будет доступ на редактирование.

{% include notitle [_](../_includes/monitoring/quickstart-common.md) %}

{% list tabs %}


- Instance groups

  - Нажмите кнопку _"+"_ в блоке _Cluster hosts_;
  - Выберите пункт _Instance groups_ в левом меню;
  - Укажите идентификатор instance group в поле _Instance group ID_ или идентификатор каталога в поле _Folder ID_ (тогда будет обнаружены все виртуальные машины во всех группах в каталоге);
  - Остальные поля оставьте пустыми;
  - Нажмите кнопку _OK_.

- DNS

  - Нажмите кнопку _"+"_ в блоке _Cluster hosts_;
  - Выберите пункт _Cloud DNS_ в левом меню;
  - Укажите окружение в поле _Environment_;
  - Укажите имя ресурса в поле _Resource name_;
  - Остальные поля оставьте пустыми;
  - Нажмите кнопку _OK_.

- Список хостов

  - Нажмите кнопку _"+"_ в блоке _Cluster hosts_;
  - Выберите пункт _Hosts_ в левом меню;
  - Укажите FQDN хоста в поле _URL pattern_, остальные поля оставьте пустыми;
  - Нажмите кнопку _OK_.

- Другие способы

  В Solomon также реализованы другие способы обнаружения хостов:
  - динамически через вызов API-метода (_Host URLs_);
  - подсеть в формате CIDR (_Network_);
  - во внутренней инсталляции Яндекса доступны [дополнительные способы](quickstart-yateam.md#cluster) обнаружения хостов.

{% endlist %}

{% include notitle [_](../_includes/monitoring/quickstart-common-2.md) %}


1. Откройте веб-интерфейс [Solomon](https://solomon.cloud.yandex-team.ru);
1. Выберите ваш проект в списке;

{% include notitle [_](../_includes/monitoring/quickstart-common-3.md) %}

