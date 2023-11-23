### Как сделать геокодинг — получить координаты точки по адресу? {#make-geocode}

Раньше для таких задач можно было использовать функцию `GEOCODE()`. Сейчас она недоступна.
Вы можете воспользоваться [геокодером](https://yandex.ru/dev/maps/geocoder) через API Яндекс Карт. Обратите внимание на [условия лицензирования](https://yandex.ru/dev/maps/commercial/doc/concepts/jsapi-geocoder.html) API.

См. [пример Jupyter ноутбука](https://github.com/yandex-cloud-examples/yc-datalens-get-coordinates-by-location) со скриптами геокодинга адресов.
