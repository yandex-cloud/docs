**Example of file contents for multi-label classification training**:

```json
{"text":"Abstract: The two-stage least-squares (2SLS) estimator is known to be biased when its first-stage fit is poor. I show that better first-stage prediction can alleviate this bias. In a two-stage linear regression model with Normal noise, I consider shrinkage in the estimation of the first-stage instrumental variable coefficients. For at least four instrumental variables and a single endogenous regressor, I establish that the standard 2SLS estimator is dominated with respect to bias.", "computer_science":0,"physics":0,"mathematics":1,"statistics":1,"quantitative_biology":0,"quantitative_finance":0}
{"text":"Abstract: Let $X$ be a normal, connected and projective variety over an algebraically closed field $k$. It is known that a vector bundle $V$ on $X$ is essentially finite if and only if it is trivialized by a proper surjective morphism $f:Y to X$. In this paper we introduce a different approach to this problem which allows to extend the results to normal, connected and strongly pseudo-proper algebraic stack of finite type over an arbitrary field $k$.", "computer_science":0,"physics":0,"mathematics":1,"statistics":0,"quantitative_biology":0,"quantitative_finance":0}
{"text":"Abstract: Hypothesis generation is becoming a crucial time-saving technique which allows biomedical researchers to quickly discover implicit connections between important concepts. Typically, these systems operate on domain-specific fractions of public medical data. MOLIERE, in contrast, utilizes information from over 24.5 million documents. At the heart of our approach lies a multi-modal and multi-relational network of biomedical objects extracted from several heterogeneous datasets from the National Center for Biotechnology Information (NCBI).", "computer_science":1,"physics":0,"mathematics":0,"statistics":1,"quantitative_biology":0,"quantitative_finance":0}
```

Where:
* `computer_science`, `physics`, `mathematics`, `statistics`, `quantitative_biology`, and `quantitative_finance`: Classes.
* `text`: Message text.
