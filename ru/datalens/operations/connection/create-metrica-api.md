---
title: Как создать подключение к Metrica в {{ datalens-full-name }}
description: Следуя данной инструкции, вы сможете создать подключение к Metrica.
---

# Создание подключения к Metrica


{% include [datalens-metrica-pro-note](../../../_includes/datalens/datalens-metrica-pro-note.md) %}


Чтобы создать подключение к Metrica:

1. Перейдите на [страницу создания нового подключения]({{ link-datalens-main }}/connections/new).
1. В разделе **Файлы и сервисы** выберите подключение **Metrica**.
1. Укажите параметры подключения:

   * **OAuth-токен**. Нажмите кнопку **Получить токен** или укажите вручную [OAuth-токен](#get-oauth-token) для доступа к данным Яндекс Метрики.
   * **Счетчик**. Укажите один или несколько счетчиков для подключения.
    
     {% include [datalens-get-token](../../../_includes/datalens/datalens-change-account-note.md) %}

   * **Точность**. Задайте точность данных (сэмплирование). Вы можете изменить точность после создания подключения.
   * Оставьте опцию **Автоматически создать дашборд, чарты и датасет над подключением** включенной, если хотите получить каталог со стандартным набором датасетов, чартов и готовый дашборд.

1. Нажмите кнопку **Создать подключение**.


1. Выберите [воркбук](../../workbooks-collections/index.md), в котором сохранится подключение, или создайте новый. Если вы пользуетесь старой навигацией по папкам, выберите папку для сохранения подключения. Нажмите кнопку **Создать**.


1. Укажите название подключения и нажмите кнопку **Создать**.

{% include [datalens-metrica-note](../../../_includes/datalens/datalens-metrica-note.md) %}


Подключение к Metrica API не поддерживает [публичный доступ](../../concepts/datalens-public.md) к объектам, созданным на его основе. Чтобы поделиться дашбордом или чартом, созданным на основе данного подключения, воспользуйтесь одним из способов:

{% include [datalens-metrica-appmetrica-share](../../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}


{% include [datalens-get-token](../../../_includes/datalens/operations/datalens-get-token.md) %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
