#' Returns a path to an image file included in the specified package.
#' @export
find_image <- function(name, package, inst_dir_name = "extdata") {
  if (missing(package)) {
    stopifnot(file.exists(name))
    return(tools::file_path_as_absolute(name))
  }
  find_extdata(name, ext = ".png", package = package, inst_dir_name = inst_dir_name)
}

#' List all graphviz files available in the specified package
#' @export
list_images <- function(package, strip_ext = TRUE) {
  list_extdata(package, re_files = "*.png$", strip_ext = strip_ext)
}

#' Read an image file from a full path or in a package.
#'
#' Reads png or jpg/jpeg files as grid::grob objects.
#'
#' @import magrittr
#' @export
read_image <- function(name, package, ...) {
  found <- find_image(name, package)

  readers <- list(
    png = png::readPNG,
    jpg = jpeg::readJPEG,
    jpeg = jpeg::readJPEG
  )
  ext <- tools::file_ext(found)
  reader <- readers[[ext]]

  found %>%
    reader() %>%
    grid::rasterGrob(...)
}

#' Draw an image file stored in a package with grid
#' @import magrittr
#' @export
draw_image <- function(name, package, ...) {
  grid::grid.newpage()
  read_image(name, package, ...) %>%
    grid::grid.draw()
}
