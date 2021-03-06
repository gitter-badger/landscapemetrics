% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lsm_p_circle.R
\name{lsm_p_circle}
\alias{lsm_p_circle}
\alias{lsm_p_circle.RasterLayer}
\alias{lsm_p_circle.RasterStack}
\alias{lsm_p_circle.RasterBrick}
\alias{lsm_p_circle.stars}
\alias{lsm_p_circle.list}
\title{CIRCLE (patch level)}
\usage{
lsm_p_circle(landscape, directions)

\method{lsm_p_circle}{RasterLayer}(landscape, directions = 8)

\method{lsm_p_circle}{RasterStack}(landscape, directions = 8)

\method{lsm_p_circle}{RasterBrick}(landscape, directions = 8)

\method{lsm_p_circle}{stars}(landscape, directions = 8)

\method{lsm_p_circle}{list}(landscape, directions = 8)
}
\arguments{
\item{landscape}{Raster* Layer, Stack, Brick or a list of rasterLayers.}

\item{directions}{The number of directions in which patches should be
connected: 4 (rook's case) or 8 (queen's case).}
}
\value{
tibble
}
\description{
Related Circumscribing Circle (Shape metric)
}
\details{
\deqn{CIRCLE = 1 - (\frac{a_{ij}} {a_{ij}^{circle}})}
where \eqn{a_{ij}} is the area in square meters and \eqn{a_{ij}^{circle}} the area of
the smallest circumscribing circle.

CIRCLE is a 'Shape metric'. The metric is the ratio between the patch area and the smallest
circumscribing circle of the patch. The diameter of the smallest circumscribing circle is
the 'diameter' of the patch connecting the opposing corner points of the two cells
that are the furthest away from each other. The metric characterises the compactness
of the patch and is comparable among patches with different area.

\subsection{Units}{None}
\subsection{Range}{0 <= CIRCLE < 1}
\subsection{Behaviour}{CIRCLE = 0 for a circular patch and approaches CIRCLE = 1 for
a linear patch.}
}
\examples{
lsm_p_circle(landscape)

}
\references{
McGarigal, K., SA Cushman, and E Ene. 2012. FRAGSTATS v4: Spatial Pattern Analysis
Program for Categorical and Continuous Maps. Computer software program produced by
the authors at the University of Massachusetts, Amherst. Available at the following
web site: http://www.umass.edu/landeco/research/fragstats/fragstats.html

Baker, W. L., and Y. Cai. 1992. The r.le programs for multiscale analysis of
landscape structure using the GRASS geographical information system.
Landscape Ecology 7: 291-302.
}
\seealso{
\code{\link{lsm_p_area}}, \cr
\code{\link{lsm_c_circle_mn}},
\code{\link{lsm_c_circle_sd}},
\code{\link{lsm_c_circle_cv}}, \cr
\code{\link{lsm_l_circle_mn}},
\code{\link{lsm_l_circle_sd}},
\code{\link{lsm_l_circle_cv}}
}
