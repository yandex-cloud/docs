{#ai-supply3-id}

Requirement ID: `AI-SUPPLY3`

{#ai-supply3-applicability}

**Scope**

This requirement applies prior to the initial production deployment of any third-party model package and after its major modification.

{#ai-supply3-requirement}

**Requirement**

The procedure must include a request explaining how you plan to use the model, a check on the source and license terms, integrity check, format and loader analysis, isolated run, results of approved behavioral tests, admission decision, and and a record of the exact version number. The requesting party cannot approve their own package if the organization policy mandates an independent review. The approval is bound to the exact hash of the acceptance package; the deployment control must only accept approved model packages.

{#ai-supply3-implementation}

**Implementation**

The acceptance record must be linked to `AI-MODEL1`, while the production release, to `AI-REL1`. Reusing a previous approval decision for a different version is not allowed.

{#ai-supply3-manual-check}

**Manual check**

1. Select a running third-party model and restore the associated request, approved package, results, decision, and registry entry.
1. Replace the test checksum or version: the old decision must reject the new package.

A missing or outdated acceptance package must also be rejected.

{#ai-supply3-artifacts}

**Artifact**

* Acceptance record.
* Checksum spoofing test.
* Acceptance package and its hash.
* Confirmation or exclusion.
