---
title: Как получить IAM-токен для аккаунта
description: Следуя данной инструкции, вы сможете получить IAM-токен для аккаунта.
---

{% note info %}

Данные способы получения [IAM-токена](../../concepts/authorization/iam-token.md) предназначены для выполнения запросов от имени пользовательского [аккаунта на Яндексе](../../concepts/users/accounts.md#passport) и не рекомендуются для автоматизированных решений. Если вы хотите автоматизировать работу с API {{ yandex-cloud }} и получать IAM-токены программно, ознакомьтесь с разделом [{#T}](create-for-sa.md).

{% endnote %}

# Получение IAM-токена для аккаунта на Яндексе

IAM-токен для аккаунта на Яндексе можно получить двумя способами:

* [С помощью CLI](#via-cli) (рекомендуется) — наиболее безопасный способ. Для получения IAM-токена необходимо установить [YC CLI](../../../cli/).
* [С помощью OAuth-токена](#exchange-token) — наиболее простой способ. Получите [OAuth-токен](../../concepts/authorization/oauth-token.md), который есть у каждого аккаунта на Яндексе, и обменяйте его на IAM-токен, используя любой удобный HTTP-клиент, например cURL или PowerShell.

{% note info %}

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% endnote %}


## Получить IAM-токен с помощью YC CLI {#via-cli}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. [Аутентифицируйтесь в CLI от имени пользователя](../../../cli/operations/authentication/user.md).
  1. Получите IAM-токен:

      ```bash
      yc iam create-token
      ```

      Результат:

      ```text
      t1.9euelZrLop7Uz8up********
      ```

      Полученное значение — это IAM-токен. Вы можете скопировать и сохранить его в файле или записать в переменную:

      ```bash
      export IAM_TOKEN=`<IAM-токен>`
      ```

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}


### Пример использования IAM-токена, полученного с помощью CLI {#use-cli}

{% include [token-examples](../../../_includes/iam/iam-token-usage-examples.md) %}


## Получить и обменять OAuth-токен на IAM-токен {#exchange-token}

{% include [owner-warning](../../../_includes/iam/owner-warning.md) %}

{% include [create-iam-token-api-steps](../../../_includes/iam/create-iam-token-api-steps.md) %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}


#### См. также {#see-also}

* [Использовать IAM-токен в Helm-чарте](../../../container-registry/operations/helm-chart/helm-chart-push.md)
* [Отозвать IAM-токен](./revoke-iam-token.md)