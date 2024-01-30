---
title: "Как создать подключение к {{ monitoring-name }}"
description: "Следуя данной инструкции, вы сможете создать подключение к {{ monitoring-name }}."
---

# Создание подключения к {{ monitoring-name }}

{% note info %}

* Для создания подключения требуется [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с [ролью](../../../iam/operations/sa/assign-role-for-sa.md) `{{ roles-monitoring-viewer }}` (или `{{ roles-viewer }}`).
* Для написания запросов в QL-чартах используйте [язык запросов Yandex Monitoring](../../../monitoring/concepts/querying.md).
* При написании запросов не используйте [метку](../../../monitoring/concepts/data-model.md#label) `folderId`.

{% endnote %}

Чтобы создать подключение к {{ monitoring-name }}:


{% include [datalens-workbooks-collections-note](../../../_includes/datalens/operations/datalens-workbooks-collections-note.md) %}


1. Перейдите на [страницу подключений]({{ link-datalens-main }}/connections).
1. Нажмите кнопку **Создать подключение**.
1. Выберите подключение **Мониторинг**.
1. Укажите параметры подключения:

   * **Облако и каталог**. Выберите каталог, в котором находится ваш сервисный аккаунт.
   * **Сервисный аккаунт**. Выберите существующий сервисный аккаунт или создайте новый.
   
1. Нажмите **Создать подключение**.
1. Укажите имя подключения и нажмите **Создать**. Подключение появится в списке.
