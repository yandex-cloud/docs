[Документация Yandex Cloud](../../../index.md) > [Все решения](../../index.md) > [Managed Service for PostgreSQL](../index.md) > Устранение ошибки `max_connections сonn_limit is too high`

# Устранение ошибки `max_connections сonn_limit is too high`


## Описание проблемы {#issue-description}

При подключении к Managed Service for PostgreSQL возникает ошибка `max_connections сonn_limit is too high`.

## Решение {#issue-resolution}

По умолчанию Managed Service for PostgreSQL выставляет максимально возможное ограничение на количество подключений к каждому хосту PostgreSQL-кластера. Этот максимум рассчитывается так: `200 × <количество vCPU на каждом хосте>`. Для кластера класса `s1.micro` значение параметра `max_connections` по умолчанию равно 400 и не может быть увеличено. Если требуется больше соединений, то необходимо повысить класс кластера.

{% note info %}

Managed Service for PostgreSQL резервирует 15 подключений для служебных пользователей на каждом PostgreSQL-хосте. 

Например, если для кластера выставлен параметр `max_connections`, равный 100, вы можете зарезервировать не более 85 подключений для пользователей кластера.

{% endnote %}