\name{fr.data.lpue}
\alias{fr.data.lpue}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Observed French Landings Per Unit Effort
}
\description{
The object fr.data.lpue stores generated Observed Landings Per Unit Effort which could be derived from commercial bottom trawl fleets. As real data are confidential, data presented in the example are generated data.
}
\usage{
data(fr.data.lpue)
}

\format{
The object fr.data.lpue is a data.frame made of 6 columns named year (calendar year), fishing.season (the fishing season during which the cuttlefish is exploited; a fishing season starts in July of a calendar year Y and ends in June of a calendar year Y+1), month (calendar month from January (1) to December (12)), rectangle (ICES rectangle code), power.class (power class of the trawler concerned). 

Each of the 9110 rows of the data frame refer to the fishing effort carried out during one cruise in one ICES rectangle.
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

data(fr.data.lpue)

fr.delta.glm<-delta.glm(input.data=fr.data.lpue)


par(mfrow = c(2,2))
#Histogram of the binomial error GLM residuals
hist(fr.delta.glm$binomial.residuals)

#Plot with the fitted data on the x axis and and the re
plot(fr.delta.glm$binomial.fit, fr.delta.glm$binomial.residuals)

#QQplot of the residuals from the binomial error GLM
qqnorm(fr.delta.glm$binomial.residuals)
qqline(fr.delta.glm$binomial.residuals)


par(mfrow = c(2,2))
#Histogram of the residuals from the Gaussian error GLM
hist(fr.delta.glm$gaussian.residuals)
	
#Plot of fitted values vs residuals from the Gaussian error GLM
plot(fr.delta.glm$gaussian.fit,fr.delta.glm$gaussian.residuals)
qqnorm(fr.delta.glm$gaussian.residuals)
qqline(fr.delta.glm$gaussian.residuals)

#Aggregation of the standardised LPUE per year. Aggregation 
#can be done on the 3 other factors in the same way.
fr.yearly.lpue<-aggregate(fr.delta.glm$predicted.lpue$st.lpue, 
list(fr.delta.glm$predicted.lpue$fishing.season), FUN="mean")
fr.yearly.lpue<-data.frame(c(1900:1905), fr.yearly.lpue)
colnames(fr.yearly.lpue)<-c("year","fishing.season","fr.st.lpue")



}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
