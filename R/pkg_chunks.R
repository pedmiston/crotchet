#' @export
find_chunk_file <- function(name, package, inst_dir_name = "extdata") {
  find_extdata(name, ext = ".R", package = package, inst_dir_name = inst_dir_name)
}

#' @export
read_all_pkg_chunk_files <- function(package) {
  for (name in list_pkg_chunk_files(package, strip_ext = TRUE)) {
    read_pkg_chunk_file(name, package)
  }
}

#' @export
list_pkg_chunk_files <- function(package, strip_ext = FALSE) {
  list_extdata(package, re_files = "*.R", strip_ext = strip_ext)
}

#' @importFrom knitr read_chunk
#' @export
read_pkg_chunk_file <- function(name, package) {
  read_chunk(find_chunk_file(name, package))
}
