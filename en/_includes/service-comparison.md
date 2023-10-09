| **Criterion \ service** | **Container<br/>Solution** | **Managed<br/>Service for<br/>Kubernetes** | **Cloud<br/>Functions** | **Serverless<br/>Containers** |
--- | --- | --- | --- | ---
| **Entry threshold** | Medium | High | Low | Medium |
| **Scaling** | Configurable | Configurable | Automatic | Automatic |
| **Service<br/>activity** | Continuous | Continuous | On HTTPS or trigger call | On HTTPS or trigger call |
| **Call<br/>processing<br/>time** | No<br/>restrictions | No<br/>restrictions | Up to 10 minutes | Up to 10 minutes |
| **Number of calls<br/>processed<br/>simultaneously<br/>by a single instance** | No<br/>restrictions | No<br/>restrictions | 1 | 1–10 |
| **Supported<br/>technologies** | No<br/>restrictions | No<br/>restrictions | Node.js<br/>Python<br/>Go<br/>PHP<br/>Bash<br/>Java<br/>R<br/>C# | No<br/>restrictions |
| **Fee-based services** | Running time of the VM hosting the container | Use of a Kubernetes cluster master and running time of the VM hosting the container | Time and memory used to process a call and the number of calls | Time and memory used to process a call and the number of calls |