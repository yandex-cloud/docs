{% note info %}

При использовании API Kibana:

* Для отправки запросов используйте порт `443` вместо штатного `5601`.
* Добавьте путь к SSL-сертификату в конфигурацию вашего приложения для работы с API. Например, для приложения Winlogbeat пропишите путь в переменной `ssl.certificate_authorities`.

{% endnote %}
