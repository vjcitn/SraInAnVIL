#' query omicidx API for studies based on lucene query
#' @import omicidxClientR
#' @import jsonlite
#' @import httr
#' @param luceneq character(1) query in lucene syntax
#' @param component character(1) API component to use, defaults to `StudiesSraStudiesGet`
#' @param size numeric(1) number of records to return, defaults to 10.
#' @param \dots passed to omicidxClientR::ExperimentsSraExperimentsGet
#' @note Queries for "nested" fields like organism within sample are handled in the third example.
#' Cursor information will be present in `obj` element of the return value.
#' @return list with S3 class `omicidx_qhits`, elements are hits, obj, query, time.
#' @examples
#' # example 1
#' x = query_metadata("cancer")
#' x
#' sapply(x$hits, "[[", "title")
#' # example 2 fix on RNA-seq
#' y = query_metadata('cancer AND library_strategy:"RNA-Seq"', 
#'    component="ExperimentsSraExperimentsGet")
#' table(sapply(y$hits, "[[", "library_strategy"))
#' # example 3 fix on RNA-seq in humans
#' yy =query_metadata('cancer AND library_strategy:"RNA-Seq" AND sample.organism:"Homo sapiens"',
#'   component="ExperimentsSraExperimentsGet", size=100)
#' table(sapply(yy$hits, function(x) x$sample[,"organism"]))
#' @export
query_metadata = function(luceneq, component = "StudiesSraStudiesGet", size=10, ...) {
 client = ApiClient$new(basePath="https://api.omicidx.cancerdatasci.org")
 inst = SRAApi$new(apiClient=client)
 ans = inst[[component]]( q = luceneq, size=size, ... )
 fin = list(hits=ans$hits, obj=ans, query=luceneq, time=Sys.time())
 class(fin) = "omicidx_qhits"
 fin
}

#' display hits from omicidx query
#' @param x instance of `omicidx_qhits`
#' @param \dots not used
#' @export
print.omicidx_qhits = function(x, ...) {
 cat(sprintf("omicidx response with %d hits.\n", length(x$hits)))
}
 
  
#' show endpoints for SRAApi
#' @export
SRAApiView = function() {
  client = ApiClient$new(basePath="https://api.omicidx.cancerdatasci.org")
  SRAApi$new(apiClient=client)
}
