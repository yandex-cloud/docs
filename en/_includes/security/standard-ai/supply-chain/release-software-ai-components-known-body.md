{#ai-supply5-id}

Requirement ID: `AI-SUPPLY5`

{#ai-supply5-requirement}

**Requirement**

For each release, a reproducible list must be preserved that covers its software dependencies, images, model, adapters and tokenizer, configuration, prompts, applied guardrails and model instance, tools and MCPs, external provider, and data sources or index.

For the software component, we recommend to generate an SBOM in a standard machine-readable format. A separate manifest may be required for the model and data, as a software SBOM does not describe their meaning and provenance.

If the pipeline generates an SBOM, signature, or attestation, a reference to it is provided, but this is not referred to as native {{ yandex-cloud }} control.

{#ai-supply5-implementation}

**Implementation**

Documented [{{ container-registry-name }}](../../../../container-registry/index.yaml) functions include storage and distribution of Docker images and vulnerability scanning. These results in themselves do not constitute a complete SBOM or release attestation. The organization selects a specific tool for generation and verification and links the result to the release digest.

{#ai-supply5-check}

**Check**

Reconstruct the contents of the working version from the saved manifest and compare the checksums against the actual objects. An unspecified component or a floating version means that the release is non-reproducible. The check must detect an intentionally omitted or altered component.

{#ai-supply5-artifacts}

**Artifact**

* Saved manifest.
* Comparison with actual objects.
* Manifest hash.
* Component cards.
