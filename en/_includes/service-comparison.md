**Criterion \ service** | **Container<br/>Solution** | **Managed<br/>Service for<br/>Kubernetes** | **Cloud<br/>Functions** | **Serverless<br/>Containers**
--- | --- | --- | --- | ---
**Entry threshold** | Medium | High | Low | Medium
**Scaling** | Can be<br/>set up | Can be<br/>set up | Automatic | Automatic
**Service<br/>activity** | Continuous | Continuous | On HTTPS or trigger call | On HTTPS or trigger call
**Call<br/>processing<br/>time** | No<br/>limits | No<br/>limits | Up to 1 hour | Up to 1 hour
**Number of calls<br/>processed<br/>concurrently<br/>by one instance** | No<br/>limits | No<br/>limits | 1-16 | 1–16
**Supported<br/>technologies** | No<br/>limits | No<br/>limits | Node.js<br/>Python<br/>Go<br/>PHP<br/>Bash<br/>Java<br/>Kotlin<br/>R<br/>C# | No<br/>limits
**Fee-based services** | Running time of the VM hosting the container | Use of a Kubernetes cluster master and running time of the VM hosting the container | Time and memory used to process calls and the number of calls | Time and memory used to process calls and the number of calls