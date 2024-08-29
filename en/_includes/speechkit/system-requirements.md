
To install {{ sk-hybrid-name }}, you need a Linux server with Docker Engine support. For a list of supported operating systems, see the [Docker official documentation](https://docs.docker.com/engine/install/#server).

{% note warning %}

The CPU must support the [AVX2](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions#CPUs_with_AVX2) (Advanced Vector Support) instruction set.

{% endnote %}

On Linux, to check whether your host supports AVX2, run:

```bash
grep -q avx2 /proc/cpuinfo && echo AVX2 || echo No AVX2
```