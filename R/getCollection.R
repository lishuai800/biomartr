#' @title Retrieve a Collection: Genome, Proteome, CDS, RNA, GFF, Repeat Masker, AssemblyStats
#' @description  Main collection retrieval function for an organism of interest.
#' By specifying the scientific name of an organism of interest a collection consisting of
#' the genome file, proteome file, CDS file, RNA file, GFF file, Repeat Masker file, AssemblyStats 
#' file of the organism of interest
#' can be downloaded and stored locally. Collections can be retrieved from 
#' several databases.
#' @param db a character string specifying the database from which the collection 
#' shall be retrieved:
#' \itemize{
#' \item \code{db = "refseq"}
#' \item \code{db = "genbank"}
#' \item \code{db = "ensembl"}
#' }
#' @param organism there are three options to characterize an organism: 
#' \itemize{
#' \item by \code{scientific name}: e.g. \code{organism = "Homo sapiens"}
#' \item by \code{database specific accession identifier}: e.g. \code{organism = "GCF_000001405.37"} (= NCBI RefSeq identifier for \code{Homo sapiens})
#' \item by \code{taxonomic identifier from NCBI Taxonomy}: e.g. \code{organism = "9606"} (= taxid of \code{Homo sapiens})
#' }
#' @param reference a logical value indicating whether or not a collection shall be downloaded if it isn't marked in the database as either a reference genome or a representative genome. 
#' @param path a character string specifying the location (a folder) in which 
#' the corresponding collection shall be stored. Default is 
#' \code{path} = \code{file.path("_db_downloads","collections")}.
#' @author Hajk-Georg Drost
#' @details Internally this function loads the the overview.txt file from NCBI:
#' 
#'  refseq: ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/
#' 
#'  genbank: ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/
#'  
#' and creates a directory '_ncbi_downloads/collection' to store
#' the genome of interest as fasta file for future processing.
#' In case the corresponding fasta file already exists within the
#' '_ncbi_downloads/collection' folder and is accessible within the workspace,
#' no download process will be performed.
#' @return File path to downloaded genome.
#' @examples \dontrun{
#' 
#' # download the collection of Arabidopsis thaliana from refseq
#' # and store the corresponding genome file in '_ncbi_downloads/collection'
#'  getCollection( db       = "refseq", 
#'              organism = "Arabidopsis thaliana", 
#'              path = file.path("_db_downloads","collections"))
#' }
#' 
#' @seealso \code{\link{getGenomeSet}}, \code{\link{getProteomeSet}}, \code{\link{getCDSSet}}, 
#' \code{\link{getGenome}}, \code{\link{getProteome}}, \code{\link{getCDS}}, 
#' \code{\link{getGFF}}, \code{\link{getRNA}}, \code{\link{meta.retrieval}}, 
#' \code{\link{read_genome}}
#' @export
getCollection <-
        function(db = "refseq",
                 organism,
                 reference = TRUE,
                 path = file.path("_db_downloads","collections")
        ) {
        
        new_name <- stringr::str_replace_all(organism," ","_")
        message("Starting collection retrieval (genome, proteome, cds, gff/gtf, rna, repeat masker, assembly stats) for ", new_name, " ...")
            
        org_exists <- is.genome.available(db = "refseq", organism, details = TRUE)   
        
        if (isFALSE(org_exists) || length(org_exists) == 0)
            stop("No entry was found for organism ",organism,". Could the name be misspelled?",  call. = FALSE)
        

        if (!file.exists(file.path(path, db, new_name)))
            dir.create(file.path(path, db, new_name), recursive = TRUE)
        
        path <- file.path(path, db, new_name)
        
        # retrieve genome assembly
        species_genome <-
                getGenome(
                        db = db,
                        organism = organism,
                        reference = reference,
                        path = path
                )
        message("\n")
        # retrieve proteome 
        species_proteome <-
                getProteome(
                        db = db,
                        organism = organism,
                        reference = reference,
                        path = path
                )
        
        message("\n")
        # retrieve coding sequences
        species_cds <-
                getCDS(
                        db = db,
                        organism = organism,
                        reference = reference,
                        path = path
                )
        message("\n")
        # retrieve corresponding gff file
        species_gff <-
                getGFF(
                        db = db,
                        organism = organism,
                        reference = reference,
                        path = path
                )
        message("\n")
        if (is.element(db, c("ensembl", "ensemblgenomes"))) {
                species_gtf <-
                        getGTF(
                                db = db,
                                organism = organism,
                                path = path
                        )
                message("\n")
        }
        
        # retrieve RNA
        species_rna <-
                getRNA(
                        db = db,
                        organism = organism,
                        reference = reference,
                        path = path
                )
        message("\n")
        
        if (is.element(db, c("refseq", "genbank"))) {
                # retrieve RepeatMasker output
                species_rm <-
                        getRepeatMasker(
                                db = db,
                                organism = organism,
                                reference = reference,
                                path = path
                        )
                message("\n")
                
                # retrieve assembly stats
                species_stats <-
                        getAssemblyStats(
                                db = db,
                                organism = organism,
                                reference = reference,
                                path = path
                        )
        }
        
        if (!file.exists(file.path(getwd(), path, "doc"))) {
                dir.create(file.path(getwd(), path, "doc"))
        }
        
        doc_files <- list.files(file.path(getwd(), path))
        file.remove(file.path(getwd(), path, doc_files[stringr::str_detect(doc_files, "md5checksums.txt")]))
        doc_files <- doc_files[stringr::str_detect(doc_files, "doc_")]
        file.rename(file.path(getwd(), path, doc_files),
                    file.path(getwd(), path, "doc", doc_files))
        
        doc_tsv <- doc_files[stringr::str_detect(doc_files, "[.]tsv")]
        
        if (is.element(db, c("refseq", "genbank"))) {
                tsv_file <-
                        readr::read_tsv(
                                file.path(getwd(), path, "doc", doc_tsv),
                                col_types = readr::cols(
                                        file_name = readr::col_character(),
                                        organism = readr::col_character(),
                                        url = readr::col_character(),
                                        database = readr::col_character(),
                                        path = readr::col_character(),
                                        refseq_category = readr::col_character(),
                                        assembly_accession = readr::col_character(),
                                        bioproject = readr::col_character(),
                                        biosample = readr::col_character(),
                                        taxid = readr::col_integer(),
                                        infraspecific_name = readr::col_character(),
                                        version_status = readr::col_character(),
                                        release_type = readr::col_character(),
                                        genome_rep = readr::col_character(),
                                        seq_rel_date = readr::col_date(format = ""),
                                        submitter = readr::col_character()
                                )
                        )
                
                
                message("Collection retrieval finished successfully!")
                message("\n")
                
        }
        
        if (is.element(db, c("ensembl", "ensemblgenomes"))) {
                tsv_file <-
                        readr::read_tsv(
                                file.path(getwd(), path, "doc", doc_tsv),
                                col_types = readr::cols(
                                        file_name = readr::col_character(),
                                        organism = readr::col_character(),
                                        database = readr::col_character(),
                                        download_data = readr::col_character(),
                                        assembly_name = readr::col_character(),
                                        assembly_date = readr::col_character(),
                                        genebuild_last_geneset_update = readr::col_character(),
                                        assembly_accession = readr::col_character(),
                                        genebuild_initial_release_date = readr::col_character()
                                )
                        )
                
                
                message("Collection retrieval finished successfully!")
                message("\n")
                
        }
        
        
        }







