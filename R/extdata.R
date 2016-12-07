#' Return a path to a file included in the specified package.
#' @export
find_extdata <- function(name, ext, package, inst_dir_name) {
  file <- paste0(name, ext)
  path <- system.file(inst_dir_name, file, package = package)
  if (!file.exists(path)) stop("File does not exist")
  path
}

#' List extdata files available in the specified package by type.
#' @export
list_extdata <- function(package, re_files, inst_dir_name = "extdata",
                         strip_ext = TRUE) {
  extdata_dir <- system.file(inst_dir_name, package = package)
  gv_files <- list.files(extdata_dir, re_files, recursive = TRUE)
  if(strip_ext) gv_files <- tools::file_path_sans_ext(basename(gv_files))
  gv_files
}
