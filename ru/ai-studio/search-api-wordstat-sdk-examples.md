---
title: Примеры работы с API Wordstat через {{ ai-studio-name }} SDK
description: Примеры кода на Python для методов API Wordstat с использованием {{ ai-studio-name }} SDK.
---

# Примеры работы с API Wordstat через {{ ai-studio-name }} SDK

Страницы с примерами для API Wordstat сейчас содержат только запросы через cURL, тогда как для веб-поиска есть примеры на Python с {{ ai-studio-name }} SDK. Ниже примеры для всех четырех методов Wordstat в том же стиле, что и примеры для веб-поиска. Каждый раздел предлагается добавить на соответствующую страницу вкладкой **AI SDK**.

Чтобы воспользоваться примерами, вам понадобится идентификатор каталога, сервисный аккаунт с ролью `search-api.webSearch.user` и API-ключ с областью действия `yc.search-api.execute`. Установите SDK:

```bash
pip install yandex-ai-studio-sdk
```

Примеры проверены на версии SDK 0.22.1.

## Получить популярные запросы (topRequests) {#wordstat-gettop}

Страница: `search-api/operations/wordstat-gettop`.

Метод `get_top` возвращает популярные запросы, которые содержат фразу, с числом показов за последние 30 дней, и похожие запросы.

```python
#!/usr/bin/env python3

from __future__ import annotations

from yandex_ai_studio_sdk import AIStudio


def main() -> None:
    sdk = AIStudio(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )
    sdk.setup_default_logging()

    wordstat = sdk.search_api.wordstat()

    phrase = input("Введите фразу: ").strip() or "купить велосипед"

    # Популярные запросы, которые содержат фразу, и число показов в месяц.
    # Можно ограничить выборку регионами и типами устройств:
    # regions=["213"], devices=["phone"]
    top = wordstat.get_top(phrase, num_phrases=20)

    print("Запросы, содержащие фразу:")
    for query, count in top.results.items():
        print(f"{count:>10}  {query}")

    print("\nПохожие запросы:")
    for query, count in top.associations.items():
        print(f"{count:>10}  {query}")


if __name__ == "__main__":
    main()
```

## Получить динамику запросов (dynamics) {#wordstat-getdynamics}

Страница: `search-api/operations/wordstat-getdynamics`.

Метод `get_dynamics` возвращает число запросов с фразой и их долю от всех запросов по дням, неделям или месяцам.

```python
#!/usr/bin/env python3

from __future__ import annotations

import datetime

from yandex_ai_studio_sdk import AIStudio


def main() -> None:
    sdk = AIStudio(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )
    sdk.setup_default_logging()

    wordstat = sdk.search_api.wordstat()

    phrase = input("Введите фразу: ").strip() or "купить велосипед"

    # Период: "daily", "weekly" или "monthly".
    # Для помесячной динамики даты должны приходиться на начало и конец месяца.
    dynamics = wordstat.get_dynamics(
        phrase,
        period="monthly",
        from_date=datetime.date(2026, 1, 1),
        to_date=datetime.date(2026, 6, 30),
    )

    # share — доля запросов с фразой от всех запросов за период
    for item in dynamics:
        print(f"{item.date:%Y-%m}  {item.count:>10}  {item.share:.8f}")


if __name__ == "__main__":
    main()
```

## Получить распределение запросов по регионам (regions) {#wordstat-getregionsdistribution}

Страница: `search-api/operations/wordstat-getregionsdistribution`.

Метод `get_regions_distribution` возвращает число запросов с фразой по регионам или городам и индекс региональной популярности.

```python
#!/usr/bin/env python3

from __future__ import annotations

from yandex_ai_studio_sdk import AIStudio


def main() -> None:
    sdk = AIStudio(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )
    sdk.setup_default_logging()

    wordstat = sdk.search_api.wordstat()

    phrase = input("Введите фразу: ").strip() or "купить велосипед"

    # resolve_regions=True подставляет вместо идентификаторов регионов их названия.
    # distribution_type="cities" вернет распределение по городам вместо регионов.
    distribution = wordstat.get_regions_distribution(phrase, resolve_regions=True)

    # affinity_index — региональная популярность: больше 100 значит,
    # что в регионе фразу ищут чаще, чем в среднем по стране
    rows = sorted(distribution, key=lambda item: item.count, reverse=True)
    for item in rows[:15]:
        print(f"{item.count:>10}  {item.affinity_index:>7.1f}  {item.region.label}")


if __name__ == "__main__":
    main()
```

## Получить дерево регионов (getRegionsTree) {#wordstat-getregiontree}

Страница: `search-api/operations/wordstat-getregiontree`.

Метод `get_regions_tree` возвращает дерево регионов, которые поддерживает Wordstat. По нему удобно искать идентификатор региона для других методов.

```python
#!/usr/bin/env python3

from __future__ import annotations

from yandex_ai_studio_sdk import AIStudio


def main() -> None:
    sdk = AIStudio(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )
    sdk.setup_default_logging()

    wordstat = sdk.search_api.wordstat()

    # Дерево регионов, которые поддерживает Wordstat
    tree = wordstat.get_regions_tree()

    # Поиск идентификатора региона по названию, чтобы передать его
    # в параметр regions методов get_top и get_dynamics
    name = input("Введите название региона: ").strip() or "Казань"
    for region in tree.search_by_label(name):
        print(region.id, region.label)


if __name__ == "__main__":
    main()
```
