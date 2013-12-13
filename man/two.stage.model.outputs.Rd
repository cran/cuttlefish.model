\name{two.stage.model.outputs}
\alias{two.stage.model.outputs}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Two-stage biomass model output estimation
}
\description{
This function enables the estimation of the two-stage biomass model outputs using the time series of recruited biomass (B1), the catchability of BTS and CGFS surveys and the French and UK trawl fleets, the 4 abundance index time series collected by the BTS and CGFS surveys and the French and UK trawling fleets and the total landings (French and UK landings by all gear). 
}
\usage{
two.stage.model.outputs(B1, catchability, obs, g)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{B1}{
An object of class vector filled with the estimated recruited biomass (B1 in tons). The B1 time series can be estimated, using the observed abundance indices and the total landings, by running optim and two.stage.model.fit functions.
}
  \item{catchability}{
An object of class vector and length 4 filled with the log of the estimated catchabilities (negative values). Catchabilities must be filled in the following order: BTS, CGFS, UK and French fleets. 
}
  \item{obs}{
An object of class data frame filled with the 4 observed abundance indices as columns. Columns must be called bts, cgfs, lpue.uk, lpue.fr for BTS and CGFS surveys, UK and French bottom trawl fleet LPUE respectively. Moreover, total landings of the 3 first quarters of the fishing season must be mentioned in a column called "L.Q341" and the total landings of the 4 quarters of each fishing season must be mentioned in a column named "L.Q3412".   
}
  \item{g}{
A value of the growth parameter. The common value currently used is -1.01. 
}
}
\details{
Reminder : the fishing season starts on July of a year Y and ends in June of a year Y+1. For practical reasons, fishing seasons are numbered from 1 and the corresponding year mentioned is always the year of the beginning of the fishing season (starting from 1900).
}

\value{
The two.stage.model.outputs function returns a list with the following data frames
\item{observed}{A dataframe with the observed data. Calendar year and fishing seasons are mentioned in the two first columns. The 4 following columns are filled with the observed survey abundance indices and the LPUE. Finally the two last columns are filled with the landings of the 3 first quarters of the fishing season (L.Q341) and the 4 quarters of each fishing season (L.Q3412).
}
\item{sum.residuals}{The sum of square residuals.
}
\item{residuals.ssr}{A dataframe filled with the residuals of each abundance index time series computed as log([observed abundance indices]/[predicted abundance indices])^2
}
\item{residuals.mlh}{A dataframe filled with the raw residuals computed using the likelyhood method.
}
\item{residuals.raw}{A dataframe filled with the raw residuals computed as [observed abundance indices] - [predicted abundance indices]
}
\item{residuals.st}{A dataframe filled with the standardized residuals computed as ([raw residuals] - [mean(raw residuals)]) / SD([raw residuals])
}
\item{predicted.ai}{A data frame filled with the predicted abundance index time series.
}
\item{biomass}{A data frame filled with the estimated recruited biomass (B1), the estimated biomass in January (B.jan), the total landings per year (landings), the estimated exploitation rate (exp.rate) and the estimated Spawning Stock Biomass (B2).
}
}

\references{
Gras, M., Roel, B. A., Coppin, F., Foucher, E. and Robin, J.-P. (2014). A two-stage biomass model to assess the English Channel cuttlefish (Sepia officinalis L.) stock. Submitted to ICES Journal of Marine Science.
}

\author{
Michael Gras and Jean-Paul Robin
}
\note{
The development of the two-stage biomass model to assess the English Channel cuttlefish stock was carried out in the framework of the EU funded project CRESH (under the Interreg IV A France-Manche-England programme). The development of the R package to perform the routine assessment of the cuttlefish stock was co-funded by France Filiere Peche and by the Departement des Peches Maritimes et de l'Aquaculture. 
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{two.stage.model.fit}} and \code{\link{optim}}
}
\examples{

data(input.data)

lpue.obs<-data.frame(c(1900:1904), 
c(1:5), 
input.data$bts, 
input.data$cgfs, 
input.data$lpue.uk, 
input.data$lpue.fr, 
input.data$landings.q3 + input.data$landings.q4 + input.data$landings.q1, 
input.data$landings.q3 + input.data$landings.q4 + input.data$landings.q1 
+ input.data$landings.q2)
colnames(lpue.obs)<-c("year", "fishing.year", "bts","cgfs","lpue.uk",
"lpue.fr","L.Q341","L.Q3412")


#B1 time series estimated by the two.stage.model.fit and optim functions
B1.time.series<-c(13321.68, 15162.38, 10461.95, 23642.48, 15213.79)

#Catchabilities estimated by the two.stage.model.fit and optim functions
kq<-c(-9.699609, -9.955116, -9.974922, -9.578453)

#g parameter
growth<--1.01


two.stage.model.results<-two.stage.model.outputs(B1=B1.time.series, 
catchability=kq, obs=lpue.obs, g=growth)

two.stage.model.results

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
