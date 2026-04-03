---
title: How to set up a password policy in a {{ org-full-name }} user pool
description: Follow this guide to set up a password policy in a {{ org-full-name }} user pool.
---

# Setting up a password policy


To set up a [password policy](../../concepts/password-policy.md):

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the user pool.
  1. Click **{{ ui-key.yacloud_org.organization.userpools.title_password_policy }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select ![gear](../../../_assets/console-icons/gear.svg) **{{ ui-key.yacloud_org.organization.userpools.UserpoolOverviewPage.action_set_password_policy_aaDns }}**.
  1. Under **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.complexity_oeJs5 }}**, specify the character class settings for the password:

     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.symbol_classes_any_fqb6f }}**: Configure the minimum length depending on the number of character classes used in the password:
 
       * One class (`abc`)
       * Two classes (`aBc`)
       * Three classes (`aBc1`)
       * Four classes (`aB#c1`)
       
       This is the preferred option because it does not require particular characters and allows users to create more memorable yet strong passwords.
 
     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.symbol_classes_required_1BHUu }}**: Select the character types for the password by activating the following options:

       * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.option_lowers_75kTr }}**
       * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.option_uppers_ur5iy }}**
       * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.option_digits_ssY6G }}**
       * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.option_specials_6GSqK }}**

       In the **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.min_length_title_mvmiQ }}** field, specify the minimum number of characters in the password but not less than seven.
       
  1. Under **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.lifetime_hnEhW }}**, set the minimum and maximum password lifetime (up to 730 days) or select **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.unlimited_cSfYU }}**.
  1. Under **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.brute_force_protection_msHno }}**, specify:
     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.attempts_before_lockout_ay7Le }}**: From 1 to 100.
     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.failed_attempts_interval_wfd7Z }}** in minutes or seconds.
     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.lockout_duration_t1CZB }}** in minutes or seconds.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../../cli/) command for updating a user pool:

     ```bash
     yc organization-manager idp userpool update --help
     ```

  1. Getting a list of user pools in the organization:

     ```bash
     yc organization-manager idp userpool list \
       --organization-id <organization_ID>
     ```

  1. Set up a password policy for the user pool:

     ```bash
     yc organization-manager idp userpool update <pool_ID> \
       --password-smart-one-class <minimum_length_for_1_class> \
       --password-smart-two-classes <minimum_length_for_2_classes> \
       --password-smart-three-classes <minimum_length_for_3_classes> \
       --password-smart-four-classes <minimum_length_for_4_classes> \
       --password-allow-similar \
       --password-match-length <match_substring_length> \
       --password-max-length <maximum_password_length> \
       --password-min-days <minimum_lifetime_in_days> \
       --password-max-days <maximum_lifetime_in_days> \
       --bruteforce-attempts <number_of_attempts> \
       --bruteforce-window <count_interval> \
       --bruteforce-block <lockout_duration>
     ```

     Where:

     * To configure custom character types (smart policy):
       * `--password-smart-one-class`: Minimum password length if using one character class (e.g., lowercase letters only).
       * `--password-smart-two-classes`: Minimum password length if using two character classes (e.g., lowercase and uppercase letters).
       * `--password-smart-three-classes`: Minimum password length if using three character classes (e.g., letters and numbers).
       * `--password-smart-four-classes`: Minimum password length if using four character classes (letters, numbers, and special characters).

     * To configure required character types (fixed policy):
       * `--password-fixed-min-length`: Minimum password length (at least 7 characters).
       * `--password-fixed-lowers-required`: Require lowercase letters.
       * `--password-fixed-uppers-required`: Require uppercase letters.
       * `--password-fixed-digits-required`: Require numbers.
       * `--password-fixed-specials-required`: Require special characters.

     * `--password-allow-similar`: Allow passwords similar to those used earlier. If the flag is not specified, using similar passwords is forbidden.
     * `--password-match-length`: Minimum substring length for a similarity check with vulnerable sequences.
     * `--password-max-length`: Maximum password length. If `0`, there is no limit.
     * `--password-min-days`: Minimum number of days before the password should be changed.
     * `--password-max-days`: Maximum number of days the password remains valid (up to 730 days). If `0`, passwords do not expire.
     * `--bruteforce-attempts`: Number of wrong password entries before lockout (1 to 100).
     * `--bruteforce-window`: Interval for counting wrong entries (e.g., `10m` for 10 minutes or `600s` for 600 seconds).
     * `--bruteforce-block`: Lockout duration after exceeding the wrong entry limit (e.g., `10m` or `600s`).

     Example of a command for setting up a password policy:

     {% list tabs group=examples %}

     - With custom character types {#smart}

       ```bash
       yc organization-manager idp userpool update fpd9mu9gqq12******** \
         --password-smart-one-class 24 \
         --password-smart-two-classes 14 \
         --password-smart-three-classes 11 \
         --password-smart-four-classes 10 \
         --password-max-length 128 \
         --password-max-days 365 \
         --bruteforce-attempts 15 \
         --bruteforce-window 10m \
         --bruteforce-block 10m
       ```

     - With required character types {#fixed}

       ```bash
       yc organization-manager idp userpool update fpd9mu9gqq12******** \
         --password-fixed-min-length 8 \
         --password-fixed-lowers-required \
         --password-fixed-uppers-required \
         --password-fixed-digits-required \
         --password-max-length 128 \
         --password-max-days 365 \
         --bruteforce-attempts 15 \
         --bruteforce-window 10m \
         --bruteforce-block 10m
       ```
     {% endlist %}

  For more information about the `yc organization-manager idp userpool update` command, see the [CLI reference](../../cli-ref/idp/userpool/update.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  For more information about {{ TF }}, see [this guide](../../../tutorials/infrastructure-management/terraform-quickstart.md).

  1. Create a configuration file with the user pool and password policy settings:

     ```hcl
     resource "yandex_organizationmanager_idp_userpool" "my_userpool" {
       name              = "<pool_name>"
       organization_id   = "<organization_ID>"
       default_subdomain = "<subdomain>"
       description       = "<pool_description>"

       password_quality_policy = {
         allow_similar = true
         max_length    = 128
         match_length  = 4

         # Use either `smart` or `fixed`
         # Configuring custom character types
         smart = {
           one_class     = 24
           two_classes   = 14
           three_classes = 11
           four_classes  = 10
         }

         # Configuring required character types
         fixed = {
           min_length        = 8
           lowers_required   = true
           uppers_required   = true
           digits_required   = true
           specials_required = false
         }
       }

       password_lifetime_policy = {
         min_days_count = 0
         max_days_count = 365
       }

       bruteforce_protection_policy = {
         attempts = 15
         window   = "10m"
         block    = "10m"
       }
     }
     ```

     Where:

     * `name`: User pool name.
     * `organization_id`: Organization ID.
     * `default_subdomain`: Default subdomain for the pool.
     * `description`: User pool description.
     * `password_quality_policy`: Password complexity settings:

       * `allow_similar`: Allow passwords similar to those used earlier.
       * `max_length`: Maximum password length. If `0`, there is no limit.
       * `match_length`: Minimum substring length for a similarity check with vulnerable sequences.

       Use either `smart` or `fixed`.
       * `smart`: Configuring custom character types (minimum length depends on how many classes are used).
         * `one_class`: Minimum password length if using one character class (e.g., lowercase letters only).
         * `two_classes`: Minimum length of a password with two character classes (e.g., lowercase and uppercase letters).
         * `three_classes`: Minimum password length if using three character classes (e.g., letters and numbers).
         * `four_classes`: Minimum password length if using four character classes (letters, numbers, and special characters).

       * `fixed`: Configuring required character types (use instead of `smart`).
         * `min_length`: Minimum password length (at least 7 characters).
         * `lowers_required`: Require lowercase letters.
         * `uppers_required`: Require uppercase letters.
         * `digits_required`: Require numbers.
         * `specials_required`: Require special characters.

     * `password_lifetime_policy`: Password lifetime settings.
       * `min_days_count`: Minimum number of days before the password should be changed.
       * `max_days_count`: Maximum number of days the password remains valid (up to 730 days). If `0`, passwords do not expire.

     * `bruteforce_protection_policy`: Settings for protection against password guessing.
       * `attempts`: Number of wrong password entries before lockout (1 to 100).
       * `window`: Interval for counting wrong entries (e.g., `10m` for 10 minutes or `600s` for 600 seconds).
       * `block`: Lockout duration after exceeding the wrong entry limit (e.g., `10m` or `600s`).

     For more information about `yandex_organizationmanager_idp_userpool` properties, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_idp_userpool).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  This will create a user pool subject to your password policy in the specified organization. You can check the new pool and its settings using the [{{ cloud-center }} UI]({{ link-org-cloud-center }}) or this CLI command:

  ```bash
  yc organization-manager idp userpool get <pool_ID>
  ```

- API {#api}

  Use the [update](../../idp/api-ref/Userpool/update.md) REST API method for the [Userpool](../../idp/api-ref/Userpool/index.md) resource or the [UserpoolService/Update](../../idp/api-ref/grpc/Userpool/update.md) gRPC API call.

{% endlist %}
