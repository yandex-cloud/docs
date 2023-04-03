Пример содержимого файла с правилами, где:
* `description` — описание правила политики.
* `tag_regexp` — тег Docker-образа для фильтрации. Поддерживаются регулярные выражения языка Java. Например, выражение `test.*` позволяет получить все образы с тегами, начинающимися на `test`.
* `untagged` — флаг для применения правила к Docker-образам без тегов.
* `expire_period` — время, через которое Docker-образ может попадать под политику удаления. Формат параметра — число и единица измерения `s`, `m`, `h` или `d` (секунды, минуты, часы или дни). `expire_period` должен быть кратен 24 часам.
* `retained_top` — количество Docker-образов, которые не будут удалены, даже если подходят по правилу.

```json
[
  {
    "description": "delete prod Docker images older than 60 days but retain 20 last ones",
    "tag_regexp": "prod",
    "expire_period": "60d",
    "retained_top": 20
  },
  {
    "description": "delete all test Docker images except 10 last ones",
    "tag_regexp": "test.*",
    "retained_top": 10
  },
  {
    "description": "delete all untagged Docker images older than 48 hours",
    "untagged": true,
    "expire_period": "48h"
  }
]
```