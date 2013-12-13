\name{delta.glm}
\alias{delta.glm}

\title{
LPUE standardisation using Delta-GLM method
}
\description{
The delta.glm function enables the standardization of observed Landings Per Unit Effort (LPUE) collected by commercial fishing vessels using the Delta-GLM methodology. It consists in a combination of a binomial error GLM  which explains the presence/absence of the stock and a Gaussian error GLM which explains the abundance of the resource. The standardization is performed using 4 explaining variables, the fishing season, the month, the ICES rectangle and the engine power of the vessel.}

\usage{
delta.glm(input.data)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{input.data}{
Must be filled with an object of class data frame with 4 explaining variables named "fishing.season", "month", "rectangle", "power.class" and one explained variable named "lpue". 
}
}
\details{
The 4 explaining variables ("fishing.season", "month", "rectangle", "power.class") can be either of class integer, character or factor. The explained variable "lpue" must be of class numeric and positive or null. The data frame can include more variables than the 5 mentioned above but they will not be used in the function. 
}
\value{
\item{binomial.glm}{Stores the result of the binomial error GLM}
\item{binomial.summary}{Stores the summary of the binomial error GLM}
\item{binomial.residuals}{Stores the residuals of the binomial error GLM}
\item{binomial.fit}{Stores the fitted values of the binomial error GLM}
\item{gaussian.glm}{Stores the result of the gaussian error GLM}
\item{gaussian.summary}{Stores the summary of the gaussian error GLM}
\item{gaussian.residuals}{Stores the residuals of the gaussian error GLM}
\item{gaussian.fit}{Stores the fitted values of the gaussian error GLM}
\item{predicted.lpue}{Stores the standardized LPUE for each quadruplet year, month, rectangle, power.class}

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
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{glm}}
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
