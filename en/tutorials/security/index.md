---
title: Security guides
description: Various security use cases in {{ yandex-cloud }}.
---

# Security guides

* [{#T}](user-group-access-control.md)
* [Creating an L7 load balancer with DDoS protection](alb-with-ddos-protection/index.md)
* [{#T}](sws-basic-protection.md)
* [{#T}](alb-ingress-with-sws-profile.md)
* [{#T}](migration-from-nlb-to-alb/index.md)
* [Terminating TLS connections](tls-termination/index.md)
* [Transferring logs from a VM instance to {{ cloud-logging-full-name }}](vm-fluent-bit-logging.md)
* [Writing load balancer logs to {{ PG }}](logging.md)
* [Secure storage of {{ GL }} CI passwords as {{ lockbox-full-name }}](gitlab-lockbox-integration.md) secrets
* [{#T}](static-key-in-lockbox/index.md)
* [{#T}](sa-oslogin-ansible.md)
* [{#T}](protected-access-to-content/index.md)
* [{#T}](audit-trails-events-to-kuma/index.md)
* [{#T}](search-events-audit-logs/index.md)
* [{#T}](wlif-github-integration.md)
* [{#T}](wlif-gitlab-integration.md)
* [{#T}](wlif-k8s-integration.md)
* [{#T}](wlif-managed-k8s-integration.md)
* [{#T}](coi-fluent-bit-logging.md)
* [{#T}](../container-infrastructure/k8s-fluent-bit-logging.md)
* [{#T}](balancer-with-sws-profile/index.md)
* [{#T}](distributed-secured-infrastructure.md)
* [{#T}](different-folders-services.md)
* [{#T}](alerts-monitoring.md)
* [{#T}](maxpatrol/index.md)
* [{#T}](export-logs-to-splunk.md)
* [{#T}](export-logs-to-arcsight.md)
* [{#T}](mgp-to-cloud-logging.md)
* [{#T}](info-for-federal-ip-whitelist.md)
* [{#T}](ephemeral-key-storage.md)

## Managing identity federations {#federations}

* [{#T}](integration-adfs.md)
* [{#T}](integration-gworkspace.md)
* [{#T}](integration-azure.md)
* [{#T}](integration-keycloak.md)

### User group mapping {#matching-user-groups}

* [{#T}](adfs.md)
* [{#T}](entra-id.md)
* [{#T}](keycloak.md)

## {{ captcha-full-name }} use cases {#smartcaptcha}

* [{#T}](mobile-app/website.md)
* [{#T}](mobile-app/android/quickstart-android.md)
* [{#T}](mobile-app/android/invisible-captcha-android.md)
* [{#T}](mobile-app/android/quickstart-android-flutter.md)
* [{#T}](mobile-app/ios/quickstart-ios.md)
* [{#T}](../container-infrastructure/kubernetes-lockbox-secrets.md)
* [{#T}](../container-infrastructure/kms-k8s.md)
* [{#T}](../container-infrastructure/sign-cr-with-cosign.md)
* [{#T}](terraform-key.md)
* [{#T}](terraform-secret.md)
* [{#T}](vault-secret.md)

## Data encryption {#encrypt}

* [{#T}](encrypt/index.md)
* [{#T}](encrypt/cli-api.md)
* [{#T}](encrypt/sdk.md)
* [{#T}](encrypt/aws-encryption-sdk.md)
* [{#T}](encrypt/google-tink.md)
* [{#T}](wlif-github-integration.md)
* [{#T}](server-side-encryption.md)

## Integrations of workload identity federations {#wlif-integration}

* [{#T}](wlif-github-integration.md)
* [{#T}](wlif-gitlab-integration.md)
* [{#T}](wlif-k8s-integration.md)
* [{#T}](wlif-managed-k8s-integration.md)

## Setting up SSO for applications {#sso}

* [1C:Enterprise](./single-sign-on/oidc-1c-enterprise.md)
* Cloud.ru
    * [{#T}](./single-sign-on/cloud-ru/saml-cloud-ru.md)
    * [{#T}](./single-sign-on/cloud-ru/oidc-cloud-ru.md)
* Grafana Cloud
    * [{#T}](./single-sign-on/grafana/saml-grafana.md)
    * [{#T}](./single-sign-on/grafana/oidc-grafana.md)
* [Grafana OSS](./single-sign-on/oidc-grafana-oss.md)
* [Harbor](./single-sign-on/oidc-harbor.md)
* Jenkins
    * [{#T}](./single-sign-on/jenkins/saml-jenkins.md)
    * [{#T}](./single-sign-on/jenkins/oidc-jenkins.md)
* [{{ mgl-name }}](./single-sign-on/saml-managed-gitlab.md)
* [{{ mos-name }}](./single-sign-on/saml-opensearch.md)
* [MWS](./single-sign-on/oidc-mws.md)
* [{{ OS }}](./single-sign-on/saml-opensearch-self-managed.md)
* OpenVPN
    * [OpenVPN Access Server](./single-sign-on/saml-ovpn.md)
    * [OpenVPN Community Edition](./single-sign-on/oidc-ovpn.md)
* [Selectel](./single-sign-on/saml-selectel.md)
* [Sentry](./single-sign-on/saml-sentry.md)
* [SonarQube](single-sign-on/saml-sonarqube.md)
* VK Cloud
    * [{#T}](./single-sign-on/vk-cloud/saml-vk-cloud.md)
* [Zabbix](./single-sign-on/saml-zabbix.md)
* [Passwork](./single-sign-on/saml-passwork.md)
* [{{ yandex-360 }}](./single-sign-on/saml-yandex-360.md)
* [Yandex Browser for organizations](./single-sign-on/saml-ya-browser-corporate.md)
* [Configuring single sign-on for applications that do not support SSO](./single-sign-on/oidc-nginx-oauth2-proxy.md)