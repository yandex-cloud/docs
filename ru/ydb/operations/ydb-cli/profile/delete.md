---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Удаление профиля

{% include [profile-list](../../../_includes/profile-list.md) %}

Удалите профиль `example`:

```bash
ydb config profile delete example
```

Результат выполнения:

```text
Profile "example" will be permanently removed. Continue? (y/n): 
```

Подтвердите удаление. Результат выполнения:

```text
Profile "example" was removed.
```
