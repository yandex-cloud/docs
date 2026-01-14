---
title: Добавить выполнение SQL-запросов к базам данным в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить выполнение SQL-запросов к базам данных в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Выполнение SQL-запросов к базам данных

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **Интеграционные шаги** в левой части экрана перетащите элемент ![database-magnifier](../../../../_assets/console-icons/database-magnifier.svg) **Database Query** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Database Query**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В блоке **Параметры подключения** выберите:

          * `Подключение`, чтобы создать подключение к базе данных.

              1. Укажите в поле:

                  * **Тип базы данных** — тип базы данных, к которой нужно подключиться.

                      Для базы данных {{ MY }} устанавливается кодировка `utf8mb4` для значений полей.

                  * **Хост** — адрес сервера базы данных.
                  * **Порт** — порт для подключения к базе данных.
                  * **База данных** — имя базы данных.

              1. Выберите **Использовать SSL**, чтобы подключаться к базе данных, используя SSL-соединение.

                  Если опция выбрана, для базы данных:
                  * {{ PG }} включается шифрование SSL. 
                  * {{ CH }} разрешаются защищенные SSL-соединения.

              1. В блоке **Аутентификация** выберите:

                  * `Пароль`, чтобы подключаться к базе данных, используя имя пользователя и пароль. Укажите имя пользователя и выберите:

                      * `Lockbox`, чтобы хранить пароль в секрете {{ lockbox-full-name }}, и в блоке **Cекрет** выберите секрет, его [версию](../../../../lockbox/concepts/secret.md#version) и ключ, в которых сохранен пароль.

                          Если у вас еще нет секрета {{ lockbox-name }}, нажмите кнопку **Создать**, чтобы создать его.

                      * `Текст`, чтобы хранить пароль в спецификации в виде текста, и в поле **Значение** введите пароль.

                          {% note warning %}

                          Хранить пароль в открытом виде в тексте спецификации небезопасно.

                          {% endnote %}

                  * `IAM-токен`, чтобы подключаться к базе данных, используя IAM-токен сервисного аккаунта, указанного в настройках рабочего процесса.

                      {% note info %}

                      Аутентификация по IAM-токену доступна только для базы данных {{ ydb-short-name }}.

                      {% endnote %}

          * `DSN`, чтобы указать строку подключения к базе данных.

      1. В поле **SQL-запрос** укажите SQL-запрос, который нужно выполнить.
      1. В поле **Метод выполнения** выберите:

          * `Exec`, чтобы выполнить SQL-запрос и вернуть только служебные поля, например `RowsAffected` и `LastInsertId`.
          * `Query`, чтобы выполнить SQL-запрос и вернуть результат.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/databasequery.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
