{#ai-data3-id}

Requirement ID: `AI-DATA3`

{#ai-data3-requirement}

**Requirement**

Source, cleaned, marked-up, training, evaluation, or published data must be distinguishable by objects or versions, write permissions, and advancement rules. Transition between stages takes place only after a relevant check and decision.

Updating an already approved object requires a new version and re-admission. The production environment must not change the production corpus directly. By default, the network and {{ iam-short-name }} must not give the record back or between parallel stages.

If one immutable input is used directly without derivative stages, the `N/A` result is allowed only for absent branches.

For {{ objstorage-name }}, you can use separate buckets or prefixes, access policies, and [versioning](../../../../storage/operations/buckets/versioning.md).

For network storages available online, [{{ vpc-short-name }} security groups](../../../../vpc/concepts/security-groups.md) are used where the service supports them. The particular scheme must suit the selected service, not be transferred from one storage to another.

In {{ ai-search-name }}, uploading a file and creating an index are treated as different lifecycle objects.

{#ai-data3-check}

**Check**

Check the path of one record from the source object up to the published version, subjects authorized to write at each stage, and the impossibility to write from the production environment to the source or evaluation set. The derived results created during the violation are recognized invalid, and the pipeline is repeated after narrowing down the access.

{#ai-data3-artifacts}

**Artifact**

* Bucket/prefix access policies.
* Record test from the production environment.
* Stage schema.
* Input and output versions.
* Transition log.
