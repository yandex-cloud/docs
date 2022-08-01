Скачайте и [загрузите в бакет](../../../storage/operations/objects/upload) для исходных данных файл для обработки {% if product == "yandex-cloud" %} [text.txt](https://storage.yandexcloud.net/examples/text.txt): {% endif %} {% if product == "cloud-il" %} [text.txt](https://{{ s3-storage-host }}/examples/text.txt): {% endif %}

{% cut "text.txt" %}

```text
she sells sea shells on the sea shore
the shells that she sells are sea shells I am sure
so if she sells sea shells on the sea shore
I am sure that the shells are sea shore shells
```

{% endcut %}
