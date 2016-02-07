
SOLANUM_DB_L2Rlink1 <- list(tablename="genes", Lcolname="GID", Rcolname="_id")

SOLANUM_DB_AnnDbBimap_seeds <- list(
    list(
        objName="LYCOCYC",
        Class="AnnDbBimap",
        L2Rchain=list(
            SOLANUM_DB_L2Rlink1,
            list(
                tablename="lycocyc",
                Lcolname="_id",
                Rcolname="pathway_name"
            )
        ),
        direction=-1L
    ),
    list(
        objName="CHR",
        Class="AnnDbBimap",
        L2Rchain=list(
            SOLANUM_DB_L2Rlink1,
            list(
                tablename="gene_info",
                Lcolname="_id",
                Rcolname="chromosome"
            )
        )
    ),
    list(
        objName="ENZYME",
        Class="AnnDbBimap",
        L2Rchain=list(
            SOLANUM_DB_L2Rlink1,
            list(
                tablename="ec",
                Lcolname="_id",
                Rcolname="ec"
            )
        )
    ),
    list(
        objName="LYCOCYCENZYME",
        Class="AnnDbBimap",
        L2Rchain=list(
            SOLANUM_DB_L2Rlink1,
            list(
                tablename="enzyme",
                Lcolname="_id",
                Rcolname="enzyme"
            )
        )
    ),
    list(
        objName="GENENAME",
        Class="AnnDbBimap",
        L2Rchain=list(
            SOLANUM_DB_L2Rlink1,
            list(
                tablename="gene_info",
                Lcolname="_id",
                Rcolname="GENENAME"
            )
        )
    ),
    list(
        objName="UNIPROT",
        Class="AnnDbBimap",
        L2Rchain=list(
            SOLANUM_DB_L2Rlink1,
            list(
                tablename="uniprot",
                Lcolname="_id",
                Rcolname="UNIPROT"
            )
        )
    ),
    list(
        objName="ITAG",
        Class="AnnDbBimap",
        L2Rchain=list(
            SOLANUM_DB_L2Rlink1,
            list(
                tablename="itag",
                Lcolname="_id",
                Rcolname="ITAG"
            )
        )
    ),
    list(
        objName="SGN",
        Class="AnnDbBimap",
        L2Rchain=list(
            SOLANUM_DB_L2Rlink1,
            list(
                tablename="sgn",
                Lcolname="_id",
                Rcolname="SGN"
            )
        )
    )
)

createAnnObjs.SOLANUM_DB <- function(prefix, objTarget, dbconn, datacache)
{
    ## AnnDbBimap objects
    seed0 <- list(
        objTarget=objTarget,
        datacache=datacache
    )
    ann_objs <- AnnotationDbi:::createAnnDbBimaps(SOLANUM_DB_AnnDbBimap_seeds, seed0)

    ## Reverse maps
    ann_objs$ENZYME2ORF <- revmap(ann_objs$ENZYME, objName="ENZYME2ORF")
    ann_objs$LYCOCYC2ORF <- revmap(ann_objs$LYCOCYC, objName="LYCOCYC2ORF")
    ann_objs$SGN2ORF <- revmap(ann_objs$SGN, objName="SGN2ORF")
    ann_objs$ITAG2ORF <- revmap(ann_objs$ITAG, objName="ITAG2ORF")

    ann_objs$MAPCOUNTS <- AnnotationDbi:::createMAPCOUNTS(dbconn, prefix)

    AnnotationDbi:::prefixAnnObjNames(ann_objs, prefix)
}
