#' query omicidx API for studies based on lucene query
#' @import omicidxClientR
#' @import jsonlite
#' @import httr
#' @param luceneq character(1) query in lucene syntax
#' @param \dots passed to omicidxClientR::ExperimentsSraExperimentsGet
#' @examples
#' x = query_metadata("cancer")
#' str(httr::response(x))
#' @export
query_metadata = function(luceneq, size=10, ...) {
 client = ApiClient$new(basePath="https://api.omicidx.cancerdatasci.org")
 inst = SRAApi$new(apiClient=client)
 ans = inst$ExperimentsSraExperimentsGet( q = luceneq, size=size, ... )
 fin = list(hits=ans$hits, obj=ans, query=luceneq, time=Sys.time())
 class(fin) = "omicidx_qhits"
 fin
}

#' display hits from omicidx query
print.omicidx_qhits = function(x, ...) {
 cat(sprintf("omicidx response with %d hits.\n", length(x$hits)))
}
 
  

