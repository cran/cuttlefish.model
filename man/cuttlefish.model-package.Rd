\name{cuttlefish.model-package}
\alias{cuttlefish.model-package}
\alias{cuttlefish.model}
\docType{package}
\title{Cuttlefish modelling}
\description{
The cuttlefish.model package was developed to provide a software application of the two-stage biomass model to assess the English Channel cuttlefish stock. Functions enable, first, the standardization of the Landings Per Unit Effort (LPUE) using the delta-GLM method. Then, 4 abundance indices, 2 derived from surveys and 2 derived from standardized LPUE, and total landings (by all gears) are used as input data to fit a two-stage biomass model and estimate the recruited biomass and the catchability of each abundance index time series.
}
\details{
\tabular{ll}{
Package: \tab cuttlefish.model\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2013-12-13\cr
License: \tab GPL\cr
LazyLoad: \tab yes\cr
}
Three functions and two datasets are provided in the cuttlefish.model package. First, the delta.glm function enables the LPUE standardization using the Delta-GLM method. An exemple using generated data stored in fr.data.lpue illustrates how to use this function. Then, the two.stage.model.fit function enables the fitting of the two-stage biomass model and provides an estimation of the recruited biomass on the one hand and of the 4 catchability coefficients on the other hand. An exemple using generated data stored in input.data illustrates how to fit the model. Finally, the two.stage.model.outputs function enables the estimation of the two-stage biomass model outputs using the recruited biomass and catchability estimations.
}
\author{
Michael Gras and Jean-Paul Robin

Maintainer: Michael Gras <michael.gras@ymail.com>
}
\references{
Gras, M., Roel, B. A., Coppin, F., Foucher, E. and Robin, J.-P. (2014). A two-stage biomass model to assess the English Channel cuttlefish (Sepia officinalis L.) stock. Submitted to ICES Journal of Marine Science.
}

\keyword{package}
