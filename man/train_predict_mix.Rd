\name{train_predict_mix}

\alias{train_predict_mix}

\alias{begin.predmixcor}


\title{Classification rule based on Bayesian  mixture models with feature
       selection bias corrected}

\description{\code{train_redict.bayes} predicts the binary response based on high
	     dimemsional binary features modeled with Bayesian mixture  models. The
	     model is trained with Gibbs sampling. A smaller number of features can
	     be selected based on the correlations with the response. The bias due to
	     the selection procedure can be corrected. The software is written
	     entirely with R language. }

\usage{

train_predict_mix(
         test,train,k,
         theta0=0,alpha.shape=0.5,alpha.rate=5,no.alpha=30,
	 common.alpha=FALSE,no.alpha0=100,
         mc.iters=200,iters.labeltheta=10,
	 iters.theta=20,width.theta=0.1,
         correction=TRUE,no.theta.adj=30,approxim=TRUE,
         pred.start=100)

}

\arguments{

\item{test}{a binary test data, a matrix, i.e. the data for which we want to
	    predict the responses. The row stands for the cases. The first column is
	    the binary response, which could be NA if they are missing.} 


\item{train}{a training data, of the same format as \code{test}}

\item{k}{the number of features retained}

\item{theta0}{the prior of "theta" is uniform over (\code{theta0},
	      \code{1-theta0}) }

\item{alpha.shape}{the shape parameter of the Inverse Gamma, which is the prior
                   distribution of  "alpha"} 

\item{alpha.rate}{the rate parameter of the Inverse Gamma, as above}

\item{no.alpha}{the number of "alpha"'s used in mid-point rule, which is used to
		approximate the integral with respect to "alpha".} 

\item{common.alpha}{Indicator whether the parameter "alpha" for the response
		    (i.e "alpha0" in the reference) and the parameter "alpha"
		    for the features are the same. By default they are two
		    independent paramters with the same prior distribution, i.e,
		    \code{common.alpha=FALSE}.}

\item{no.alpha0}{the number of "alpha0"'s used in mid-point rule, which is used to
		approximate the integral with respect to "alpha0".. This parameter
		takes effect only when \code{common.alpha=FALSE}. Otherwise ``alpha''
		and ``alpha0'' are the same.} 


\item{mc.iters}{iterations of Gibbs sampling used to train the model.}


\item{iters.labeltheta}{In each Gibbs iteration, the combination of updating the 
			``labels'' once and updating the ``theta'' is repeated
			\code{iters.labeltheta} times, and then ``alpha'' and
			``alpha0'' are updated once.}


\item{iters.theta}{iterations of updating "theta" using M-H method.}

\item{width.theta}{the proposal distribution used to update "theta" with
		   Metropolis-Hastings method is uniform over the interval
		   (current "theta" +- \code{width.theta}).}

\item{correction}{Indicator whether the correction method shall be applied}


\item{no.theta.adj}{the parameter in Simpson's rule used to evaluate the integration
		    w.r.t. "theta", which is needed in calculating the adjustment
		    factor. The integrant is evaluated at 2*(\code{no.theta.adj})+1 
		    points. }  


\item{approxim}{Indicator whether the adjustment factor is ignored in 
		updating the labels (laten values). In theory it should be
		considered. However, it has little actual effect, but costs
		much computation, since we need to recompute the adjustment
		factor when updating the label of each case. By default,
		\code{approxim=TRUE}}

\item{pred.start}{The Markov chain iterations after \code{pred.start} will be used to
		  make Monte Carlo estimation} 

}

\value{

\item{prediction}{a matrix showing the detailed prediction result:  the 1st column
		  being the true responses,  the 2nd being the predicted responses, 
		  the 3rd being the predictive probabilities of class 1  and the 4th
		  being the indicator whether wrong prediction  is made.}

\item{aml}{the average minus log probabilities }

\item{error.rate}{the ratio of wrong prediction }

\item{mse}{the average square error of the predictive probabilities }

\item{summary.pred}{tabular display of the predictive probabilities 
                     and the actual fraction of class 1. }

\item{features.selected}{The features selected using correlation criterion}

\item{label}{the Markov chain samples of latent values, with each column for an
	     iteration. The number of rows of \code{label} is equal to the number of
	     training cases.}

\item{I1}{the number of ``1''s of features (columns) in those cases labeled by 
          ``1'', counted for each Markov chain iterations (row).}
	  
\item{I2}{Similar as \code{I1}, but for those cases labeled by ``2''.}

\item{N1}{a vector recording the number of cases labeled by ``1'' for each Markov 
          chain iteration.}
	  
\item{N2}{a vector recording the number of cases labeled by ``2'' for each Markov 
          chain iteration.}
	  
\item{theta}{Markov chain samples of ``theta". Each row is an iteration.}

\item{alpha}{a vector storing the Markov chain samples of ``alpha''.}

\item{alpha0}{a vector storing the Markov chain samples of ``alpha0''.}

\item{alpha_set}{all the possible values the ``alpha'' can take. The prior of 
		 ``alpha'' is approximated by the uniform over this set.}

\item{alpha0_set}{all the possible values the ``alpha0'' can take. The prior of 
		 ``alpha0'' is approximated by the uniform over this set.}

}

\references{   

	   \item{}{Li, L. (2007), Bayesian Classification and Regression with
	   High Dimensional Features, PhD thesis, University of Toronto,
	   available from http://math.usask.ca/~longhai.}
	   
	   \item{}{Li, L., Neal, R. M. (2007+), Avoiding Feature Selection Bias in
	   Bayesian Mixture Models, Manuscript in preparation.}

}	   	  

\examples{

#simulating data set from a Bayesian mixture model
data <- gendata.mix(20,20,50,50,101,10,c(0.9,0.1))

#training the model using Gibbs sampling, without correcting for the feature
#selection bias, then testing on predicting the responses of the test cases, 

uncor <- train_predict_mix(
            test=data$test,train=data$train,k=5,    
            theta0=0,alpha.shape=0.5,alpha.rate=5,no.alpha=5,
	    common.alpha=FALSE,no.alpha0=100,
            mc.iters=30,iters.labeltheta=1,
	    iters.theta=10,width.theta=0.1,
            correction=FALSE,no.theta.adj=5,approxim=TRUE,
            pred.start=10)

#As above, but with the feature selection bias corrected
cor <-   train_predict_mix(
            test=data$test,train=data$train,k=5,    
            theta0=0,alpha.shape=0.5,alpha.rate=5,no.alpha=5,
	    common.alpha=FALSE,no.alpha0=100,
            mc.iters=30,iters.labeltheta=1,
	    iters.theta=10,width.theta=0.1,
            correction=TRUE,no.theta.adj=5,approxim=TRUE,
            pred.start=10)

}

\seealso{\code{\link{gendata.mix}}}

\keyword{classif}



