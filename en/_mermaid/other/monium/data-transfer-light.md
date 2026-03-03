```mermaid
graph LR
  classDef hidden fill:#ffffff,stroke:#ffffff,fill-opacity:0,stroke-opacity:0,stroke-width:0;
  
  subgraph Local[Yandex Cloud or 
  other infrastructure]
    direction TB
    pad[ ]:::hidden
    A[OpenTelemetry SDK
    service or app]
    B[Agent]
  end

  A -->|localhost:8889| B
  B -->|{{ api-host-monium }}| C[{{ monium-name }}]
```