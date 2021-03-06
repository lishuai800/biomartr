context("Test: getGroups()")

test_that("The getGroups() interface works properly... test: archaea",{
    
    skip_on_cran()
    skip_on_travis() 
    testthat::equals(
        getGroups("archaea", db = "refseq"),
        c(
            "Archaeoglobi",
            "Crenarchaeota",
            "Halobacteria",
            "Methanobacteria",
            "Methanococci",
            "Methanomicrobia",
            "Thaumarchaeota",
            "Thermococci", "Thermoplasmata",
            "unclassified Archaea (miscellaneous)"
        )
    )
})

test_that("The getGroups() interface works properly... test: bacteria",{
    testthat::equals(
        getGroups("bacteria", db = "refseq"),
        c(
            "Acidithiobacillia",
            "Acidobacteriia",
            "Actinobacteria",
            "Alphaproteobacteria",
            "Aquificae",
            "Armatimonadetes",
            "Bacteroidetes/Chlorobi group",
            "Balneolia",
            "Betaproteobacteria",
            "Blastocatellia",
            "Candidatus Kryptonia",
            "Chlamydiae",
            "Chloroflexi",
            "Cyanobacteria/Melainabacteria group",
            "Deinococcus-Thermus",
            "delta/epsilon subdivisions",
            "Endomicrobia",
            "Fibrobacteres",
            "Firmicutes",
            "Fusobacteriia",
            "Gammaproteobacteria",
            "Gemmatimonadetes",
            "Kiritimatiellaeota",
            "Nitrospira",
            "Planctomycetes",
            "Spirochaetia",
            "Synergistia",
            "Tenericutes",
            "Thermodesulfobacteria",
            "Thermotogae",
            "unclassified Acidobacteria",
            "unclassified Bacteria (miscellaneous)",
            "unclassified Proteobacteria",
            "Verrucomicrobia",
            "Zetaproteobacteria"
        )
    )
})

test_that("The getGroups() interface works properly... test: fungi",{
    testthat::equals(
        getGroups("fungi", db = "refseq"),
        c(
            "Ascomycetes", "Basidiomycetes", "Other Fungi"
        )
    )
})


test_that("The getGroups() interface works properly... test: invertebrate",{
    testthat::equals(
        getGroups("invertebrate", db = "refseq"),
        c(
            "Flatworms", "Insects", "Other Animals", "Roundworms"
        )
    )
})


test_that("The getGroups() interface works properly... test: plant",{
    testthat::equals(
        getGroups("plant", db = "refseq"),
        c(
            "Green Algae", "Land Plants"
        )
    )
})


test_that("The getGroups() interface works properly... test: protozoa",{
    testthat::equals(
        getGroups("protozoa", db = "refseq"),
        c(
            "Apicomplexans", "Kinetoplasts", "Other Protists"
        )
    )
})

test_that("The getGroups() interface works properly... test: 
          vertebrate_mammalian",{
    testthat::equals(
        getGroups("vertebrate_mammalian", db = "refseq"),
        c(
            "Mammals"
        )
    )
})

test_that("The getGroups() interface works properly... 
          test: vertebrate_other",{
    testthat::equals(
        getGroups("vertebrate_other", db = "refseq"),
        c(
            "Amphibians", "Birds", "Fishes", "Reptiles"
        )
    )
})










