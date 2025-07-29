---
title: '{{ yandex-cloud }} security tutorials'
description: Various {{ yandex-cloud }} security tutorials
---

# {{ yandex-cloud }} security tutorials

## Authentication and access management {#authentication}

* [{#T}](authentication/user-group-access-control.md)
* [{#T}](authentication/sa-oslogin-ansible.md)
* Managing identity federations
    * [{#T}](authentication/integration-adfs.md)
    * [{#T}](authentication/integration-gworkspace.md)
    * [{#T}](authentication/integration-azure.md)
    * [{#T}](authentication/integration-keycloak.md)
    * User group mapping
        * [{#T}](authentication/adfs.md)
        * [{#T}](authentication/entra-id.md)
        * [{#T}](authentication/keycloak.md)


## Network security {#network-security}

* [{#T}](network-security/virtual-hosting.md)
* [{#T}](network-security/bucket-to-bucket-copying.md)
* [{#T}](network-security/data-transfer-direct-to-mch.md)
* [{#T}](network-security/alb-with-ddos-protection/index.md)
* [{#T}](network-security/remote-wireguard-vpn.md)
* [{#T}](network-security/protected-access-to-content/index.md)


## Secure virtual environment configuration {#virtualenv-safe-config}

* [{#T}](virtualenv-safe-config/gatsby-static-website.md)
* [{#T}](virtualenv-safe-config/lockbox-and-airflow.md)
* [{#T}](virtualenv-safe-config/nodejs-cron-restart-vm.md)
* Migrating services from NLB to L7 ALB for DDoS protection using {{ sws-full-name }}
    * [{#T}](virtualenv-safe-config/nlb-with-target-resource-vm.md)
    * [{#T}](virtualenv-safe-config/nlb-with-target-resource-group-vm.md)
    * [{#T}](virtualenv-safe-config/nlb-as-target-resource-alb.md)


## Data encryption and key management {#data-encryption-and-key-management}

* Data encryption
    * [{#T}](data-encryption-and-key-management/choose-encryption-method.md)
    * [{#T}](data-encryption-and-key-management/cli-api.md)
    * [{#T}](data-encryption-and-key-management/sdk.md)
    * [{#T}](data-encryption-and-key-management/aws-encryption-sdk.md)
    * [{#T}](data-encryption-and-key-management/google-tink.md)
* [{#T}](data-encryption-and-key-management/terraform-key.md)
* [{#T}](data-encryption-and-key-management/terraform-secret.md)
* [{#T}](data-encryption-and-key-management/vault-secret.md)
* [{#T}](data-encryption-and-key-management/secure-password-script.md)
* [{#T}](data-encryption-and-key-management/tls-termination/index.md)
* [{#T}](data-encryption-and-key-management/gitlab-lockbox-integration.md)
* [{#T}](data-encryption-and-key-management/static-key-in-lockbox/index.md)
* [{#T}](data-encryption-and-key-management/wlif-github-integration.md)
* [{#T}](data-encryption-and-key-management/wlif-gitlab-integration.md)


## Collecting, monitoring, and analyzing audit logs {#audit-logs}

* [{#T}](audit-logs/query.md)
* [{#T}](audit-logs/search-bucket.md)
* [{#T}](audit-logs/search-cloud-logging.md)
* [{#T}](audit-logs/alerts-monitoring.md)
* [{#T}](audit-logs/logging-functions.md)
* [{#T}](audit-logs/audit-trails.md)
* Exporting audit logs to SIEM systems
    * [{#T}](audit-logs/maxpatrol.md)
    * [{#T}](audit-logs/export-logs-to-splunk.md)
    * [{#T}](audit-logs/export-logs-to-arcsight.md)
    * [{#T}](audit-logs/audit-trails-events-to-kuma/index.md)
* [{#T}](audit-logs/vm-fluent-bit-logging.md)
* [{#T}](audit-logs/logging.md)
* [{#T}](audit-logs/coi-fluent-bit-logging.md)


## Application security {#app-security}

* [{#T}](app-security/nginx-ingress-certificate-manager.md)
* [{#T}](app-security/ci-cd-serverless.md)
* [{#T}](app-security/websocket-app.md)
* [{#T}](app-security/balancer-with-sws-profile.md)
* [{#T}](app-security/api-gw-sws-integration.md)
* [{#T}](app-security/website.md)
* [{#T}](app-security/quickstart-android.md)
* [{#T}](app-security/invisible-captcha-android.md)
* [{#T}](app-security/quickstart-android-flutter.md)
* [{#T}](app-security/quickstart-ios.md)


## {{ k8s }} security {#kubernetes-security}

* [{#T}](kubernetes-security/kms-k8s.md)
* [{#T}](kubernetes-security/sign-cr-with-cosign.md)
* [{#T}](kubernetes-security/kubernetes-lockbox-secrets.md)
* [{#T}](kubernetes-security/wlif-k8s-integration.md)
* [{#T}](kubernetes-security/alb-ingress-with-sws-profile.md)
* [{#T}](kubernetes-security/nlb-with-target-resource-k8s/index.md)
* [{#T}](kubernetes-security/k8s-fluent-bit-logging.md)
