---
sourcePath: ru/ydb/ydb-docs-core/ru/core/reference/ydb-sdk/recipes/balancing/_includes/random_choice.md
---
# Равномерный случайный выбор

{% include [work in progress message](../../_includes/addition.md) %}

{{ ydb-short-name }} SDK использует алгоритм `random_choice` (равномерную случайную балансировку) по умолчанию.

Ниже приведены примеры кода принудительной установки алгоритма балансировки "равномерный случайный выбор" в разных {{ ydb-short-name }} SDK.

{% list tabs %}

- Go


  {% include [go.md](random_choice/go.md) %}


{% endlist %}
