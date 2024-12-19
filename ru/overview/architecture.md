# Архитектура платформы {{ yandex-cloud }}

Облачная платформа {{ yandex-cloud }} — это набор надежных и безопасных сервисов для решения любых бизнес-задач. Сервисы платформы используют единый пул унифицированных аппаратных ресурсов, что позволяет быстро масштабировать платформу и с минимальными затратами автоматически подключать дополнительную инфраструктуру, если это необходимо.

![Architecture](../_assets/overview/architecture.svg =450x)

Сетевое и серверное оборудование платформы {{ yandex-cloud }} размещается в [трех дата-центрах](concepts/geo-scope.md). На них работает базовая инфраструктура платформы: виртуальные сети и машины, сетевые блочные хранилища и база данных [YDB](https://ydb.tech). С помощью [виртуализации](../glossary/virtualization) оборудование дата-центров позволяет создавать имитированные вычислительные среды, разделяющие физическую и сетевую инфраструктуру между виртуальными машинами.

Поверх базовой инфраструктуры работают [сервисы платформы](concepts/services.md). Для работы с сервисами доступны различные интерфейсы: [консоль управления](../console/) и собственные интерфейсы сервисов, [мобильное приложение {{ yandex-cloud }}](mobile-app/index.md), [интерфейс командной строки CLI](../cli/), инструменты разработки и [API](api.md).


## Видео об инфраструктуре {{ yandex-cloud }} {#see-also}

* Архитектура Compute.

  @[youtube](https://www.youtube.com/watch?v=ynkFYOFHn_Q&list=PL1x4ET76A10aMRLrpxwRzrEg8pcFp8yUv&index=4)

* Архитектура гипервизора.

  @[youtube](https://www.youtube.com/watch?v=z4rm5fQw_8Y&list=PL1x4ET76A10aMRLrpxwRzrEg8pcFp8yUv&index=5)

* Архитектура [{{ iam-full-name }}](../iam/index.yaml).

  @[youtube](https://www.youtube.com/watch?v=JCu5WD1o9Is&list=PL1x4ET76A10aMRLrpxwRzrEg8pcFp8yUv&index=5)

* Архитектура [{{ objstorage-full-name }}](../storage/index.yaml).

  @[youtube](https://www.youtube.com/watch?v=NElTqVWM8WQ&list=PL1x4ET76A10aMRLrpxwRzrEg8pcFp8yUv&index=2)

* Архитектура YDB Serverless.

  @[youtube](https://www.youtube.com/watch?v=aL9NHR0i0Xs&list=PL1x4ET76A10aMRLrpxwRzrEg8pcFp8yUv&index=7)

Больше видео на Youtube-канале {{ yandex-cloud }}:

* [Плейлист about:cloud — infrastructure](https://www.youtube.com/playlist?list=PL1x4ET76A10aMRLrpxwRzrEg8pcFp8yUv).
* [Устройство сетевой инфраструктуры](https://youtu.be/4flMKfBKMd4?list=PL1x4ET76A10ZpAEZcRFNuTGhNQXAc8CNw).
* [Экскурсия по дата-центру](https://www.youtube.com/watch?v=xbNPpD43uvE).
* [Устройство виртуальной сети](https://www.youtube.com/watch?v=QsuBmnF2Wus&list=PL1x4ET76A10ZpAEZcRFNuTGhNQXAc8CNw&index=33).
* [Как работает {{ mgp-full-name }}](https://www.youtube.com/live/ec9hifUiMoE?feature=share).
* [Под капотом {{ speechkit-full-name }}](https://youtu.be/LVD104U4IjM).

