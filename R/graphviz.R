#' Returns a path to a graphviz file included in the specified package.
#' @export
find_graphviz <- function(name, package, inst_dir_name = "extdata") {
  find_extdata(name, ext = ".gv", package = package, inst_dir_name = inst_dir_name)
}

#' List all graphviz files available in the specified package
#' @export
list_graphviz <- function(package, strip_ext = TRUE) {
  list_extdata(package, re_files = "*.gv$", strip_ext = strip_ext)
}

#' Read the graphviz files in a package as knitr chunks.
#' @export
read_all_graphviz_chunks <- function(package) {
  chunk_names <- list_graphviz(package, strip_ext = TRUE)
  for (name in chunk_names) {
    read_graphviz_chunk(name, package)
  }
}

#' Read a specific graphviz file as a knitr chunk.
#' @param name The name of the graphviz file to look for.
#' @param package The name of the package to search in.
#' @param new_name Optional. Specify the name of the chunk to load.
#'        Defaults to using the name of the file.
#' @importFrom knitr read_chunk
#' @export
read_graphviz_chunk <- function(name, package, new_name) {
  chunk_path <- find_graphviz(name, package)
  if (missing(new_name)) new_name <- name
  read_chunk(chunk_path, labels = new_name)
}

#' Read a graphviz figure from source using DiagrammeR.
#'
#' @param name The name of the graphviz source file, without the
#'   .gv extension.
#' @param package The name of the package where to find the graphviz
#'   file.
#' @param ... Optional arguments passed on to \code{\link{DiagrammeR::grViz}}.
#'
#' @import dplyr
#' @export
diagram_graphviz <- function(name, package, ...) {
  find_graphviz(name, package) %>%
    DiagrammeR::grViz(...)
}

#' Render a graphviz figure as svg and import it.
#' @import dplyr
#' @export
read_graphviz <- function(name, package, ...) {
  temp <- tempfile("diagrammer", fileext = ".svg")
  diagram_graphviz(name, package, ...) %>%
    DiagrammeRsvg::export_svg() %>%
    write(temp)
  read_svg(temp)
}

#' Read an svg figure in as a grob.
#' @import dplyr
#' @export
read_svg <- function(svg_file) {
  temp <- tempfile("grconvert", fileext = ".svg")
  grConvert::convertPicture(svg_file, temp)

  picture_grob <- grImport2::readPicture(temp) %>%
    grImport2::pictureGrob()

  file.remove(temp)

  picture_grob
}

#' Draw an svg file using grid.
#' @import dplyr
#' @import grid
#' @export
draw_svg <- function(svg_file) {
  grid.newpage()
  picture_grob <- read_svg(svg_file)
  grid.draw(picture_grob)
}

#' Draw a graphviz image using grid.
#' @import magrittr
#' @import grid
#' @export
draw_graphviz <- function(name, package, ...) {
  grid.newpage()
  read_graphviz(name, package, ...) %>% grid.draw()
}


#' Render a graphviz figure directly with the dot engine.
#' @import dplyr
#' @export
read_graphviz_with_images <- function(name, package, ...) {
  dot_source <- find_graphviz(name, package)

  # Render gv -> svg using dot
  temp1 <- tempfile("dot", fileext = ".png")
  system(paste("dot -Tpng -o", temp1, dot_source))

  # Read png in as a grob
  pictureGrob <- png::readPNG(temp1) %>%
    grid::rasterGrob()

  file.remove(temp1)

  pictureGrob
}

#' Draw a graphviz figure that has images in it with grid.
#' @import dplyr
#' @import grid
#' @export
draw_graphviz_with_images <- function(name, package, ...) {
  grid.newpage()
  read_graphviz_with_images(name, package, ...) %>% grid.draw()
}
