Для образов загрузочного диска должны выполняться следующие требования:

{% include [image-create-requirements-sub1](./image-create-requirements-sub1.md) %}

* В зависимости от [поколения оборудования](../../compute/concepts/hardware-generations.md), которое будет закреплено за создаваемым образом, для загрузочного диска должны использоваться разные форматы размещения таблиц разделов жесткого диска:

    * поколения `Gen 1.1` и `Gen 1.2` — для загрузочного диска используется [MBR](https://ru.wikipedia.org/wiki/Главная_загрузочная_запись)-разбивка;
    * поколение `Gen 2` — для загрузочного диска используется [GPT](https://ru.wikipedia.org/wiki/Таблица_разделов_GUID)-разбивка.

{% include [image-create-requirements-sub2](./image-create-requirements-sub2.md) %}
