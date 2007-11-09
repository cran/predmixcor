\name{gendata.mix}

\alias{gendata.mix}

\title{Generate binary data with Bayesian mixture models}

\description{\code{gendata.mix} generates data (both training and test data) from
Bayesian mixture model. The prior distribution of "theta" is  uniform(0,1). The value
of "alpha" is given by argument \code{alpha}, which controls the the overall
relationship between the response and the predictor variables.}

\usage{

gendata.mix (n1,n2,m1,m2,p,alpha,prob.y=c(0.9,0.1))

}

\arguments{

\item{n1}{the number of class 1 in training data}

\item{n2}{the number of class 2 in training data}

\item{m1}{the number of class 1 in test data}

\item{m2}{the number of class 2 in test data}

\item{p}{the number of features}

\item{alpha}{a parameter controlling the dependency between the features and the
             response}

\item{prob.y}{a vector of two elements specifying the probabilities of the response
              being 1 in each group}	     

}

\value{

\item{train}{the training data, with the row standing for the cases and the
             first column being the response}

\item{test}{the test data, of the same format as "train"}

}

\seealso{

\code{\link{train_predict_mix}}

}

\keyword{datagen}
