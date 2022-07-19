# Получение информации о профиле

Для обращения к профилю используйте его имя. Узнать имя профиля можно получив список профилей.

## Получить список профилей {#profile-list}

Для получения списка профилей выполните команду:

```
yc config profile list
prod ACTIVE
test
```

## Получить подробную информацию о профиле {#profile-get}

Для обращения к профилю используйте его имя из предыдущего пункта.

Получите подробную информацию о профиле с именем `prod`:

{% if product == "yandex-cloud" %}

```
yc config profile get prod
token: AQAAAAAV6O...
cloud-id: b1gvl...
folder-id: b1g88...
```

{% endif %}

{% if product == "cloud-il" %}

```
yc config profile get prod
cloud-id: b1gvl...
folder-id: b1g88...
```

{% endif %}
