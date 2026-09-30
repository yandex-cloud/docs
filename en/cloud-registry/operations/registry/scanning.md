---
title: Scanning a {{ cloud-registry-name }}
description: In this guide, you will learn how to configure {{ cloud-registry-name }} scanning.
---

# Scanning a {{ cloud-registry-name }}

Registries are scanned using our [Vulnerability Management (VM)](../../../security-deck/concepts/vulnerability-management.md). You can configure scanning:
* In the {{ sd-full-name }} interface. To do this, click **{{ ui-key.yacloud.cloud-registry.scan-history-empty_button }}** and follow [this guide](../../../security-deck/operations/vulnerability-management/enable-vulnerability-management.md).
* In the {{cloud-registry-name }} interface by following this guide.

{% note info %}

You can only configure scanning for local and remote Docker registries. Only Docker images stored in the {{ cloud-registry-name }} cache are scanned in remote registries.

{% endnote %}

{% note warning %}

Scanning is not free of charge. For more information, see the [{{ sd-full-name }} pricing policy](../../../security-deck/pricing.md#prices).

{% endnote %}

## Automatic scanning {#auto}

You can configure settings for automatically scanning artifacts in the registry. You can also set up automatic scanning when [creating a registry](create.md).

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the registry is located.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud.cloud-registry.title_registries }}**.
    1. Select the registry.
    1. Navigate to the **{{ ui-key.yacloud.cloud-registry.menu_scanner }}** tab.
    1. Click **{{ ui-key.yacloud.cloud-registry.scanner-settings.action_configure-scanner }}**.
    1. Optionally, enable **{{ ui-key.yacloud.cloud-registry.scan-policy-settings-form.row_scan-lang-packages }}** under **{{ ui-key.yacloud.cloud-registry.scanner-settings.label_scanning-language-packages }}**.
    1. Optionally, expand **{{ ui-key.yacloud.cloud-registry.scan-policy-settings-form.section_on-push-title }}** and select:

        * `{{ ui-key.yacloud.cloud-registry.scan-policy-form-card.label_artifacts-to-scan_all }}` to scan all artifacts when pushing to the registry.
        * `{{ ui-key.yacloud.cloud-registry.scan-policy-form-card.label_artifacts-to-scan_selected }}` to specify the artifacts to scan when pushing to the registry. Click **{{ ui-key.yacloud.cloud-registry.scan-policy-form-card.button_add_artifacts }}**, select artifacts, and click **{{ ui-key.yacloud.cloud-registry.action_scan-artifacts-modal-add }}**.

    1. Optionally, expand **{{ ui-key.yacloud.cloud-registry.scan-policy-settings-form.section_scheduled-title }}** and select:

        * `{{ ui-key.yacloud.cloud-registry.scan-policy-form-card.label_artifacts-to-scan_all }}` to scan all artifacts in the registry at specified intervals.
        * `{{ ui-key.yacloud.cloud-registry.scan-policy-form-card.label_artifacts-to-scan_selected }}` to specify which artifacts to scan at specified intervals. Click **{{ ui-key.yacloud.cloud-registry.scan-policy-form-card.button_add_artifacts }}**, select artifacts, and click **{{ ui-key.yacloud.cloud-registry.action_scan-artifacts-modal-add }}**.

        Specify the artifact scan interval.

    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. See the description of the CLI command for creating an automatic scan policy:

        ```bash
        yc cloud-registry registry scan-policy create --help
        ```

    1. Create a JSON file with scan rules, e.g., `scan-rules.json`:

        ```json
        {
          "pushRule": {
            "paths": ["*"],
            "disabled": false
          },
          "scheduleRules": [
            {
              "amount": "7",
              "intervalUnit": "DAYS",
              "paths": ["*"],
              "disabled": false
            }
          ]
        }
        ```

        Where:

        * `pushRule`: Scan artifacts when pushing to the registry:

            * `paths`: List of paths to the artifacts to scan. To scan all artifacts in the registry, specify `*`.
            * `disabled`: Disable scanning.

        * `scheduleRules`: Scan artifacts in the registry at regular intervals:

            * `amount`: Number of time units in the scan interval.
            * `intervalUnit`: Time unit. The available value is `DAYS`.
            * `paths`: List of paths to the artifacts to scan. To scan all artifacts in the registry, specify `*`.
            * `disabled`: Disable scanning.

    1. Create an automatic scan policy:

        ```bash
        yc cloud-registry registry scan-policy create <policy_name> \
          --registry-id <registry_ID> \
          --description <policy_description> \
          --scan-lang-packages \
          --rules <path_to_file_with_rules>
        ```

        Where:

        * `<policy_name>`: Automatic scan policy name.
        * `--registry-id`: ID of the registry for which you are creating the policy.
        * `--description`: Policy description. This is an optional parameter.
        * `--scan-lang-packages`: Enable language package scanning. This is an optional parameter.
        * `--rules`: Path to the JSON file with scan rules. This is an optional parameter.

- API {#api}

    To create an automatic registry scan policy, use the [create](../../api-ref/ScanPolicy/create.md) REST API method for the [ScanPolicy](../../api-ref/ScanPolicy/index.md) or the [ScanPolicyService/Create](../../api-ref/grpc/ScanPolicy/create.md) gRPC API call.

{% endlist %}

## Scanning manually {#manual}

You can manually start a scan of the selected artifacts in the registry.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the registry is located.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud.cloud-registry.title_registries }}**.
    1. Select the registry.
    1. Navigate to the **{{ ui-key.yacloud.cloud-registry.menu_scanner }}** tab.
    1. Click **{{ ui-key.yacloud.cloud-registry.scan-history-placeholder_action_new-scan }}**.
    1. Select the artifacts you want to scan and click **{{ ui-key.yacloud.cloud-registry.action_scan-artifacts-modal-add }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. See the description of the CLI command for scanning an artifact:

        ```bash
        yc cloud-registry artifact scanner scan --help
        ```

    1. Get a list of artifacts in the registry:

        ```bash
        yc cloud-registry registry list-artifacts <registry_name_or_ID>
        ```

    1. Start an artifact scan:

        ```bash
        yc cloud-registry artifact scanner scan <artifact_ID>
        ```

- API {#api}

    To start an artifact scan, use the [ScannerService/Scan](../../api-ref/grpc/Scanner/scan.md) gRPC API call.

{% endlist %}



