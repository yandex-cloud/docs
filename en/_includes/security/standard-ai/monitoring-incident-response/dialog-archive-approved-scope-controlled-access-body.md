{#ai-forensic2-id}

Requirement ID: `AI-FORENSIC2`

{#ai-forensic2-applicability}

**Scope**

This requirement applies if the full or partial contents of a dialog is retained for investigation, quality assurance, support, or another approved purpose. If only minimal forensic events without the contents are preserved, the `N/A` result for the raw contents branch is acceptable with reference to the decision.

{#ai-forensic2-requirement}

**Requirement**

A decision regarding storage must specify the composition of messages and context changes, purpose, legal basis, retention period, storage location, owner, and readers. The archive is separated from standard application logs, encrypted using the mechanisms of the selected storage, and is not used as a mandatory source in cases where metadata from `AI-MON-TRACE1` is sufficient.

Reading and export of the archive must be logged by the service or application within the scope of available telemetry.

By default, the archive contains IDs, versions, and resolutions rather than the actual contents; no global collection of dialogs for potential future incidents is enabled. The archive is isolated by case, while readers of production journals and investigators are separated.

{#ai-forensic2-check}

**Check**

1. Match one saved session with the approved composition and timeframe.
1. Perform permitted and prohibited read operations, verify the read event or application record, and delete the test session upon expiration.

If the platform does not publish a read event, this blind spot and the compensating record must be explicitly specified. An investigator handling a different case must not gain access to the subject matter of the case under investigation.

{#ai-forensic2-artifacts}

**Artifact**

* Saved session.
* Test of permitted and prohibited reading.
* Case scope.
* Result of deletion or deletion prohibition.
