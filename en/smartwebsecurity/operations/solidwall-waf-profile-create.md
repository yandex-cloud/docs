---
title: How to create a SolidWall WAF profile in {{ sws-full-name }}
description: Follow this guide to create a SolidWall WAF profile in {{ sws-name }}, select a service plan, and set the peak load for applications.
---

# Creating a SolidWall WAF profile

{% include [solidwall-waf-preview](../../_includes/smartwebsecurity/solidwall-waf-preview.md) %}

A [SolidWall WAF profile](../concepts/solidwall-waf.md#resources) groups applications to set a unified service plan and peak load for them. Each application integrates the domains of a single website or service.

## Setup steps {#setup}

To get started with SolidWall WAF:

* Select an existing {{ sws-name }} [proxy server](../concepts/domain-protect.md#proxy) or [create a new one](proxy-create.md). It receives user requests and forwards them to your web application server.
* [Add your website or API domain](domain-create.md) to the proxy server. Specify a single target and version `HTTP/1.1` for connecting to it. If the domain is already added, check these settings.
* [Connect](host-connect.md#domain) a security profile with at least one Smart Protection rule to the domain. Employ an existing profile or [create a new one](profile-create.md).
* [Configure DNS](setup-infrastructure.md) so that the domain’s A record points to the proxy server’s IP address. [Verify the target is available](validate-availability.md) and make sure your website or API responds to requests via the domain name.
* [Create a SolidWall WAF profile](#create-profile) with the required service plan and load.
* [Create an application](solidwall-waf-application-create.md#create-application) in the profile and [connect domains](solidwall-waf-application-create.md#connect-domain) to it so their traffic starts flowing into SolidWall WAF.

You can create the domain and the SolidWall WAF profile in any order.

## Create a SolidWall WAF profile {#create-profile}

To create a profile:

{% list tabs group=instructions %}

- Management console {#console}

  1. Make sure your account has the [smart-web-security.editor](../security/index.md#smart-web-security-editor) role for the folder housing your SolidWall WAF resources.

      Creating a proxy server also requires the [iam.serviceAccounts.admin](../../iam/security/index.md#iam-serviceAccounts-admin) role for the folder.

      When first creating a profile, you need the [smart-web-security.admin](../security/index.md#smart-web-security-admin) role for at least one cloud in the organization. Otherwise, you will not be able to accept the HTTP request data usage agreement. The agreement is accepted once per organization. To revoke consent, contact [support](../../support/overview.md).

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/smartwebsecurity) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. If you still do not have access to SolidWall WAF, fill out the access request form: describe how you intend to use SolidWall WAF, submit your request, and wait for access to be granted.
  1. When creating the first profile, accept the HTTP request data usage agreement.
  1. Click **{{ ui-key.yacloud.smart-web-security.WafCreateProfileAction.createWafOrSolidWallProfileButton_6J5WK }}** and select **{{ ui-key.yacloud.smart-web-security.solidWallProfile_jVUUm }}**.
  1. Name the profile.
  1. Optionally, provide a description for the profile.
  1. Under **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.titleRpsLimit_b67eQ }}**, select the desired [RPS tier](../concepts/solidwall-waf.md#tariffs) to accommodate your needs. Take into account the total load on all applications in the profile and focus on the peak daily RPS.
  1. Under **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.titleTariff_6j471 }}**, select the [service plan](../concepts/solidwall-waf.md#tariffs).


  1. Check the selected plan and load in the cost calculator to the right of the form.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. In the **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.ConfirmPurchaseDialog.dialogTitle_fomvt }}** window, read the terms and click **{{ ui-key.yacloud.common.continue }}**.

{% endlist %}

The new profile will appear in the list. Now you can [add your application and connect a domain to it](solidwall-waf-application-create.md).

#### Useful links {#see-also}

* [{#T}](../concepts/solidwall-waf.md)
* [{#T}](solidwall-waf-application-create.md)
* [{#T}](solidwall-waf-profile-delete.md)
* [{#T}](../tutorials/solidwall-waf.md)
