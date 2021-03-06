% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FactorExtraction.R
\name{FactorExtraction}
\alias{FactorExtraction}
\title{Factor Extraction}
\usage{
FactorExtraction(x = NULL, q = NULL, r = NULL, p = NULL, A = NULL,
  C = NULL, Q = NULL, R = NULL, initx = NULL, initV = NULL,
  ss = NULL, MM = NULL, n.prevs = NULL)
}
\arguments{
\item{x}{Vintage transformada pela função \code{arrumarVintage}}

\item{q}{Dynamic rank. Number of error terms. If not specified q = 2.}

\item{r}{Static rank (r>=q), i.e. number of factors. If not specified r = 2.}

\item{p}{AR order of factors. If not specified p = 1.}

\item{A}{Matrix that update factors with VAR}

\item{C}{Matrix that combine factors to explain the transformed data.}

\item{Q}{Error variance in factor update.}

\item{R}{Error variance in explain data from factors}

\item{initx}{Initial condition of factor in Kalman filter estimation.}

\item{initV}{Initial condition of factor variance}

\item{ss}{Standard deviation in transformed data.}

\item{MM}{Mean in transformed data.}

\item{n.prevs}{Number of quarter previsions ahead.}
}
\description{
Extract factors from a data set of time series.
}
