# SraInAnVIL

The objective of this workspace is to work through a few concepts concerning
access to large public data resources using Bioconductor.  The primary motivation
is the introduction of the [recount3](https://bioconductor.org/packages/recount3) 
package to Bioconductor 3.13.  The recount3 project collects all the RNA-seq
data in NCBI Sequence Read Archive, processed by the [Rail-RNA](http://rail.bio) pipeline, and
summarized by [megadepth](https://github.com/LieberInstitute/megadepth).  There are
a number of different issues to confront:

- *metadata* about SRA contents: we'll use Sean Davis' [omicidx API](http://omicidx.cancerdatasci.org/docs/), 
capitalizing on the convenience of an R client, but other avenues exist
- *SummarizedExperiment* instances returned from recount3 are convenient
for working with selected experiments
- *a unified object store* for a large slice of RNA-seq experiments from SRA
is available for exploration as another strategy for conveying SRA content
to users efficiently.  This is based on the HDF Group's Highly Scalable Data Service.

