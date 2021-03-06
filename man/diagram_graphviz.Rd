% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/graphviz.R
\name{diagram_graphviz}
\alias{diagram_graphviz}
\title{Read a graphviz figure from source using DiagrammeR.}
\usage{
diagram_graphviz(name, package, ...)
}
\arguments{
\item{name}{The name of the graphviz source file, without the
.gv extension.}

\item{package}{The name of the package where to find the graphviz
file.}

\item{...}{Optional arguments passed on to \code{\link{DiagrammeR::grViz}}.}
}
\description{
Read a graphviz figure from source using DiagrammeR.
}
