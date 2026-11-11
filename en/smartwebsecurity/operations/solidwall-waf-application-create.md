---
title: How to create a SolidWall WAF application and connect a domain to it in {{ sws-full-name }}
description: Follow this guide to add an application to a SolidWall WAF profile in {{ sws-name }} and connect your website domains or APIs to it.
---

# Creating a SolidWall WAF application and connecting a domain to it

A [SolidWall WAF application](../concepts/solidwall-waf.md#resources) groups [domains](../concepts/domain-protect.md#domain), i.e., the addresses where your website or service is available. Add the application to a profile and connect domains to it so the WAF can inspect its incoming requests.

Before connecting, add the domain to the proxy server and attach a security profile with a Smart Protection rule to the domain. If the resources have not yet been created, prepare them according to the [general setup procedure](solidwall-waf-profile-create.md#setup).

## Create an app {#create-application}

Your service plan covers the first application. Other active applications are charged separately.

To create an application:

{% list tabs group=instructions %}

- Management console {#console}

  1. Make sure your account has the [smart-web-security.editor](../security/index.md#smart-web-security-editor) role for the folder housing your SolidWall WAF resources.
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the SolidWall WAF profile.
  1. [Navigate]({{ link-console-main }}/link/smartwebsecurity) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** and open the SolidWall WAF profile.
  1. Click **{{ ui-key.yacloud.smart-web-security.SolidWall.SolidWallProfileOverviewPage.label_add-application_4pETp }}**.
  1. Enter a name for the application.
  1. Optionally, provide a description.
  1. Click **{{ ui-key.yacloud.smart-web-security.Application.CreateApplicationPage.actionCreate_pi4Bb }}**.

{% endlist %}

A new application runs in monitoring mode and does not block requests. On the application page, you can see a support ticket with the application parameters, created automatically on your behalf. Use it to configure protection and coordinate switching to active protection mode. [Learn more about setting up your application](../tutorials/solidwall-waf.md#create-application).

## Connect a domain {#connect-domain}

To connect a domain to an application:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the application page, click **{{ ui-key.yacloud.smart-web-security.SolidWallApplicationActions.label_connect-domain_cAaqD }}**.
  1. In the **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.FormFieldDomainSelect.title_domain_aHoh1 }}** field, select the domain you want protected. If the domain is not in the list, first [add it](domain-create.md) to your {{ sws-name }}.
  1. In the **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.FormFieldSecurityProfileSelect.title_security-profile_v6r5o }}** field, select a security profile with a Smart Protection rule.

      If there is no suitable profile, click **{{ ui-key.yacloud.common.create }}**, [create a profile](profile-create.md) in a new tab, then return to connecting the domain and refresh the profile list.

  1. Optionally, to connect another domain to this application, click **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.DomainsFieldArray.button_add-domain_cVb2C }}** and re-select the domain and security profile.
  1. Click **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.button_connect_8BBRL }}**.
  1. Make sure the domains appear in the list on the application page.

{% endlist %}

After connecting the domains, [verify traffic processing](../tutorials/solidwall-waf.md#check-traffic) as per the tutorial.

#### Useful links {#see-also}

* [{#T}](../concepts/solidwall-waf.md)
* [{#T}](solidwall-waf-profile-create.md)
* [{#T}](setup-infrastructure.md)
* [{#T}](../tutorials/solidwall-waf.md)
