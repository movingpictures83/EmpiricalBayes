### R code from vignette source 'EBSeq_Vignette.Rnw'

###################################################
### code chunk number 1: EBSeq_Vignette.Rnw:172-173
###################################################
library(EBSeq)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
    pfix = prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }

}

run <- function() {}

output <- function(outputfile) {
GeneMat <- as.matrix(read.table(paste(pfix, parameters["csvfile", 2], sep="/"), sep=","))
Sizes <- readRDS(paste(pfix, parameters["rdsfile", 2], sep="/"))
if ("conditions" %in% rownames(parameters)) {
        Conditions <- readLines(paste(pfix, parameters["conditions", 2], sep="/"))
	Parti <- as.matrix(read.table(paste(pfix, parameters["parti", 2], sep="/"), sep=","))
if ("NGVector" %in% rownames(parameters)) {
	NgV <- readRDS(paste(pfix, parameters["NGVector", 2], sep="/"))
	print(nrow(GeneMat))
	print(ncol(GeneMat))
	print(Sizes)
EBOut=EBMultiTest(Data=GeneMat,NgVector=NgV,
Conditions=Conditions,AllParti=Parti,sizeFactors=Sizes, maxround=5)
}
else{
	print("A")
EBOut=EBMultiTest(GeneMat,NgVector=NULL,
Conditions=Conditions,AllParti=Parti,sizeFactors=Sizes, maxround=5)
}

}
else {
if ("NGVector" %in% rownames(parameters)) {
	NgV <- readRDS(paste(pfix, parameters["NGVector", 2], sep="/"))
EBOut=EBTest(Data=GeneMat,NgVector=NgV,
Conditions=as.factor(rep(c("C1","C2"),each=5)),sizeFactors=Sizes, maxround=5)
  }
else{
EBOut=EBTest(Data=GeneMat,
Conditions=as.factor(rep(c("C1","C2"),each=5)),sizeFactors=Sizes, maxround=5)
}
}
saveRDS(EBOut, outputfile)
}
