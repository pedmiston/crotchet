#' Returns a path to a graphviz file included in the specified package.
#' @export
find_graphviz <- function(name, package, inst_dir_name = "extdata") {
  find_figure(name, ext = ".gv", package = package, inst_dir_name = inst_dir_name)
}

#' List all graphviz files available in the specified package
#' @importFrom tools file_path_sans_ext
#' @export
list_graphviz <- function(package, inst_dir_name = "extdata", strip_ext = TRUE) {
  extdata_dir <- system.file(inst_dir_name, package = package)
  gv_files <- list.files(extdata_dir, "*.gv", recursive = TRUE)
  if(strip_ext) gv_files <- tools::file_path_sans_ext(basename(gv_files))
  gv_files
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
