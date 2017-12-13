## Use Crossref to get the publisher given a set of DOIs
library(rcrossref)

## Load DOIs of interest
dataf = read.csv('scopus.csv', stringsAsFactors = FALSE)
dois = dataf$DOI
# TODO: empty DOIs end up as NULL list entries, so we can't just unlist() the results
dois = dois[dois != '']

## Retrieve metadata
metadata = cr_cn(dois, format = 'citeproc-json', 
                   .progress = 'text')

## Parse metadata
publishers = sapply(metadata, function(entry) entry$publisher)

results = data.frame(
    doi = dois,
    publisher = publishers
)

write.csv(results, path = 'publishers.csv')