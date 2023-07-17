# {{ speechkit-name }} Synthesis Service: gRPC API reference
The {{ speechkit-name }} Text To Speech API allows application developers to use speech synthesis technologies. <br>The service does not operate with resources. Actions are performed by making RPC calls. For more information about API architecture, see [API Concepts]({{ api-url-prefix }}/api-design-guide/). <br><strong> API has limitation — the request cannot exceed 250 characters and 24 seconds for synthesis.</strong>

See the interface definitions of the API on [GitHub](https://github.com/nebius/nebius-solutions-library-for-ai).

Service | Description
--- | ---
[Synthesizer](./tts_service.md) | A set of methods for voice synthesis.
