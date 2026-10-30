# Policy Manager

Policy Manager checks Kubernetes resources for compliance with policies and scans custom application images for known vulnerabilities. [Kyverno](https://kyverno.io/) runs policy checks, while images are scanned by Trivy

Operator. You can get the results in the management console and in Kubernetes resources.

{% note warning %}

Discovered vulnerabilities do not block creating, starting up, or restarting pods. Trivy work only in report generation mode.

{% endnote %}

## Security policies {#policies}

Policy Manager provides two policy presets:

* Baseline: Basic standard in [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline).
* Restricted: Protected standard in [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted).

The baseline preset is applied by default. It works best for applications whose failures or unavailability do not cause major consequences. The _restricted_ preset is designed for critical applications and users with a low level of trust.

The default preset is specified in the `PolicyManagerConfig` resource. You can activate an additional preset using the `ClusterPolicySet` resource by following the [Activating a policy preset](../../operations/policy-manager/apply-preset.md) guide.


Both presets work in audit mode and generate violation reports.

## Image scanning {#image-scanning}

Scanning is enabled by default. For each image of the current user load version, Trivy Operator creates a `VulnerabilityReport` resource.

If it contains findings, the adapter creates a separate standard `PolicyReport` available to the existing consumers of Policy Manager reports. When the list of findings becomes empty, the adapter deletes only the related `PolicyReport`. All severity levels are saved in `VulnerabilityReport`.

For a private custom image, the operator reads ServiceAccount of the source load, finds the `imagePullSecrets` specified in it, and provides these credentials to the scan job. The scan job itself works on behalf of the operator ServiceAccount in the Policy Manager namespace. If the discovered data is not sufficient for downloading an image, no report is generated.

Databases for OS packages and Java libraries are delivered in separate images.
The main database is installed by the initContainer of the Trivy server, while the Java DB, by a separate initContainer, to the common cache of each scan job. The scanner image does not contain any database archives. The delivery includes offline databases, so internet access is not required to get their standard configuration. To update databases separately from {{ stackland-name }} releases, specify the available mirrors: `database.registry` along with `database.repository` for the main database and `database.javaRegistry` along with `database.javaRepository` for the Java DB. Both mirrors must allow anonymous reading of images: the registry credentials of the user load are not used for downloading the databases. A single Trivy Server downloads the main database. The external Java DB is downloaded separately into each scan job (approximately 1 GB per scan), so when using it, factor in the registry throughput and `scanJobTimeout`. The built-in Java DB does not require downloading over network. Each scanner container in the scan job requests `3Gi` and is limited to `6Gi` of temporary storage for the Java DB and unpacked image layers. The total values for the job are multiplied by the number of source load containers.

To learn more about viewing results, see the [Viewing vulnerability reports](../../operations/policy-manager/view-vulnerability-reports.md) guide.


## Configuration {#configuration}

Here is an example:

{% include notitle [YAML-file](../../_includes/yamls/components/policymanagerconfig.md) %}

Where:

* `enabled`: Enables Policy Manager. If set to `false`, Kyverno, Policy Reporter, the policy controller, and the scanner are deleted.
* `settings.defaultPolicySet.engines.kyverno.presets`: Specifies Kyverno presets.
* `settings.trivy.enabled`: Enables the scanner and report adapter separately from Policy Manager's other parts.
* `settings.trivy.settings.scanner.reportTTL`: Sets a retention period for a report and an effective rescan interval. The minimum number is `1s`.
* `settings.trivy.settings.scanner.concurrentScanJobs`: Limits the number of simultaneously performed scan jobs.
* `settings.trivy.settings.scanner.scanJobTimeout`: Limits the duration of a single job. The minimum value is `1s`.
