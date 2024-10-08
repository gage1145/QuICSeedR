% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GetReplicate.R
\name{GetReplicate}
\alias{GetReplicate}
\title{Generate Replicate Numbers for Plate Data}
\usage{
GetReplicate(plate)
}
\arguments{
\item{plate}{A matrix or data frame representing the plate layout, where each
cell contains a sample identifier or NA for empty wells.}
}
\value{
A data frame with the same dimensions as the input plate, where each
cell contains the replicate number for the corresponding sample in the
input plate.
}
\description{
This function takes a plate layout and generates a corresponding matrix of
replicate numbers for each sample.
}
\note{
\itemize{
\item Sample identifiers are converted to character type before processing.
\item The function assumes that the input plate is organized such that replicate
samples are encountered sequentially.
\item The output maintains the column names from the input plate.
}
}
\examples{
plate <- matrix(
  c("A", "B", "C",
    "A", "B", NA,
    "A", "C", "D"),
  nrow = 3, byrow = TRUE
)

replicates <- GetReplicate(plate)
print(replicates)


}
