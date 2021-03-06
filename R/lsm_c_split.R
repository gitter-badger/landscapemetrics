#' SPLIT (class level)
#'
#' @description Splitting index (Aggregation metric)
#'
#' @param landscape Raster* Layer, Stack, Brick or a list of rasterLayers.
#' @param directions The number of directions in which patches should be
#' connected: 4 (rook's case) or 8 (queen's case).
#'
#' @details
#' \deqn{SPLIT = \frac{A^2} {\sum \limits_{j = 1}^{n} a_{ij}^2}}
#' where \eqn{a_{ij}} is the patch area in square meters and \eqn{A} is the
#' total landscape area.
#'
#' SPLIT is an 'Aggregation metric'. It describes the number of patches if all patches of
#' class i would be divided into equally sized patches.
#'
#' \subsection{Units}{None}
#' \subsection{Range}{1 <= SPLIT <= Number of cells squared}
#' \subsection{Behaviour}{Equals SPLIT = 1 if only one patch is present. Increases as
#' the number of patches of class i increases and is limited if all cells are a patch}
#'
#' @seealso
#' \code{\link{lsm_p_area}},
#' \code{\link{lsm_l_ta}}, \cr
#' \code{\link{lsm_l_split}}
#'
#' @return tibble
#'
#' @examples
#' lsm_c_split(landscape)
#'
#' @aliases lsm_c_split
#' @rdname lsm_c_split
#'
#' @references
#' McGarigal, K., SA Cushman, and E Ene. 2012. FRAGSTATS v4: Spatial Pattern Analysis
#' Program for Categorical and Continuous Maps. Computer software program produced by
#' the authors at the University of Massachusetts, Amherst. Available at the following
#' web site: http://www.umass.edu/landeco/research/fragstats/fragstats.html
#'
#' Jaeger, J. A. 2000. Landscape division, splitting index, and effective mesh
#' size: new measures of landscape fragmentation.
#' Landscape ecology, 15(2), 115-130.
#'
#' @export
lsm_c_split <- function(landscape, directions) UseMethod("lsm_c_split")

#' @name lsm_c_split
#' @export
lsm_c_split.RasterLayer <- function(landscape, directions = 8) {

    result <- lapply(X = raster::as.list(landscape),
                     FUN = lsm_c_split_calc,
                     directions = directions)

    dplyr::mutate(dplyr::bind_rows(result, .id = "layer"),
                  layer = as.integer(layer))
}

#' @name lsm_c_split
#' @export
lsm_c_split.RasterStack <- function(landscape, directions = 8) {

    result <- lapply(X = raster::as.list(landscape),
                     FUN = lsm_c_split_calc,
                     directions = directions)

    dplyr::mutate(dplyr::bind_rows(result, .id = "layer"),
                  layer = as.integer(layer))
}

#' @name lsm_c_split
#' @export
lsm_c_split.RasterBrick <- function(landscape, directions = 8) {

    result <- lapply(X = raster::as.list(landscape),
                     FUN = lsm_c_split_calc,
                     directions = directions)

    dplyr::mutate(dplyr::bind_rows(result, .id = "layer"),
                  layer = as.integer(layer))
}

#' @name lsm_c_split
#' @export
lsm_c_split.stars <- function(landscape, directions = 8) {

    landscape <- methods::as(landscape, "Raster")

    result <- lapply(X = raster::as.list(landscape),
                     FUN = lsm_c_split_calc,
                     directions = directions)

    dplyr::mutate(dplyr::bind_rows(result, .id = "layer"),
                  layer = as.integer(layer))
}

#' @name lsm_c_split
#' @export
lsm_c_split.list <- function(landscape, directions = 8) {

    result <- lapply(X = landscape,
                     FUN = lsm_c_split_calc,
                     directions = directions)

    dplyr::mutate(dplyr::bind_rows(result, .id = "layer"),
                  layer = as.integer(layer))
}

lsm_c_split_calc <- function(landscape, directions) {

    area_landscape <- lsm_l_ta_calc(landscape, directions = directions)

    area_patch <- lsm_p_area_calc(landscape, directions = directions)

    split <- dplyr::mutate(area_patch, value = value ^ 2)

    split <- dplyr::mutate(dplyr::summarise(dplyr::group_by(split, class),
                                            value = sum(value)),
                           value = (area_landscape$value ^ 2) / value)

    tibble::tibble(
        level = "class",
        class = as.integer(split$class),
        id = as.integer(NA),
        metric = "split",
        value = as.double(split$value)
    )
}
