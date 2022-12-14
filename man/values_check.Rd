% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/values_check.R
\name{values_check}
\alias{values_check}
\title{Values Check}
\usage{
values_check(DD.dict, verbose = TRUE)
}
\arguments{
\item{DD.dict}{Data dictionary.}

\item{verbose}{When TRUE, the function prints the Message out, as well as a list of variables that fail one of the values checks.}
}
\value{
Tibble, returned invisibly, containing: (1) Time (Time stamp); (2) Name (Name of the function); (3) Status (Passed/Failed); (4) Message (A copy of the message the function printed out); (5) Information (Details of which checks passed/failed for which value=meaning instances).
}
\description{
This function checks for potential errors in the VALUES columns by ensuring (1) required format of \code{VALUE=MEANING} (e.g., 0=Yes or 1=No); (2) no leading/trailing spaces near the equals sign; (3) all variables of TYPE encoded have VALUES entries; and (4) all variables with VALUES entries are listed as TYPE encoded.
}
\examples{
# Example 1: Fail check
data(ExampleE)
values_check(DD.dict.E)
print(values_check(DD.dict.E, verbose=FALSE))

# Example 2: Pass check
data(ExampleA)
values_check(DD.dict.A)
print(values_check(DD.dict.A, verbose=FALSE))
}
