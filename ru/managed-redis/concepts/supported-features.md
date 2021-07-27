---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Ограничения {{ mrd-name }}

{{ mrd-name }} позволяет выполнять [любые команды Redis](https://redis.io/commands), кроме следующих:

- `BGREWRITEAOF`
- `BGSAVE`
- `COMMAND`
- `CONFIG`
- `DEBUG`
- `LASTSAVE`
- `MIGRATE`
- `MODULE`
- `MONITOR`
- `MOVE`
- `OBJECT`
- `REPLICAOF`
- `SAVE`
- `SHUTDOWN`
- `SLAVEOF`
