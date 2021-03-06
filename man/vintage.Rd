\name{vintage}
\alias{vintage}
\title{Real Time Data Base Extracted in 17/08/2017}
\description{Matrix time series containing:Exchange rate - Free - United States dollar (1); Interest rate - CDI (12); Vehicles production (1373); Credit Sales Index (1453); Retail sales (1455); Current economic conditions index (4394); Industrial production, general index (21859). }
\usage{data(vintage)}
\format{
  The format is:
 Time-Series [1:278, 1:7] from 1994 to 2018: 0.933 0.899 0.865 0.846 0.842 ...
 - attr(*, "dimnames")=List of 2
  ..$ : NULL
  ..$ : chr [1:7] "serie1" "serie12" "serie1373" "serie1453" ...
}

\examples{
# Select all time series
vintage
# Select only the first time series
vintage[,1]
}
\keyword{datasets}
