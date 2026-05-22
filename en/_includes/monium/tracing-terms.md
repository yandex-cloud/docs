### Request tracing {#tracing} 

Request tracing is there for analysis of distributed requests. It allows you to visualize and track the execution path of a specific request as it passes through many different services and infrastructure components. Request execution path is a sequence of operations called spans.

### Span {#span}

A span is a basic distributed tracing element representing a single operation in your system. For example, this may be a database query, an HTTP request, or a function call. Each span comes with a name, start and end time, labels, logs, and execution context. Spans may contain links to other spans to join them together into a trace.

### Trace {#trace}

A trace is a combination of spans forming the execution path of a particular request.