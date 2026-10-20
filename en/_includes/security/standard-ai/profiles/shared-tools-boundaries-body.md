| Tool | Verification target | Beyond the tool |
|---|---|---|
| [{{ sws-name }}](../../../../smartwebsecurity/index.yaml) | Documented HTTP(S), WAF, and bot rules and rate limiting | Semantic prompt validation and document authorization |
| [Guardrails]({{ link-docs-ai }}ai-studio/concepts/security/guardrails.html) | Moderation of supported input and output. This feature is at the Preview stage. | Response schema, {{ iam-short-name }}, masking, or legal framework |
| [{{ at-name }}](../../../../audit-trails/index.yaml) | Published events for selected services and operations | Full application tracing and undocumented data events |
| [{{ cloud-logging-name }}](../../../../logging/index.yaml) | Receipt and storage of submitted records with configured access and retention periods | Universal removal of secrets or personal data from any application content |
| [{{ monitoring-short-name }}](../../../../monitoring/index.yaml) | Metric, alert condition, and notification | Automatic shutdown of high-risk workloads |
| [{{ container-registry-name }} vulnerability scanner](../../../../container-registry/concepts/vulnerability-scanner.md) | Docker image vulnerabilities within the scanner scope | Model behavior, weights, dataset, complete SBOM, and release provenance |
| [{{ dspm-name }}](../../../../security-deck/concepts/dspm.md) | Detection of supported categories in connected sources | Source data transformation and legal approach |
| [{{ ciem-name }}](../../../../security-deck/concepts/ciem.md) | Viewing direct, group, and inherited assignments, and revoking access within published limits. {{ ciem-name }} as a whole is at the Preview stage. | Determining which permission is excessive according to the organization's policy and ensuring the Preview feature's availability. |
| [{{ ycdr-name }}](../../../../ycdr/index.yaml) | Preview service signals after access approval, installation of a dedicated cloud collector, and source configuration. `ycdr.admin` is required to work with investigations. | Guaranteed telemetry availability and completeness |

The {{ dspm-name }} scanning service account is assigned the `dspm.worker` role according to [this scan guide](../../../../security-deck/operations/dspm/create-scan.md). For a bucket with a custom {{ kms-short-name }} key, `kms.keys.decrypter` is also required. If bucket access is governed by a bucket policy, the allowlisting of the published {{ sd-name }} IP addresses and successful completion of the scan are verified separately.

To view permissions in {{ ciem-name }}, you need the `organization-manager.viewer` role for the organization or a broader documented role; access revocation is verified separately based on the [documented roles and restrictions](../../../../security-deck/security/ciem-roles).

{{ ycdr-name }} evidence includes access approval, a separate collector configuration for each cloud, successful transmission of a test event over TLS, and `ycdr.admin` binding. For details, see the [{{ ycdr-name }} review](../../../../ycdr/concepts/index.md) and [access model](../../../../ycdr/security/index.md) description.

{{ ciem-name }} and {{ ycdr-name }} conditions do not extend to the entirety of {{ sd-name }} or its [Alerts](../../../../security-deck/concepts/alerts.md).
