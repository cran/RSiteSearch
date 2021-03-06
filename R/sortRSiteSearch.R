sortRSiteSearch <- function(x, sort.=NULL) {
##
## 1.  PackageSummary
##
  x$Score <- as.numeric(as.character(x$Score))
  pkgSum <- PackageSummary(x, sort.)
##
## 2.  Sort order
##
  s0 <-  c('Count', 'MaxScore', 'TotalScore', 'Package',
           'Score', 'Function', 'Date', 'Description', 'Link')
  s0. <- tolower(s0)
  {
    if(is.null(sort.)) sort. <-  s0
    else {
      s1 <- match.arg(tolower(sort.), s0., TRUE)
      s1. <- c(s1, s0.[!(s0. %in% s1)])
      names(s0) <- s0.
      sort. <- s0[s1.]
    }
  }
##
## 3.  Merge(packageSum, x)
##
  packageSum <- pkgSum
  rownames(pkgSum) <- as.character(pkgSum$Package)
  pkgSum$Package <- NULL
  pkgS2 <- pkgSum[as.character(x$Package), , drop=FALSE]
  rownames(pkgS2) <- NULL
  Ans <- cbind(as.data.frame(pkgS2), x)
##
## 4.  Sort Ans by 'sort.'
##
  Ans.num <- Ans[, c('Count', 'MaxScore', 'TotalScore', 'Score')]
  ans.num <- cbind(as.matrix(Ans.num), Date=as.numeric(Ans$Date) )
  Ans.ch <- Ans[, c('Package','Function', 'Description', 'Link')]
  ans.ch <- as.data.frame(as.matrix(Ans.ch))
  ansKey <- cbind(as.data.frame(-ans.num), ans.ch)
#
  oSch <- do.call('order', ansKey[sort.])
  AnSort <- Ans[oSch,]
##
## 5.  attributes
##
  rownames(AnSort) <- NULL
#
#  attr(AnSort, "hits") <- hits
  attr(AnSort, 'PackageSummary') <- packageSum
#  attr(AnSort, 'string') <- string
#  attr(AnSort, "call") <- match.call()
  class(AnSort) <- c("RSiteSearch", "data.frame")
  AnSort
}
