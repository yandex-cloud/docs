---
title: Как настроить брендирование {{ org-full-name }}
description: Следуя данной инструкции, вы сможете настроить внешний вид страниц аутентификации и форму входа во внешние приложения из {{ org-name }}.
---

# Настроить брендирование


{% include [note-preview](../../_includes/note-preview.md) %}

Чтобы настроить [брендирование](../concepts/branding.md):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![brush](../../_assets/console-icons/brush.svg) **{{ ui-key.yacloud_org.pages.organization-branding }}**.
  1. В блоке **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.styleSection.title }}** настройте по отдельности темную и светлую цветовые темы:

     1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingThemeBlock.backgroundName }}** — выберите изображение, которое будет использоваться в качестве фона страницы (до 3840×2160 px, до 4 МБ).
     1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingThemeBlock.logoName }}** — выберите изображение, которое будет отображаться в верхней части формы (от 1920×1920 px, до 512 КБ).
     1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingThemeBlock.faviconName }}** — выберите изображение, которое будет отображаться во вкладке браузера рядом с названием сайта (до 512×512 px, до 512 КБ).
     1. **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.styleSection.colorLabel }}** — выберите цвет кнопок и рамок для текстовых полей.

     {% note tip %}
     
     Поддерживаются следующие форматы изображений: WebP, PNG, JPEG, JPG.
     
     {% endnote %}

  1. В блоке **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.title }}**:

     1. В поле **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.welcomeLabel }}** введите текст, который будет отображаться под логотипом.
     1. В поле **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.placeholderLabel }}** введите шаблон почты, который будет отображаться в поле ввода.
     1. В секции **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.loginSection.alternativeEntryLabel }}** включите или выключите вход с помощью Яндекс ID и [SSO](../../glossary/sso.md).

  1. Чтобы сбросить внесенные изменения и настроить брендирование заново, нажмите **{{ ui-key.yacloud_org.organization.branding.AuthBrandingForm.clearAllAction }}**.
  1. Чтобы сохранить изменения, нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}