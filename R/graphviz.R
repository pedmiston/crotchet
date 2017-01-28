#' Returns a path to a graphviz file included in the specified package.
#' @export
find_graphviz <- function(name, package, inst_dir_name = "extdata") {
  find_extdata(name, ext = ".gv", package = package, inst_dir_name = inst_dir_name)
}

#' List all graphviz files available in the specified package
#' @export
list_graphviz <- function(package, strip_ext = TRUE) {
  list_extdata(package, re_files = "*.gv", strip_ext = strip_ext)
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
  temp1 <- tempfile("diagrammer", fileext = ".svg")
  diagram_graphviz(name, package, ...) %>%
    DiagrammeRsvg::export_svg() %>%
    write(temp1)

  temp2 <- tempfile("grconvert", fileext = ".svg")
  grConvert::convertPicture(temp1, temp2)

  pictureGrob <- grImport2::readPicture(temp2) %>%
    grImport2::pictureGrob()

  # remove temp files
  file.remove(temp1, temp2)

  pictureGrob
}

#' Draw a graphviz image using grid.
#' @import magrittr
#' @import grid
#' @export
draw_graphviz <- function(name, package, ...) {
  grid.newpage()
  read_graphviz(name, package, ...) %>% grid.draw()
}
