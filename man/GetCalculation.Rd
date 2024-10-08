% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GetCalculation.R
\name{GetCalculation}
\alias{GetCalculation}
\title{Perform Calculations}
\usage{
GetCalculation(
  raw,
  meta,
  norm = FALSE,
  norm_ct,
  threshold_method = "stdv",
  time_skip = 5,
  sd_fold = 3,
  bg_fold = 3,
  rfu = 5000,
  cycle_background = 4,
  binw = 6
)
}
\arguments{
\item{raw}{Cleaned raw data matrix. Output from \code{CleanRaw()}.}

\item{meta}{Cleaned meta data. Output from \code{CleanMeta()}.}

\item{norm}{Logical. If TRUE, normalization will be performed. Default is FALSE.}

\item{norm_ct}{Sample name used to normalize calculation.}

\item{threshold_method}{Method for calculating threshold ('stdv', 'rfu_val', or 'bg_ratio').}

\item{time_skip}{Number of initial time points to skip when checking for threshold crossing.
This helps ignore early crossings that may be due to reasons unrelated to seeding activity.}

\item{sd_fold}{Fold of standard deviation to calculate the threshold for RAF (for 'stdv' method).}

\item{bg_fold}{Background fold for threshold calculation (for 'bg_ratio' method).}

\item{rfu}{Relative fluorescence unit values used for threshold (for 'rfu_val' method).}

\item{cycle_background}{The cycle number chosen as the background for RAF and MPR calculations.}

\item{binw}{Bin width for the MS calculation.}
}
\value{
A data frame containing the results of the calculation.
}
\description{
This function takes cleaned raw data and performs various analyses,
including calculating the time to threshold, Rate of Amyloid Formation (RAF), Max Point Ratio (MPR),
Max Slope (MS), and whether the reaction crosses the threshold (XTH).
}
\examples{
if (interactive()) {
GetCalculation(raw, meta, norm = TRUE, norm_ct = 'pos', 'stdv')
}
}
\references{
Henderson DM, Davenport KA, Haley NJ, Denkers ND, Mathiason CK, Hoover EA.
Quantitative assessment of prion infectivity in tissues and body fluids by real-time quaking-induced conversion.
J Gen Virol. 2015;96(Pt 1):210-219. doi:10.1099/vir.0.069906-0

Haley NJ, Van de Motter A, Carver S, et al. Prion-seeding activity in cerebrospinal fluid of deer with chronic wasting disease.
PLoS One. 2013;8(11):e81488. doi:10.1371/journal.pone.0081488

Rowden GR, Picasso-Risso C, Li M, Schwabenlander MD, Wolf TM, Larsen PA.
Standardization of Data Analysis for RT-QuIC-Based Detection of Chronic Wasting Disease. Pathogens.
2023;12(2):309. doi:10.3390/pathogens12020309
}
