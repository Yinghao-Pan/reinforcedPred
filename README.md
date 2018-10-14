
<!-- README.md is generated from README.Rmd. Please edit that file -->
reinforcedPred
==============

Traditional risk prediction only utilizes baseline factors known to be associated with the disease. Given that longitudinal information are routinely measured and documented for patients, it is worthwhile to make full use of these data. The available longitudinal biomarker data will likely improve prediction. However, repeated biomarker collection could be costly and inconvenient, and risk prediction for patients at a later time could delay necessary medical decisions. Thus, there is a trade-off between high quality prediction and cost. This package implements a cost-effective statistical procedure that recursively incorporates comprehensive longitudinal information into the risk prediction model, taking into account the cost of delaying the decision to a follow-up time when more information is available.

The statistical methodology is described in the following manuscript:

Pan, Y., Laber, E., Smith, M., Zhao, Y. (2018+). Reinforced risk prediction with budget constraint: application to electronic health records data.

Installation
------------

``` r
install.packages("devtools")
devtools::install_github("Yinghao-Pan/reinforcedPred")
```
