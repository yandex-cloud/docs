### Для каких подключений материализация недоступна? {#unavailable-materialization}

Для подключений {% if audience == "internal" %}  Statface Report, {% endif %} Metrica API, AppMetrica, Metrica Logs API, AppMetrica Logs API материализация недоступна.
Для подключения CSV материализация происходит автоматически один раз при загрузке файла, после этого материализация для данного подключения работать не будет.
