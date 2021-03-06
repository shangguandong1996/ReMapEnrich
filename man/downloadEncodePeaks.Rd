% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/download_encode_peaks.R
\name{downloadEncodePeaks}
\alias{downloadEncodePeaks}
\title{Download ENCODE peaks}
\usage{
downloadEncodePeaks(id, targetDir, 
                           fileName = paste(id,".bed",sep=""),
                           force = FALSE, store = TRUE)
}
\arguments{
\item{targetDir}{The name of the directory to download the peaks in.}

\item{fileName=paste(id, ".bed", sep="")}{The name of the file to be created
after the downloaded peaks.}

\item{force=FALSE}{If FALSE (default), then no file is overwrited and the 
user is given confirmation message.}

\item{store=TRUE}{If TRUE (default) then a file is downloaded and written 
on the disk else it is only loaded as an R object.}
}
\value{
A data frame containing the genomic regions if store = FALSE else 
the path to the peaks file.
}
\description{
Download or import in a data frame an ENCODE set of peaks.
}
\examples{
encodeFile <- downloadEncodePeaks(id = "ENCFF001VCU",
                                  targetDir = "~/ReMapEnrich_demo/data/encode_peaks")
encodeGR <- bedToGranges(encodeFile)

}
\author{
Zacharie Menetrier
}
