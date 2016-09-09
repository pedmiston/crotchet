# TODO: Create a fake package to run tests on!
#       Right now, tests depend on the evoteams package.
library(evoteams)

context("Finding graphviz figures")

test_that("find graphviz returns full path", {
  path <- find_graphviz("team-structure", package = "evoteams")
  expect_true(file.exists(path))
})

test_that("find graphviz fails if the file wasn't found", {
  expect_error(find_graphviz("not-a-real-file", package = "evoteams"))
})

test_that("listing graphviz returns multiple results", {
  available <- list_graphviz("evoteams")
  expect_gt(length(available), 1)
})

test_that("listing graphviz strips extension", {
  no_ext <- list_graphviz("evoteams", strip_ext = TRUE)
  w_ext <- list_graphviz("evoteams", strip_ext = FALSE)
  expect_equal(grep("\\.gv", no_ext), integer(0))
  expect_gt(length(grep("\\.gv", w_ext)), 1)
})
