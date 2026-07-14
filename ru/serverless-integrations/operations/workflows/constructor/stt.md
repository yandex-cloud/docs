---
title: Добавить распознавание речи в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить распознавание речи в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Распознавание речи

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ai-studio-name }}** в левой части экрана перетащите элемент **Распознавание речи** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Распознавание речи**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **Формат аудио** выберите формат файла с аудио для распознавания.
      1. В поле **Языки** выберите языки для распознавания речи.
      1. В поле **Модель** выберите модель распознавания.
      1. В блоке **Источник** выберите:

          * `URL`, чтобы указать публичный URL, по которому доступен файл с аудио.
          * `{{ objstorage-name }}`, чтобы указать [бакет](../../../../storage/concepts/bucket.md) {{ objstorage-name }}, в котором находится файл с аудио, и имя объекта с файлом, например `prefix/subprefix/data.mp3`.
          * `Яндекс Диск`, чтобы указать путь к файлу с аудио на Яндекс Диске и (опционально) [метку]({{ link-yadisk-doc }}reference/content_shd#query) общего диска.

              Для аутентификации на Яндекс Диске в секции **OAuth-токен** укажите [OAuth-токен приложения]({{ link-yadisk-doc }}concepts/quickstart#oauth) или [секрет](../../../../lockbox/concepts/secret.md) {{ lockbox-full-name }}, в котором сохранен этот токен. Выберите:

              * `Lockbox`, чтобы хранить OAuth-токен в секрете, и в блоке **Секрет** выберите секрет, его [версию](../../../../lockbox/concepts/secret.md#version) и ключ, в которых сохранен OAuth-токен.

                  Если у вас еще нет секрета {{ lockbox-name }}, нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать его.
                
              * `Текст`, чтобы хранить OAuth-токен в спецификации в виде текста, и в поле **Значение** введите OAuth-токен.

                  {% note warning %}

                  Хранить OAuth-токен в открытом виде в тексте спецификации небезопасно.

                  {% endnote %}

          * `Base64`, чтобы указать файл с аудио в кодировке Base64.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## Полезные ссылки {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/stt.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
