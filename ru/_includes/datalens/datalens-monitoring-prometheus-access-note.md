{% note warning %}

Управление правами для QL-чартов по данным {{ monitoring-short-name }} и {{ prometheus-name }} выполняется не только на стороне DataLens, но и в самих сервисах {{ monitoring-short-name }} и {{ prometheus-name }}.

Для просмотра графика в {{ datalens-short-name }} пользователю необходимы права на чарт и подключение, а также на чтение данных из конкретного {{ prometheus-name }} API или проекта в {{ monitoring-short-name }}.

{% endnote %}