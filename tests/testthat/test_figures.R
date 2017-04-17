# TODO: Create a fake package to run tests on!
#       Right now, tests depend on the totems package.
library(totems)

context("Finding graphviz figures")

test_that("find graphviz returns full path", {
  path <- find_graphviz("team-structures", package = "totems")
  expect_true(file.exists(path))
})

test_that("find graphviz fails if the file wasn't found", {
  expect_error(find_graphviz("not-a-real-file", package = "totems"))
})

test_that("find graphviz works if a full path is specified", {
  path_to_real_gv <- find_graphviz("team-structures", package = "totems")
  path <- find_graphviz(path_to_real_gv)
  expect_true(file.exists(path))
})

test_that("listing graphviz returns multiple results", {
  available <- list_graphviz("totems")
  expect_gt(length(available), 1)
})

test_that("listing graphviz strips extension", {
  no_ext <- list_graphviz("totems", strip_ext = TRUE)
  w_ext <- list_graphviz("totems", strip_ext = FALSE)
  expect_equal(grep("\\.gv", no_ext), integer(0))
  expect_gt(length(grep("\\.gv", w_ext)), 1)
})
