% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ExampleP.R
\docType{data}
\name{ExampleP}
\alias{ExampleP}
\title{ExampleP}
\format{
\code{R data file} that contains a single object:
\describe{
\item{DS.data.P}{Data set}
}
}
\source{
\if{html}{\out{<div class="sourceCode">}}\preformatted{DS.path <- system.file("extdata", "DS_Example3b.txt", package = "dbGaPCheckup", mustWork=TRUE)
DS.data.P <- read.table(DS.path, header=TRUE, sep="\\t", quote="", as.is = TRUE)
save(DS.data.P, file = "ExampleP.rda")
}\if{html}{\out{</div>}}
}
\usage{
data(ExampleP)
}
\description{
Example data set with intentional errors.
}
