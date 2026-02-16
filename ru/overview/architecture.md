# Архитектура платформы {{ yandex-cloud }}

Облачная платформа {{ yandex-cloud }} — это набор надежных и безопасных сервисов для решения любых бизнес-задач. Сервисы платформы используют единый пул унифицированных аппаратных ресурсов, что позволяет быстро масштабировать платформу и с минимальными затратами автоматически подключать дополнительную инфраструктуру, если это необходимо.

![Architecture](../_assets/overview/architecture.svg =450x)

Сетевое и серверное оборудование платформы {{ yandex-cloud }} размещается в [трех дата-центрах](concepts/geo-scope.md). На них работает базовая инфраструктура платформы: виртуальные сети и машины, сетевые блочные хранилища и база данных [YDB](https://ydb.tech). С помощью [виртуализации](../glossary/virtualization) оборудование дата-центров позволяет создавать имитированные вычислительные среды, разделяющие физическую и сетевую инфраструктуру между виртуальными машинами.

Поверх базовой инфраструктуры работают [сервисы платформы](concepts/services.md). Для работы с сервисами доступны различные интерфейсы: [консоль управления](../console/) и собственные интерфейсы сервисов, [мобильное приложение {{ yandex-cloud }}](mobile-app/index.md), [интерфейс командной строки CLI](../cli/), инструменты разработки и [API](api.md).


## Видео об инфраструктуре {{ yandex-cloud }} {#see-also}

* Архитектура Compute.

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvl3amgaxyp2d6bpio?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=ynkFYOFHn_Q&list=PL1x4ET76A10aMRLrpxwRzrEg8pcFp8yUv&index=4).



* Архитектура гипервизора.

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvnbaxxaxatvm55yxf?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=z4rm5fQw_8Y&list=PL1x4ET76A10aMRLrpxwRzrEg8pcFp8yUv&index=5).



* Архитектура [{{ iam-full-name }}](../iam/index.yaml).

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvcu3nds2sajztxcth?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=JCu5WD1o9Is&list=PL1x4ET76A10aMRLrpxwRzrEg8pcFp8yUv&index=5).



* Архитектура [{{ objstorage-full-name }}](../storage/index.yaml).

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvngcqgcskyf3ysbha?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=NElTqVWM8WQ&list=PL1x4ET76A10aMRLrpxwRzrEg8pcFp8yUv&index=2).



* Архитектура YDB Serverless.

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvzisv5jta4jeq37w7?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=aL9NHR0i0Xs&list=PL1x4ET76A10aMRLrpxwRzrEg8pcFp8yUv&index=7).



Больше видео на Youtube-канале {{ yandex-cloud }}:

* [Плейлист about:cloud — infrastructure](https://www.youtube.com/playlist?list=PL1x4ET76A10aMRLrpxwRzrEg8pcFp8yUv).
* [Устройство сетевой инфраструктуры](https://youtu.be/4flMKfBKMd4?list=PL1x4ET76A10ZpAEZcRFNuTGhNQXAc8CNw).
* [Экскурсия по дата-центру](https://www.youtube.com/watch?v=xbNPpD43uvE).
* [Устройство виртуальной сети](https://www.youtube.com/watch?v=QsuBmnF2Wus&list=PL1x4ET76A10ZpAEZcRFNuTGhNQXAc8CNw&index=33).
* [Как работает {{ mgp-full-name }}](https://www.youtube.com/live/ec9hifUiMoE?feature=share).
* [Под капотом {{ speechkit-full-name }}](https://youtu.be/LVD104U4IjM).

