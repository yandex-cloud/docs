---
title: AI-агенты в {{ datalens-full-name }}
description: Из этой статьи вы узнаете, как AI-агенты взаимодействуют с {{ datalens-name }}.
alternate:
  - href: ru/datalens/concepts/ai-agents.md
    type: text/markdown
    title: Markdown version
---

# AI-агенты в {{ datalens-full-name }}

Вы можете использовать AI-агентов для автоматизации работы и редактирования объектов в {{ datalens-name }}. Например, [Claude Code](https://claude.com/claude-code), [Codex](https://developers.openai.com/codex), [OpenCode](https://opencode.ai) и другие.


## Навыки для работы с {{ datalens-name }} {#skills}

Навыки (Agent Skills) — инструкции и справочные материалы, которые помогают AI-агенту работать с конкретным инструментом. Официальные навыки {{ datalens-name }} находятся в репозитории [datalens-tech/datalens-skills](https://github.com/datalens-tech/datalens-skills). Они используют открытый стандарт [Agent Skills](https://agentskills.io) и доступны для совместимых агентов.

{% note info %}

Навыки Agent Skills предназначены для внешних AI-агентов. О навыках, которые настраивают Нейроаналитика внутри {{ datalens-name }}, читайте в разделе [{#T}](./neuroanalyst-skills.md).

{% endnote %}

Корневой навык [`datalens`](https://github.com/datalens-tech/datalens-skills/blob/main/skills/datalens/SKILL.md) знакомит агента с объектами {{ datalens-name }}, их связями и вариантами развертывания сервиса. На основе этих знаний агент выбирает подходящий инструмент и специализированный навык для задачи.

Специализированные навыки содержат инструкции для отдельных задач:

| Навык | Назначение |
| --- | --- |
| [`datalens-sdk`](https://github.com/datalens-tech/datalens-skills/blob/main/skills/datalens-sdk/SKILL.md) | Автоматизация через Python SDK: работа с подключениями, датасетами, чартами и дашбордами. |
| [`datalens-html-pages`](https://github.com/datalens-tech/datalens-skills/blob/main/skills/datalens-html-pages/SKILL.md) | Подготовка, проверка и публикация HTML-страниц с учетом требований {{ datalens-name }}. |
| [`datalens-yc-rls-resolve`](https://github.com/datalens-tech/datalens-skills/blob/main/skills/datalens-yc-rls-resolve/SKILL.md) | Поиск идентификаторов пользователей и групп {{ yandex-cloud }} для настройки RLS и переноса правил из прежнего формата `rls`. |


## Инструменты доступа к {{ datalens-name }} {#tools}

Для выполнения операций с объектами {{ datalens-name }} агент может использовать MCP-сервер или Python SDK. Оба инструмента обращаются к [Public API {{ datalens-name }}](../operations/api-start.md).


### MCP-сервер {#mcp}

[`@datalens-tech/mcp`](https://github.com/datalens-tech/datalens-mcp) предоставляет агенту доступ к операциям {{ datalens-name }} по протоколу [Model Context Protocol](https://modelcontextprotocol.io). При запуске сервер получает OpenAPI-спецификацию и на ее основе формирует доступные команды.

Агент может узнать, какие команды доступны, получить описание их параметров и выполнить нужную операцию. Для этого сервер предоставляет небольшой набор инструментов, поэтому описания всех команд API не нужно одновременно помещать в контекст модели. Вызовы учитывают категорию операции и права доступа к объектам {{ datalens-name }}.

Актуальные способы подключения, требования к окружению, описание инструментов и параметры авторизации приведены в [README MCP-сервера](https://github.com/datalens-tech/datalens-mcp#readme).


### Python SDK {#sdk}

[`datalens-sdk`](https://pypi.org/project/datalens-sdk/) — библиотека Python для программной работы с {{ datalens-name }}. С ее помощью агент пишет код, который создает, изменяет, экспортирует или копирует объекты. Такой код можно сохранить и использовать повторно, например для переноса контента или регулярного обновления дашбордов.

Для работы с SDK предназначен навык [`datalens-sdk` из репозитория `datalens-skills`](https://github.com/datalens-tech/datalens-skills/blob/main/skills/datalens-sdk/SKILL.md). Следуя ему, агент подготавливает Python-окружение проекта и загружает подробные инструкции из установленного пакета SDK. Эти инструкции соответствуют используемой версии библиотеки и учитывают особенности окружения {{ datalens-name }}.


## Использование {{ datalens-name }} с AI-агентом {#usage}

### Подготовка окружения {#prepare}

Убедитесь, что у вас есть доступ к {{ yandex-cloud }} и нужным объектам {{ datalens-name }}. Для изменения объектов потребуются соответствующие права. Выберите воркбук для работы; если хотите построить чарт по существующему датасету, подготовьте ссылку на него или его идентификатор.

Современные агенты легко справятся с самостоятельной установкой навыка и настройкой доступа и подскажут, если что-то пошло не так.

Промпт может выглядеть следующим образом:

```text
Установи все навыки из https://github.com/datalens-tech/datalens-skills
и Python SDK DataLens.
Прочитай корневой навык и следуй его указаниям при работе с DataLens.
Настрой авторизацию в Yandex Cloud, при необходимости установи yc.
Проверь доступ к моему окружению DataLens.
Если подходящий доступ уже настроен, используй его.
```

Для доступа к Public API в {{ yandex-cloud }} используются [IAM-токен](../../iam/concepts/authorization/iam-token) и идентификатор организации. Агент может использовать настроенную авторизацию через [{{ yandex-cloud }} CLI](../../cli/quickstart.md) или другой поддерживаемый способ. Подробности настройки приведены в [разделе об авторизации MCP-сервера](https://github.com/datalens-tech/datalens-mcp#authorization) и [инструкциях навыка SDK](https://github.com/datalens-tech/datalens-skills/blob/main/skills/datalens-sdk/SKILL.md).


### Примеры задач {#examples}

Укажите желаемый результат и ссылки или идентификаторы объектов. В примерах ниже замените значения в угловых скобках на свои.


#### Проверка зависимостей {#dependency-check}

```text
Проверь зависимости датасета <идентификатор_датасета>.
Покажи связанные с ним чарты и дашборды со ссылками на объекты.
```


#### Создание чарта {#creating-chart}

```text
В воркбуке <идентификатор_воркбука> построй линейный чарт
на основе датасета <идентификатор_датасета>.
По горизонтали — месяцы, по вертикали — сумма продаж,
отдельная линия для каждого региона.
```


#### Копирование дашборда {#copying-dashboard}

```text
Создай копию дашборда <идентификатор_дашборда>
в воркбуке <идентификатор_воркбука>.
Перенеси также связанные чарты и датасеты,
проверь связи между скопированными объектами.
```


#### Создание дашборда с нуля {#dashboard-from-scratch}

```text
В воркбуке <идентификатор_воркбука> создай датасет
по таблице <имя_таблицы> из подключения <идентификатор_подключения>.
Добавь поле «Маржа» как разность выручки и себестоимости.
На его основе подготовь дашборд с динамикой продаж
и сравнением маржи по регионам.
```


#### Массовое изменение объектов {#bulk-change-objects}

```text
В датасетах воркбука <идентификатор_воркбука>
измени название поля revenue на «Выручка».
Перечисли обновленные датасеты.
```


#### Подготовка HTML-отчета {#preparing-html-report}

```text
Используй приложенные данные за квартал для HTML-отчета:
покажи динамику выручки и сравнение регионов.
Подготовь страницу для DataLens с помощью навыка datalens-html-pages
и опубликуй ее в воркбуке <идентификатор_воркбука>.
```


## Особенности и ограничения {#limitations}

* Возможность выполнить операцию зависит от прав учетной записи и доступных методов API. На обращения к API распространяются [квоты и лимиты {{ datalens-name }}](./limits.md).
* При авторизации через настроенный {{ yandex-cloud }} CLI MCP-сервер и SDK могут автоматически обновлять IAM-токен. При использовании статического токена нужно самостоятельно обеспечить его обновление.
* Навыки {{ datalens-name }} охватывают работу с объектами сервиса и подготовку [HTML-страниц](../html-pages/index.md). Управление веб-интерфейсом, создание скриншотов и интерпретация бизнес-смысла метрик не входят в их область применения.


## Полезные ссылки {#see-also}

* [{#T}](../operations/api-start.md)
* [Репозиторий навыков datalens-skills](https://github.com/datalens-tech/datalens-skills)
* [MCP-сервер @datalens-tech/mcp](https://github.com/datalens-tech/datalens-mcp)
* [Пакет @datalens-tech/mcp в npm](https://www.npmjs.com/package/@datalens-tech/mcp)
* [Python SDK datalens-sdk](https://pypi.org/project/datalens-sdk/)
* [Стандарт Agent Skills](https://agentskills.io)
* [Model Context Protocol](https://modelcontextprotocol.io)


