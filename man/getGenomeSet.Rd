% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getGenomeSet.R
\name{getGenomeSet}
\alias{getGenomeSet}
\title{Genome Retrieval of multiple species}
\usage{
getGenomeSet(
  db = "refseq",
  organisms,
  reference = FALSE,
  release = NULL,
  clean_retrieval = TRUE,
  gunzip = TRUE,
  update = FALSE,
  path = "set_genomes"
)
}
\arguments{
\item{db}{a character string specifying the database from which the genome
shall be retrieved:
\itemize{
\item \code{db = "refseq"}
\item \code{db = "genbank"}
\item \code{db = "ensembl"}
}}

\item{organisms}{a character vector storing the names of the organisms than shall be retrieved.
There are three available options to characterize an organism:
\itemize{
\item by \code{scientific name}: e.g. \code{organism = "Homo sapiens"}
\item by \code{database specific accession identifier}: e.g. \code{organism = "GCF_000001405.37"} (= NCBI RefSeq identifier for \code{Homo sapiens})
\item by \code{taxonomic identifier from NCBI Taxonomy}: e.g. \code{organism = "9606"} (= taxid of \code{Homo sapiens})
}}

\item{reference}{a logical value indicating whether or not a genome shall be downloaded if it isn't marked
in the database as either a reference genome or a representative genome.}

\item{release}{the database release version of ENSEMBL (\code{db = "ensembl"}). Default is \code{release = NULL} meaning
that the most recent database version is used.}

\item{clean_retrieval}{logical value indicating whether or not downloaded files shall be renamed for more convenient downstream data analysis.}

\item{gunzip}{a logical value indicating whether or not files should be unzipped.}

\item{update}{a logical value indicating whether or not files that were already downloaded and are still present in the 
output folder shall be updated and re-loaded (\code{update = TRUE} or whether the existing file shall be retained \code{update = FALSE} (Default)).}

\item{path}{a character string specifying the location (a folder) in which
the corresponding genomes shall be stored. Default is
\code{path} = \code{"set_genomes"}.}
}
\value{
File path to downloaded genomes.
}
\description{
Main genome retrieval function for a set of organism of interest.
By specifying the scientific names of the organisms of interest the corresponding fasta-files storing the genome of the organisms of interest
will be downloaded and stored locally. Genome files can be retrieved from several databases.
}
\details{
Internally this function loads the the overview.txt file from NCBI:

 refseq: ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/

 genbank: ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/

and creates a directory 'set_genomes' to store
the genomes of interest as fasta files for future processing.
In case the corresponding fasta file already exists within the
'set_genomes' folder and is accessible within the workspace,
no download process will be performed.
}
\examples{
\dontrun{
getGenomeSet("refseq", organisms = c("Arabidopsis thaliana", 
                                     "Arabidopsis lyrata", 
                                     "Capsella rubella"))
}

}
\seealso{
\code{\link{getProteomeSet}}, \code{\link{getCDSSet}},
\code{\link{getRNASet}}, \code{\link{getGFFSet}}, \code{\link{getCDS}},
\code{\link{getGFF}}, \code{\link{getGTF}}, \code{\link{getRNA}}, \code{\link{meta.retrieval}},
\code{\link{read_genome}}
}
\author{
Hajk-Georg Drost
}
