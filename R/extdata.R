#' Return a path to a file included in the specified package.
#' @export
find_figure <- function(name, ext, package, inst_dir_name) {
  figure_file <- paste0(name, ext)
  figure_path <- system.file(inst_dir_name, figure_file, package = package)
  if (!file.exists(figure_path)) stop("File does not exist")
  figure_path
}
