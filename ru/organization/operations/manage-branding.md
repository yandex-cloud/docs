---
title: Как настроить брендирование {{ org-full-name }}
description: Следуя данной инструкции, вы сможете настроить внешний вид страниц аутентификации и форму входа во внешние приложения из {{ org-full-name }}.
---

# Настроить брендирование



{% include [note-preview](../../_includes/note-preview.md) %}

## Настроить графическое оформление страницы входа {#appearance}

Чтобы настроить [графическое оформление](../concepts/branding.md#appearance) страницы входа:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![brush](../../_assets/console-icons/brush.svg) **{{ ui-key.yacloud_org.pages.organization-branding }}**.
  1. В блоке **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.styleSection.title }}** настройте по отдельности темную и светлую цветовые темы:

      {% note info %}

      Встроенный редактор позволяет подготовить логотип или фавиконку к загрузке: обрезать лишний фон, изменить масштаб и выстроить композицию. Поддерживаются изображения в форматах `WebP`, `PNG`, `JPEG` и `JPG`.

      {% endnote %}

      1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingThemeBlock.backgroundName }}** — выберите изображение, которое будет использоваться в качестве фона страницы (до 3840×2160 px, до 4 МБ).
      1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingThemeBlock.logoName }}** — выберите изображение, которое будет отображаться в верхней части формы (от 1920×1920 px, до 512 КБ).
      1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingThemeBlock.faviconName }}** — выберите изображение, которое будет отображаться во вкладке браузера рядом с названием сайта (до 512×512 px, до 512 КБ).
      1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.styleSection.colorLabel }}** — выберите цвет кнопок и рамок для текстовых полей.
  1. Чтобы сохранить изменения, нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Настроить способы входа {#login-options}

Чтобы настроить [способы входа](../concepts/branding.md#login-options) пользователей:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![brush](../../_assets/console-icons/brush.svg) **{{ ui-key.yacloud_org.pages.organization-branding }}**.
  1. Чтобы включить автоматическое перенаправление пользователей для входа через [федерацию удостоверений](../concepts/add-federation.md):

      1. В блоке **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.autoLoginSection.title }}** включите опцию **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.autoLoginSection.redirectLabel }}**.
      1. В появившемся поле **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.autoLoginSection.federationFieldLabel }}** выберите федерацию удостоверений, через которую будет выполняться автоматический вход пользователей в приложения.

      {% note info %}

      Если включена опция **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.autoLoginSection.redirectLabel }}**, другие настройки входа пользователей в разделе **{{ ui-key.yacloud_org.pages.organization-branding }}** становятся недоступны, а пользователям не предлагается выбор способов входа.

      {% endnote %}

  1. Чтобы настроить способы входа, которые будут доступны пользователям в форме входа:

      1. Убедитесь, что опция **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.autoLoginSection.redirectLabel }}** в блоке **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.autoLoginSection.title }}** отключена.
      1. В блоке **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.title }}**:

          1. В поле **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.welcomeLabel }}** введите текст, который будет отображаться под логотипом.
          1. В поле **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.placeholderInlineLabel }}** введите текст подсказки, которая будет отображаться в поле ввода логина.

              {% note info %}

              По умолчанию поле ввода логина отображается в форме входа. Чтобы скрыть его, отключите опцию **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.loginInputLabel }}**.

              {% endnote %}

          1. Чтобы отключить возможность входа пользователей через Яндекс ID, отключите опцию **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.yandexIdLabel }}**.

              По умолчанию возможность входа через Яндекс ID включена.
          1. Чтобы отключить возможность входа пользователей через [SSO](../../glossary/sso.md), отключите опцию **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.ssoLabel }}**.

              По умолчанию возможность входа через SSO включена.
          1. Чтобы добавить в форму дополнительные кнопки входа через федерации удостоверений, включите опцию **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.federationLabel }}** и укажите:

              1. В поле **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.federationLoginSection.federationFieldLabel }}** выберите федерацию удостоверений, для входа через которую вы добавляете кнопку.
              1. В поле **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.federationLoginSection.buttonTextFieldLabel }}** введите текст кнопки.
              1. Чтобы добавить дополнительную кнопку для входа через еще одну федерацию удостоверений, нажмите кнопку **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.federationLoginSection.addButton }}** и укажите данные для новой кнопки.

                  На страницу входа вы можете добавить до трех кнопок входа через федерации удостоверений.
  1. Чтобы сохранить изменения, нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

{% note tip %}

Чтобы сбросить внесенные изменения и настроить брендирование заново, нажмите кнопку ![broom-motion](../../_assets/console-icons/broom-motion.svg) **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.clearAllAction }}**, затем кнопку **{{ ui-key.yacloud.common.save }}**. При этом будут сброшены как настройки графического оформления, так и параметры входа.

{% endnote %}