% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/enrichment_bar_plot.R
\name{enrichmentBarPlot}
\alias{enrichmentBarPlot}
\title{Enrichment bar plot}
\usage{
enrichmentBarPlot(enrich, 
top = 20,
main = paste("Significance, top", top, "categories"),
aRisk = 0.05,
sigDisplayQuantile = 0.95,
col = c("#BFCBD4", "#33ACFF"),
sigType = "q",
xlab = sigTypeTitle,
beside = TRUE, 
space = 0.1,
cex.names = 0.8,
border = NA,
las = 1,
...)
}
\arguments{
\item{enrich}{The enrichment data frame from which the plot will be created.}

\item{top=20}{The number of category for the plot.}

\item{main=paste("Significance, }{top", top, "categories") Allows to choose 
the title of the plot.}

\item{aRisk=0.05}{The alpha risk.}

\item{sigDisplayQuantile=0.95}{Quantile used to define the maximal value for
the Y-axis, based on a quantile.}

\item{col=c("#6699ff", "#ff5050")}{Palette of coloration for the plot 
Personnal coloration such as c("#FEE0D2","#FC9272") or a RColorBrewer such 
as brewer.pal(5,"Reds").}

\item{sigType="q"}{Allows to choose between Q-significance, P-significance
or E-significance.}

\item{xlab=sigTypeTtitle}{Allows to change the title of x-axis.}

\item{beside=TRUE}{Juxtaposing bar or not.}

\item{space=0.2}{Allows to change size bar.}

\item{cex.names=1}{Allows to change size of x-axis (flipped).}

\item{border=NA}{Allows to change the border of each bar.}

\item{las=1}{Allows to change the angle of label y-axis.}
}
\description{
Creates a barplot from the enrichment.
}
\examples{
data("enrichment_example", package = "ReMapEnrich")
enrichmentBarPlot(enrichment_example)

}
\author{
Martin Mestdagh
}
