Supported security profiles:
* `PROFILE_STRICT`: Only TLS 1.3-compatible ciphers.

    {% note info %}

    All TLS 1.3 ciphers are considered secure.

    {% endnote %}

* `PROFILE_SECURE`: Ciphers compatible with TLS 1.2+ that support PFS (Perfect Forward Secrecy) and AEAD (Authenticated Encryption with Asssociated Data).
* `PROFILE_COMPATIBLE`: Ciphers compatible with TLS 1.2+ that have no known critical vulnerabilities.

    This profile is used by default.
* `PROFILE_LEGACY`: Ciphers compatible with TLS 1.0+ that have no known critical vulnerabilities.