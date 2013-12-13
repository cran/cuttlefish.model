\name{two.stage.model.fit}
\alias{two.stage.model.fit}

\title{
Two-stage biomass model fitting function
}
\description{
The two.stage.model.fit function enables, using a vector of starting parameters, the observed abundance indices, the total landings and the optim function, the fitting of the two-stage biomass model to estimate the recruited biomass time series and the catchability of the 4 abundance index time series. The two-stage biomass model is fitted by minimimizing the sum of square residuals.
}
\usage{
two.stage.model.fit(to.fit, obs.fit, g.fit)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{to.fit}{
An object of class vector to give starting values of recruited biomass (B1) for each year and the 4 starting catchability values (one for each abundance index) in order to estimate the sum or square residuals. The two-stage biomass model to assess the English Channel cuttlefish stock was fitted using starting biomasses of 15000 tons for each year and log catchabilities of -9. The length of the vector equals the number of years plus 4 for the catchability of each survey and LPUE time series. 
}
  \item{obs.fit}{
An object of class data frame filled with the 4 observed abundance indices as columns. Columns must be called bts, cgfs, lpue.uk, lpue.fr for BTS and CGFS surveys, UK and French bottom trawl fleet LPUE respectively. Moreover, total landings of the 3 first quarters of the fishing season must be mentioned in a column called "L.Q341" and the total landings of the 4 quarters of each fishing season must be mentioned in a column named "L.Q3412".   
}
  \item{g.fit}{
The growth parameter. The common value currently used is -1.01. 
}
}
\value{
\item{sum.residuals}{The Sum of Square Residuals which is minimized by the optim function in order to fit the two-stage biomass model}
}
\references{
Gras, M., Roel, B. A., Coppin, F., Foucher, E. and Robin, J.-P. (2014). A two-stage biomass model to assess the English Channel cuttlefish (Sepia officinalis L.) stock. Submitted to ICES Journal of Marine Science.
}
\author{
Michael Gras and Jean-Paul Robin
}
%% ~Make other sections like Warning with \section{Warning }{....} ~
\note{
The development of the two-stage biomass model to assess the English Channel cuttlefish stock was carried out in the framework of the EU funded project CRESH (under the Interreg IV A France-Manche-England programme). The development of the R package to perform the routine assessment of the cuttlefish stock was co-funded by France Filiere Peche and by the Departement des Peches Maritimes et de l'Aquaculture. 
}
\seealso{
\code{\link{optim}}
}
\examples{
data(input.data)

#Abundance indices are re-scaled by dividing the time series by its mean
input.data$bts<-input.data$bts/mean(input.data$bts)
input.data$cgfs<-input.data$cgfs/mean(input.data$cgfs)
input.data$lpue.fr<-input.data$lpue.fr/mean(input.data$lpue.fr)
input.data$lpue.uk<-input.data$lpue.uk/mean(input.data$lpue.uk)

#Creation of a data frame filled with the year, the fishing season, 
#the abundance indices, the landings of the 3 first quarters of the 
#fishing season (used in the modelling of the UK LPUE) and the landings 
#of all the fishing season (used in the modelling of the french LPUE)
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

#Growth parameter
growth<--1.01

#Initial values for the fitting with 17 starting values for B1 
#(for the 17 years) and the 4 log values of the catchabilities
biom.init<-c(rep(15000,5),-9, -9, -9, -9)

#Fitting of the two-stage biomass model

result.optim<-optim(par=biom.init,fn=two.stage.model.fit, 
obs.fit=lpue.obs[1:5,], g.fit=-1.01, method = "BFGS",
control=list(maxit=99990,reltol=1e-9,trace=TRUE))

#Plot of the B1 time series
plot(x=input.data$year, y=result.optim$par[1:5], type='b', 
ylim=c(0, max(result.optim$par[1:5])), xlab="Years", 
ylab= "B1 estimation in tons of cuttlefish")

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
