% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/download_remap_catalog.R
\name{downloadRemapCatalog}
\alias{downloadRemapCatalog}
\title{Download Remap catalogue}
\usage{
downloadRemapCatalog(targetDir, fileName = "nrPeaks_all.bed",
force = FALSE, store = TRUE)
}
\arguments{
\item{targetDir}{The name of the directory to download the catalogue in.}

\item{fileName="nrPeaks_all.bed.gz"}{The name of the file to be created 
after the downloaded catalogue.}

\item{force=FALSE}{If FALSE (default), then no file is overwrited and the
user is given confirmation message.}

\item{store=TRUE}{If TRUE (default) then a file is downloaded and written
on the disk else it is only loaded as an R object.}
}
\value{
A data frame containing the Remap genomic regions if store = FALSE
else the path to the catalog file.
}
\description{
Download or import in a data frame the Remap catalogue for 
 transcriptions factors.
}
\examples{
remapFile <- downloadRemapCatalog(targetDir = "~/roken_demo/data/ReMap")
remap <- bedToGranges(remapFile)

}
\author{
Zacharie Menetrier
}