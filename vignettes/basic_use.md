---
title: "ReMapEnrich: Basic usage"
author: "Martin Mestdagh, Zacharie Ménétrier"
date: "2019-05-03"
package: "ReMapEnrich"
vignette: >
    %\VignetteIndexEntry{ReMapEnrich-quick-tour}
    %\VignetteEncoding{UTF-8}
    %\VignetteEngine{knitr::rmarkdown}
output: 
    rmarkdown::html_document:  
        keep_md: true 
bibliography: 
    bibliography.bib
csl:
    biomed-central.csl
---



## Abstract

Current next generation sequencing studies generate a large variety of genomic regions ranging from regulatory regions with transcription factors or histone marks ChIP-seq to variant calls or coding/non-coding transcripts. Also, the number of complex catalogues from large-scale integrative efforts are increasing[@Cheneby:2018ix; @Griffon:2015en; @Ashoor:2015ey; @Amin:2015jm] and large sequencing projects[@RoadmapEpigenomicsConsortium:2015in; @ENCODEProjectConsortium:2012gc; @Fernandez:2016do].  

To facilitate the interpretation of functional genomics, epigenomics and genomics data we have developed a R-software package `ReMapEnrich` to identify significantly enriched regions from user defined catalogues. ReMapEnrich provide functions to import any in-house catalogue, automate and plot the enrichment analysis for genomic regions. 

## Quick example

This example is based on small datasets released with the `ReMapEnrich` package. 

It will go through the folowing steps. 

### Loading a minimal set of regions

- A **query set** of genomic regions (all the annotated SOX2 binidng regions on the chromosome 22).
- Load a (reduced) catalogue of reference genomic regions (all the annotated regions of the chromosome22). 



```r
# Load the ReMapEnrich library
library(ReMapEnrich) 

# Load the example dataset
query <- bedToGranges(system.file("extdata",
                                  "ReMap_nrPeaks_public_chr22_SOX2.bed",
                                  package = "ReMapEnrich"))

catalog <- bedToGranges(system.file("extdata",
                                    "ReMap_nrPeaks_public_chr22.bed",
                                    package = "ReMapEnrich"))
```

We now dispose of two genomic ranges object: `query` and `catalog`.

The query and catalog are both sets of genomic ranges, defined by attributes such as chromosome, start, end, strand. 

Notes 

- ChIP-seq genomic ranges are strand-insensitive, and therefore this field is left undefined (*). 
- In ReMap features, "ID" column indicates the name of the transcriptional regulator name, where  "regulator" is a generic concept covering transcription factor, insulator, chromatin remodelling factor, .... 




```r
# Check what the catalog contains
print(catalog)
#-- GRanges object with 98976 ranges and 2 metadata columns:
#--           seqnames            ranges strand |          id     score
#--              <Rle>         <IRanges>  <Rle> | <character> <numeric>
#--       [1]    chr22 16050049-16051598      * |        MBD4     -40.4
#--       [2]    chr22 16050111-16050193      * |       NCOR2    -100.1
#--       [3]    chr22 16050116-16051390      * |        BRD4    -14.14
#--       [4]    chr22 16050341-16051306      * |      NKX2-1    -100.1
#--       [5]    chr22 16050431-16051070      * |       FOXA1     -8.14
#--       ...      ...               ...    ... .         ...       ...
#--   [98972]    chr22 51239301-51239707      * |       SMAD1    -33.33
#--   [98973]    chr22 51239371-51239450      * |        E2F6    -100.1
#--   [98974]    chr22 51241809-51241892      * |      CTNNB1    -100.1
#--   [98975]    chr22 51241901-51241950      * |        KLF4    -33.33
#--   [98976]    chr22 51244211-51244331      * |       CEBPB     -50.5
#--   -------
#--   seqinfo: 1 sequence from an unspecified genome; no seqlengths

# Check what the query contains
print(query)
#-- GRanges object with 616 ranges and 2 metadata columns:
#--         seqnames            ranges strand |          id     score
#--            <Rle>         <IRanges>  <Rle> | <character> <numeric>
#--     [1]    chr22 16115696-16115821      * |        SOX2     -50.5
#--     [2]    chr22 16687711-16687815      * |        SOX2     -50.5
#--     [3]    chr22 16860611-16860784      * |        SOX2     -50.5
#--     [4]    chr22 16886641-16886785      * |        SOX2     -50.5
#--     [5]    chr22 16907901-16908105      * |        SOX2     -50.5
#--     ...      ...               ...    ... .         ...       ...
#--   [612]    chr22 49906161-49906442      * |        SOX2     -50.5
#--   [613]    chr22 50139461-50139586      * |        SOX2     -50.5
#--   [614]    chr22 50233306-50233435      * |        SOX2     -50.5
#--   [615]    chr22 51128401-51128513      * |        SOX2     -50.5
#--   [616]    chr22 51198171-51198471      * |        SOX2     -50.5
#--   -------
#--   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

As you can see, it is important for the catalogue to have proper IDs for each regions. All IDs found in the catalogue will be taken as a category and will be computed in enrichment analysis.
The IDs of the query will not be used for the rest of the enrichment analysis and can be ignored.

### Computing enrichment of intersections between the query and each entry of the catalogue


```r
enrichment.df <- enrichment(query, catalog, byChrom = TRUE)
#-- Computing intersections.
#-- Computing shuffles. May take time.
#-- Consider using parallelization with the 'nCores' parameter.
#-- Extracting enrichment.
head(enrichment.df)
#--         category nb.overlaps random.average mapped.peaks.ratio effect.size
#-- SOX2        SOX2         616      1.5000000         1.00000000    8.681824
#-- NANOG      NANOG         115      3.1666667         0.11782787    5.182525
#-- POU5F1    POU5F1          51      3.5000000         0.05290456    3.865070
#-- SMARCA4  SMARCA4          37      5.0000000         0.02786145    2.887525
#-- FOXH1      FOXH1          30      4.0000000         0.04279601    2.906891
#-- PRDM14    PRDM14           8      0.1666667         0.11111111    5.584963
#--         p.significance       p.value q.significance       q.value
#-- SOX2        1347.44262  0.000000e+00     1345.70634  0.000000e+00
#-- NANOG        133.82408 1.499418e-134      132.11998 7.586163e-133
#-- POU5F1        41.10551  7.843139e-42       39.43137  3.703618e-40
#-- SMARCA4       20.26978  5.373061e-21       18.62367  2.378644e-19
#-- FOXH1         16.93061  1.173244e-17       15.31083  4.888401e-16
#-- PRDM14        12.62822  2.353863e-13       11.03326  9.262673e-12
#--         e.significance       e.value
#-- SOX2        1345.32868  0.000000e+00
#-- NANOG        131.71013 1.949243e-132
#-- POU5F1        38.99157  1.019608e-39
#-- SMARCA4       18.15583  6.984979e-19
#-- FOXH1         14.81667  1.525217e-15
#-- PRDM14        10.51428  3.060022e-11
```

The option `byChrom` is set to TRUE as we are only working on one chromosome for this analysis.


### Format of the result table

The result comes as a data frame (`enrichment.df`) which contains all the features of the catalogue with their enrichment values.

1. **Category:**  identifier of the genomic features (regulators in our case) of the catalogue (ReMap here) showing significant overlap with the query. 

2. **Number of overlap:** number of overlaps between the query and each categories of the catalogue.

3. **Random average:**  mean number of overlaps between all the shuffles and the catalogue.

4. **Mapped peaks ratio:** percentage of covering of each categories of the catalogue by the query.

5. **Effect size:** log ratio between the observed and expected number of overlaps. ($d = log_{10} \frac{obs}{exp}$).  

6. **P-significance:** minus-logarithm of the p-value: $p_{sig} = -log_{10}(p)$, enabling to highlight the relevant order of magnitude on graphical representations (e.g. volcano plot). 

7. **P-value:** probability to observe an effect at least as extreme as the result, under null hypothesis, which can be interpreted as an estimation of the false positive rate (FPR). The p-value is computed with the Poisson distribution (and validated empirically with randomized query regions).

8. **Q-significance: ** minus-logarithm of the q-value: $q_{sig} = -log_{10}(q)$

9. **Q-value:** correction of the p-value to take into account the multiple testing (due to the fact that the query is compared to each regulator of the remap catalogue). The q-value is an estimation of the false discovery rate (FDR). Several multiple-testing correction methods are supported by `ReMapEnrich` (default: "BH" for Benjamini-Hochberg).

10. **E-significance:** minus-logarithm of the e-value: $q_{sig} = -log_{10}(E)$

11. **E-value:** expected number of false positives for a given p-value. 

### Statistical interpretation

The data frame is ordered by decreasing significance (`p.significance` column). Since it returns different overlap statistics, it is not obvious to interpret the results and to know which column should be considered.


#### Which statistics gives me an intuition of the enrichment?

The direct measure of enrichment is the `effect.size`, defined above as the log-ratio between observed and expected overlaps. Positive/negative values respectively indicate enrichment (more overlaps than expected by chance)  or empoverishment (less overlaps than expected by chance). Note that in  usual working conditions, the effect sizes are generally positive, but the same analysis could in principle be led to compare other region types.  

#### How much does my query cover the reference regions?

The column `mapped.peak.ratio` indicates the coverage, i.e. the fraction of regions annotated for the considered regulator that are covered by the query regions. 


#### Which statistics should be used to select significant overlaps?

This might be considered a matter of religion. Rather than promoting our own preference, `ReMapEnrich` returns different significance statistics, and lets you choose your preferred one. What really matters is to understand the nature of the information returned by each statistic.

- The `p.value` is the nominal p-value, computed for each catalogue entry (regulator) independently. It estimates the false positive rate (FPR), i.e. the proportion of tests (regulators) expected to pass the threshold by chance.  Since a single analysis may consist in several hundreds -- or even thousands -- of tests (one per regulator), setting a classical threshold $\alpha=0.05$ on the p-value would result in dozens or hundreds of false positives. We thus strongly recommend to set the threshold on either FDR or E-value. 

- The `e.value` indicates the expected number of false positives. Setting a threshold of $\alpha=0.05$ on this statistics is quite stringent, and thus increases the reliability of the results but this is at the cost of sensitivity. 

- The `q.value` indicates the false discovery rate (FDR) indicates the proportion of false positive results among those declared positive. Since the results are sorted by decreasing significance, the FDR found in a given row indicates the proportion of false positives that should be expected in all the results at least as significant as this one, i.e. among all the rows above this one (included). 


#### Which threshold should I choose on the significance?



### Biological interpretation of the results

It is interesting to give some hints about the biological relevance of the results. 


This kind of enrichment analysis could be interpreted as a co-location detector, as it will give the regulators showing a significant co-location with the query (SOX2 peaks on chromsome 22) in the reference genome (hg19 assembly).

SOX2, is a transcription factor essential to maintain self-renewal and pluripotency of undifferentiated embryonic stem cells.

- Not surprisingly, the most significant overlap for our query is the catalogue entries for SOX2. 

- The second hit is NANOG, a transcription factor critically involved in self-renewal of undifferentiated embryonic stem cells. 

- The third hit is Pou5f1, which forms a heterodimer with Sox2 and therefore co-occurs in most of its peaks. 

Chen et al (2008) showedd that Nanog peaks strongly overlap with Sox2 and Pou5f (also called Oct4). 

It is important to specify that this example is only relevant for the hg19 assembly. If any other assemblies are used, the parameter "chromSizes" should be acknowledged accordingly

This vignette will presents graphical representations of enrichment analysis that are implemented in this package.

## Graphical functions

Multiple graphical representations of enrichment analysis are implemented in this package.

### Bar plot

We can now display a bar plot which is the most basic representation of an enrichment analysis.


```r
# Display a bar plot
enrichmentBarPlot(enrichment.df, sigDisplayQuantile = 0.5, top = 20, aRisk = 0.00001)
```

![](basic_use_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

The displayed plot represents the most significant categories and their q-significances. The sigDisplayQuantile parameter allow to choose a quatile limit at which the bars will stop expanding. The values of those bars will be displayed on it.
The top parameter allow to choose how many categories you want to be displayed on the plot, and the aRisk represents the alpha risk that will be rescaled as the significance in order to see which categories reject the null hypothesis.

### Volcano plot

A volcano plot is a type of scatter-plot that is used to quickly identify changes in large data sets composed of replicate data. It plots significance versus fold-change on the y and x axes, respectively. As effect size in enrichment analysis is rarely negative you must expect the volcano plot to only expand in one direction.


```r
# Display a volcano plot (na.omit() is mandatory as there is NAs in the enrichment data frame).
enrichmentVolcanoPlot(na.omit(enrichment.df), sigDisplayQuantile = 0.9, aRisk = 0.00001)
```

![](basic_use_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

### Dot plot

The enrichment dot plot is a good way to compare various informations in the enrichment analysis. It gives hints about the number of overlaps, the mapped peaks ratio and the q-significance for the given number of categories.


```r
# Display a dot plot.
enrichmentDotPlot(enrichment.df)
```

![](basic_use_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

It should be interesting here to avoid representation of the SOX2 category as it enriched against itself in the chromosome 22.


```r
# Display a dot plot without SOX2.
enrichmentDotPlot(enrichment.df[enrichment.df$category != "SOX2",])
```

![](basic_use_files/figure-html/unnamed-chunk-7-1.png)<!-- -->


## References
