{% note warning %}

{{ mpg-short-name }} резервирует 15 подключений для служебных пользователей на каждом {{ PG }}-хосте. Например, если для кластера выставлено значение настройки [Max connections](../../managed-postgresql/concepts/settings-list.md#setting-max-connections) `100`, то вы можете зарезервировать не больше 85 подключений для пользователей кластера.

{% endnote %}
