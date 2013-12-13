\name{input.data}
\alias{input.data}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Input data (4 abundance indices and total landings per quarter).
}
\description{
The object input.data is filled with observed survey abundance indices (derived from BTS and CGFS surveys), standardized Landings Per Unit Effort (LPUE) derived from French and UK bottom trawl fleets and total landings (French and UK landings by all gears) per quarter. 

As real data are confidential, all data presented in the example are generated data.
}
\usage{
data(fr.data.lpue)
}

\format{
The object input.data is a data frame made of 10 columns called year (calendar year) fishing.season (the fishing season during which the cuttlefish is exploited; a fishing season starts in July of the year Y and ends in June of the year Y+1), bts (abundance index derived from BTS survey carried out by Cefas each July in ICES division VIId), cgfs (abundance index derived from CGFS survey carried out by Ifremer each October in ICES division VIId), lpue.fr (abundance index derived from French bottom trawl LPUE estimated in the ICES divisions VIId and VIIe), lpue.uk (abundance index derived from UK beam trawl LPUE estimated in the ICES divisions VIId and VIIe), landings.q3, are the summer landings of the calendar year Y, landings.q4, are the autumn landings of the calendar year Y, landings.q1, are the winter landings of the calendar year Y+1, landings.q2 are the spring landings of the calendar year Y+1. 

Each of the 5 rows of the data frame refers to the data for one fishing season (a fishing season starts in July of the year Y and ends in June of the year Y+1). The calendar year refers to the recruitment year. 
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
\code{\link{delta.glm}} and \code{\link{optim}}
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
