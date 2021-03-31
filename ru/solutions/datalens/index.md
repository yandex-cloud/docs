# Сценарии использования

Ниже описаны сценарии использования сервиса {{ datalens-full-name }}:

{% if audience != "internal" %} 

- [Визуализация данных из CSV-файла](data-from-csv-visualization.md)
- [Визуализация данных из базы данных ClickHouse](data-from-ch-visualization.md)
- [Визуализация данных из Metriсa](data-from-metrica-visualization.md)
- [Визуализация данных из Metriсa Logs API](data-from-metrica-logsapi-visualization.md)
- [Публикация в DataLens Public диаграммы с картой на основе CSV-файла](data-from-csv-to-public-visualization.md)
- [Визуализация данных из AppMetrica](data-from-appmetrica-visualization.md)
- [Визуализация геоданных из CSV-файла](data-from-csv-geo-visualization.md)
- [Визуализация данных из базы данных ClickHouse с геослоями из Marketplace](data-from-csv-geo-visualization.md)
- [Визуализация данных из статистики подкастов Яндекс.Музыки](data-from-podcasts.md)

{% endif %}

{% if audience == "internal" %}

- [Визуализация данных из CSV-файла](data-from-csv-visualization.md)
- [Визуализация данных из ClickHouse over YT (CHYT)](data-from-ch-over-yt.md)
- [Визуализация геоданных из CSV-файла](data-from-csv-geo-visualization.md)
- [Визуализация данных из отчетов Statface](data-from-statface-visualization.md)

{% endif %}