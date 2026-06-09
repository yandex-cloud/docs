# Правила тарификации для {{ video-full-name }}




Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

## Из чего складывается стоимость использования {{ video-name }} {#rules}

При использовании сервиса {{ video-name }} оплачиваются услуги:

* Исходящий трафик — плата за передачу видео с CDN-серверов {{ yandex-cloud }} в интернет. Это трафик передачи и показа видео вашим зрителям. Плата не зависит от типа видео и одинакова для загруженных роликов и для трансляций.
* Транскодирование — плата за преобразование [видео](concepts/videos.md) при его загрузке в сервис.
* Транскодирование видео трансляции — плата за преобразование видеопотока [трансляции](concepts/streams.md).
* Хранение потокового видео — плата за хранение видеопотока после транскодирования. При транскодировании получается несколько вариантов видео с различным битрейтом и разрешением, поэтому суммарный объем потокового видео может быть больше, чем оригиналов.
* Хранение оригинала — плата за хранение исходных видео, которые были загружены в {{ video-name }}.
* Хранение видео трансляции — плата за хранение записей трансляций.

Видео хранится в сервисе {{ objstorage-name }}, объем данных измеряется в ГБ в месяц. Объем видео в течение месяца считается как среднее значение за месяц, согласно данным, гранулированным посекундно. Минимальная единица тарификации — час хранения 1 МБ данных.

Минимальная единица тарификации исходящего трафика — 1 ГБ.

{% note info %}

[Нейросетевые функции](concepts/videos.md#ai-capabilities), такие как автоматическая генерация субтитров, суммаризация и нейроперевод, уже включены в стоимость других услуг работы с видео и дополнительно не тарифицируются.

{% endnote %}

## Цены для региона Россия {#prices}

{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |




## Примеры расчета {#price-example}

### Стоимость хостинга видео {#hosting-example}

Вычислим стоимость услуг сервиса в месяц по следующим данным:

* Количество загруженных видео — `10 штук`.
* Длительность каждого видео — `10 минут`.
* Общая длительность видео (для расчета стоимости транскодирования) — `10 штук` × `10 минут` = `100 минут`.
* Общий объем оригинальных файлов — `5 ГБ`
* Объем видео в потоковом формате (более оптимизированный формат, представленный в нескольких вариантах с различным битрейтом и разрешением) — `8 ГБ`.
* Исходящий трафик (общий объем передачи видео при просмотрах) — `50 ГБ`.

В расчетах предполагаем, что все видео хранятся весь месяц (и оригинал, и потоковая версия). Хранение тарифицируется в единицах ГБ × час, поэтому в формулах объем видео умножается на 720 — количество часов в месяце.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Стоимость транскодирования видео — `100 минут` (взимается однократно при загрузке видео):
  
  > 100 × {{ sku|RUB|video.transcoding.vod.v1|string }} = {% calc [currency=RUB] 100  × {{ sku|RUB|video.transcoding.vod.v1|number }} %}
  
  Стоимость хранения оригинала видео — `5 ГБ` и потокового видео — `8 ГБ`:
  
  > 5 × 720 × {{ sku|RUB|storage.bucket.used_space.ice|string }} = {% calc [currency=RUB] 5  × 720 × {{ sku|RUB|storage.bucket.used_space.ice|number }} %}
  >
  > 8 × 720 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|string }} = {% calc [currency=RUB] 8  × 720 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|number }} %}
  
  Стоимость исходящего трафика — `50 ГБ`:
  
  > 50 × {{ sku|RUB|video.cdn.traffic.egress|string }} = {% calc [currency=RUB] 50  × {{ sku|RUB|video.cdn.traffic.egress|number }} %}
  
  Общая стоимость услуг сервиса за месяц составит:
  
  > {% calc [currency=RUB] 100  × {{ sku|RUB|video.transcoding.vod.v1|number }} %} + {% calc [currency=RUB] 5 × 720 × {{ sku|RUB|storage.bucket.used_space.ice|number }} %} + {% calc [currency=RUB] 8 × 720 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|number }} %} + {% calc [currency=RUB] 50 × {{ sku|RUB|video.cdn.traffic.egress|number }} %} = {% calc [currency=RUB] 100  × {{ sku|RUB|video.transcoding.vod.v1|number }} + 5 × 720 × {{ sku|RUB|storage.bucket.used_space.ice|number }} + 8 × 720 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|number }} + 50 × {{ sku|RUB|video.cdn.traffic.egress|number }} %}

- Расчет в тенге {#prices-kzt}

  Стоимость транскодирования видео — `100 минут` (взимается однократно при загрузке видео):
  
  > 100 × {{ sku|KZT|video.transcoding.vod.v1|string }} = {% calc [currency=KZT] 100  × {{ sku|KZT|video.transcoding.vod.v1|number }} %}
  
  Стоимость хранения оригинала видео — `5 ГБ` и потокового видео — `8 ГБ`:
  
  > 5 × 720 × {{ sku|KZT|storage.bucket.used_space.ice|string }} = {% calc [currency=KZT] 5  × 720 × {{ sku|KZT|storage.bucket.used_space.ice|number }} %}
  >
  > 8 × 720 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|string }} = {% calc [currency=KZT] 8  × 720 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|number }} %}
  
  Стоимость исходящего трафика — `50 ГБ`:
  
  > 50 × {{ sku|KZT|video.cdn.traffic.egress|string }} = {% calc [currency=KZT] 50  × {{ sku|KZT|video.cdn.traffic.egress|number }} %}
  
  Общая стоимость услуг сервиса за месяц составит:
  
  > {% calc [currency=KZT] 100  × {{ sku|KZT|video.transcoding.vod.v1|number }} %} + {% calc [currency=KZT] 5 × 720 × {{ sku|KZT|storage.bucket.used_space.ice|number }} %} + {% calc [currency=KZT] 8 × 720 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|number }} %} + {% calc [currency=KZT] 50 × {{ sku|KZT|video.cdn.traffic.egress|number }} %} = {% calc [currency=KZT] 100  × {{ sku|KZT|video.transcoding.vod.v1|number }} + 5 × 720 × {{ sku|KZT|storage.bucket.used_space.ice|number }} + 8 × 720 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|number }} + 50 × {{ sku|KZT|video.cdn.traffic.egress|number }} %}

{% endlist %}



### Стоимость трансляций {#stream-example}

Вычислим стоимость трансляции в месяц по следующим данным:

* Длительность трансляции — `60 минут`.
* Объем записи трансляции — `3 ГБ`.
* Исходящий трафик (общий объем передачи видео зрителям) — `20 ГБ`.

Хранение тарифицируется в единицах ГБ × час, поэтому в формулах объем записи умножается на 720 — количество часов в месяце.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Стоимость транскодирования трансляции — `60 минут`:
  
  > 60 × {{ sku|RUB|video.transcoding.live.v1|string }} = {% calc [currency=RUB] 60 × {{ sku|RUB|video.transcoding.live.v1|number }} %}
  
  Стоимость хранения записи трансляции — `3 ГБ` за месяц (720 часов):
  
  > 3 × 720 × {{ sku|RUB|video.used_space.live.v1|string }} = {% calc [currency=RUB] 3 × 720 × {{ sku|RUB|video.used_space.live.v1|number }} %}
  
  Стоимость исходящего трафика — `20 ГБ`:
  
  > 20 × {{ sku|RUB|video.cdn.traffic.egress|string }} = {% calc [currency=RUB] 20 × {{ sku|RUB|video.cdn.traffic.egress|number }} %}
  
  Общая стоимость трансляции за месяц составит:
  
  > {% calc [currency=RUB] 60 × {{ sku|RUB|video.transcoding.live.v1|number }} %} + {% calc [currency=RUB] 3 × 720 × {{ sku|RUB|video.used_space.live.v1|number }} %} + {% calc [currency=RUB] 20 × {{ sku|RUB|video.cdn.traffic.egress|number }} %} = {% calc [currency=RUB] 60 × {{ sku|RUB|video.transcoding.live.v1|number }} + 3 × 720 × {{ sku|RUB|video.used_space.live.v1|number }} + 20 × {{ sku|RUB|video.cdn.traffic.egress|number }} %}

- Расчет в тенге {#prices-kzt}

  Стоимость транскодирования трансляции — `60 минут`:
  
  > 60 × {{ sku|KZT|video.transcoding.live.v1|string }} = {% calc [currency=KZT] 60 × {{ sku|KZT|video.transcoding.live.v1|number }} %}
  
  Стоимость хранения записи трансляции — `3 ГБ` за месяц (720 часов):
  
  > 3 × 720 × {{ sku|KZT|video.used_space.live.v1|string }} = {% calc [currency=KZT] 3 × 720 × {{ sku|KZT|video.used_space.live.v1|number }} %}
  
  Стоимость исходящего трафика — `20 ГБ`:
  
  > 20 × {{ sku|KZT|video.cdn.traffic.egress|string }} = {% calc [currency=KZT] 20 × {{ sku|KZT|video.cdn.traffic.egress|number }} %}
  
  Общая стоимость трансляции за месяц составит:
  
  > {% calc [currency=KZT] 60 × {{ sku|KZT|video.transcoding.live.v1|number }} %} + {% calc [currency=KZT] 3 × 720 × {{ sku|KZT|video.used_space.live.v1|number }} %} + {% calc [currency=KZT] 20 × {{ sku|KZT|video.cdn.traffic.egress|number }} %} = {% calc [currency=KZT] 60 × {{ sku|KZT|video.transcoding.live.v1|number }} + 3 × 720 × {{ sku|KZT|video.used_space.live.v1|number }} + 20 × {{ sku|KZT|video.cdn.traffic.egress|number }} %}

{% endlist %}