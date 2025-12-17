---
title: Как настроить парольную политику в пуле пользователей {{ org-full-name }}
description: Следуя данной инструкции, вы сможете настроить парольную политику в пуле пользователей {{ org-name }}.
---

# Настроить парольную политику


{% include [note-preview](../../../_includes/note-preview.md) %}

Чтобы настроить [парольную политику](../../concepts/password-policy.md):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный пул пользователей.
  1. Нажмите **{{ ui-key.yacloud_org.organization.userpools.title_password_policy }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите ![gear](../../../_assets/console-icons/gear.svg) **{{ ui-key.yacloud_org.organization.userpools.UserpoolOverviewPage.action_set_password_policy_aaDns }}**.
  1. В блоке **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.complexity_oeJs5 }}** укажите настройки классов символов в пароле:

     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.symbol_classes_any_fqb6f }}** — настройте минимальную длину в зависимости от количества классов символов, которые используются в пароле:
 
       * 1 класс (`abc`);
       * 2 класса (`aBc`);
       * 3 класса (`aBc1`);
       * 4 класса (`aB#c1`).
       
       Это предпочтительный вариант, поскольку не требует наличия определенных символов и позволяет пользователям делать более простые для запоминания, но надежные пароли.
 
     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.symbol_classes_required_1BHUu }}** — выберите типы символов, которые должны использоваться в пароле, активируя следующие опции:

       * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.option_lowers_75kTr }}**;
       * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.option_uppers_ur5iy }}**;
       * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.option_digits_ssY6G }}**;
       * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.option_specials_6GSqK }}**.

       В поле **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.min_length_title_mvmiQ }}** задайте минимальное число символов в пароле, но не менее 7.
       
  1. В блоке **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.lifetime_hnEhW }}** задайте минимальный и максимальный срок жизни пароля (до 730 дней) или выберите **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.unlimited_cSfYU }}**.
  1. В блоке **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.brute_force_protection_msHno }}** задайте:
     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.attempts_before_lockout_ay7Le }}** — от 1 до 100.
     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.failed_attempts_interval_wfd7Z }}** в минутах или секундах.
     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.lockout_duration_t1CZB }}** в минутах или секундах.

{% endlist %}