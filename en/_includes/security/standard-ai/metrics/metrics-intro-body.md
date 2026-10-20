> **Section status: Reference**. The metrics are provided as a basis for building an indicator system and are not mandatory requirements of this standard. Before formal adoption, the calculation formula, measurement period, unit of measurement, related `AI-*` requirements, and result interpretation must be defined for each metric.

Metrics are there to monitor how requirements are implemented, but as such they do not prove the system is secure. Their list, frequency, and target values are determined by the organization with risk and architecture in mind.

If a metric's value cannot be calculated because there is no applicability condition in the architecture (e.g., there are no agent scenarios), it is marked as `N/A`. If the denominator is below the organization-specific threshold, the metric is considered `N/A` with an explanation.

The absence of a registry, end-to-end tracing, alerts, or any other data source required to calculate an applicable metric is not considered `N/A`: this fact gets registered as lack of control or data, which needs to be fixed.
