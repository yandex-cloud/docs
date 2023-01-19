# Управление доступом на уровне строк данных (RLS)

RLS (_Row-level security_ — безопасность на уровне строк) позволяет ограничить доступ к данным для пользователей в рамках одного датасета. Например, вы можете разграничить доступ разным клиентам.

{% include [rls-note](../../_includes/datalens/datalens-rls-note.md) %}

Разграничить доступ к данным на уровне строк можно как в [датасете](#dataset-rls), так и в [источнике данных](#datasource-rls).

## Настройка RLS на уровне датасета {#dataset-rls}

Вы можете разграничить доступ к любому измерению датасета. Каждому пользователю могут быть выданы права на неограниченное количество значений измерений.

Разграничение определяется конфигурацией доступа, которая выглядит следующим образом:

```yaml
'значение_1': пользователь_1, пользователь_2
'значение_2': пользователь_3
'значение_3': пользователь_1, пользователь_2, пользователь_3
```

Например, чтобы настроить доступ пользователя к значению `first-company` поля `Company name`, задайте конфигурацию:

{% if audience == "internal" %}

```yaml
'first-company': login-to-access-your-row-data
```

{% else %}

```yaml
'first-company': login-to-access-your-row-data@yandex.ru
```

{% endif %}

Чтобы настроить доступ для нескольких пользователей, перечислите через запятую их аккаунты в конфигурации доступа:

{% if audience == "internal" %}

```yaml
'first-company': login1-to-access-your-row-data, login2-to-access-your-row-data, login3-to-access-your-row-data
```

{% else %}

```yaml
'first-company': login1-to-access-your-row-data@yandex.ru, login2-to-access-your-row-data@yandex.ru, login3-to-access-your-row-data@yandex.ru
```

{% endif %}

Значения и пользователей можно определять символом подстановки:

* Пользователям `пользователь_1` и `пользователь_2` доступны все значения поля

  ```yaml
  *: пользователь_1, пользователь_2
  ```

  Например, чтобы настроить доступ для пользователей ко всем значениям поля `Company name`, задайте конфигурацию:

{% if audience == "internal" %}

  ```yaml
  *: login1-to-access-your-row-data, login2-to-access-your-row-data
  ```

{% else %}

  ```yaml
  *: login1-to-access-your-row-data@yandex.ru, login2-to-access-your-row-data@yandex.ru
  ```

{% endif %}

* Значение `значение_1` доступно всем пользователям

  ```yaml
  'значение_1': *
  ```

  Например, чтобы разрешить доступ для всех пользователей к значению `first-company` поля `Company name`, задайте конфигурацию:

  ```yaml
  'first-company': *
  ```

Кавычки в значении задаются удвоением:

```yaml
'значение в ''кавычках''': пользователь_1, пользователь_2
```

Например, чтобы установить кавычки для названия компании `first-company "Example"` поля `Company name`, задайте конфигурацию:

{% if audience == "internal" %}

```yaml
'first-company ''Example''': login1-to-access-your-row-data, login2-to-access-your-row-data
```

{% else %}

```yaml
'first-company ''Example''': login1-to-access-your-row-data@yandex.ru, login2-to-access-your-row-data@yandex.ru
```

{% endif %}

Также можно использовать символ `"`: 

{% if audience == "internal" %}

```yaml
'first-company "Example"': login1-to-access-your-row-data, login2-to-access-your-row-data
```

{% else %}

```yaml
'first-company "Example"': login1-to-access-your-row-data@yandex.ru, login2-to-access-your-row-data@yandex.ru
```

{% endif %}

При использовании RLS запросы к датасету проходят через следующий фильтр:

```sql
where измерение in (значение_1, значение_2 ... значение_N)
```

## Настройка RLS на уровне источника данных {#datasource-rls}

Настройка RLS на уровне датасета предполагает его редактирование при каждом изменении настроек RLS. 

Чтобы избежать этого, можно перенести логику разграничения прав доступа на уровне строк на сторону источника данных:

1. В исходные данные добавьте новое поле для хранения id пользователя. По этому полю будет происходить фильтрация всех запросов в источник.
   
   {% if audience != "internal" %}

   Свой id можно посмотреть [по ссылке]({{ link-console-access-management }}). Если вам нужен id другого пользователя, попросите его открыть эту ссылку и передать id вам.

   {% else %}
   
   * Свой id можно посмотреть [по ссылке]{% if region == "int" %}(https://console.cloud.yandex.com/iam){% else %}(https://console.cloud.yandex.ru/iam){% endif%}. Если вам нужен id другого пользователя, попросите его открыть эту ссылку и передать id вам.

   * Пользователи [datalens.yandex-team.ru](https://datalens.yandex-team.ru/) могут посмотреть свой id с помощью [API](https://staff-api.yandex-team.ru/v3/persons?_doc=1). В параметре `login` укажите логины пользователей через запятую, например `https://staff-api.yandex-team.ru/v3/persons?_fields=login,uid&login=user1,user2`.

   {% endif %}

1. Для каждой строки исходных данных укажите id пользователя, которому должна быть доступна данная строка. Если к одной строке должен быть доступ для нескольких пользователей, то логику разграничения можно вынести в отдельную таблицу и [объединить](../concepts/dataset/settings.md#multi-table) ее с основной таблицей на уровне датасета.

1. В датасете в поле с id в настройках RLS введите `userid:userid`. Переменную `userid` можно использовать в сочетании с обычным типом RLS в датасете:

   ```yaml
   'значение_1': пользователь_1, пользователь_2
   'значение_2': пользователь_3
      userid:userid
   ```

{% note info %}

Перенос логики RLS на сторону источника возможен для источников, в которых доступно изменение структуры данных. В Metrica и AppMetrica структура данных закрыта, поэтому этот способ неприменим.

{% endnote %}

## Как изменить права доступа к строке в датасете {#how-to-manage-rls}

Чтобы настроить права доступа к значению строки данных:

{% include [datalens-manage-rls](../../_includes/datalens/operations/datalens-manage-rls.md) %}

