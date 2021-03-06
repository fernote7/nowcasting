#' @title Kalman Smoother Diagonal
#' @description Kalman Smoother Diagonal
#' @param y xxx
#' @param A Matrix that update factors with VAR
#' @param C Matrix that combine factors to explain the transformed data.
#' @param Q Error variance in factor update.
#' @param R Error variance in explain data from factors
#' @param init_x xxx
#' @param init_V xxx
#' @param varagin xxx
#' @import matlab

kalman_smoother_diag <- function(y, A, C, Q, R, init_x, init_V, varagin){
  
  # y = t(xx);
  # A = AA;
  # C = CC;
  # Q = QQ;
  # R = RR;
  # init_x = initx;
  # init_V = initV;
  # varagin = list("model", 1:TT)
  
  os <- nrow(y)
  TT <- ncol(y)
  ss <- dim(A)[1]
  
  # parâmetros default
  model <- ones(1,TT)
  u <- NULL
  B <- NULL
  
  args = varagin
  nargs = length(args)
  
  for(i in seq(1, nargs, by = nargs-1)){
    if(args[i] == "model"){ model <- args[[i+1]]
    }else if(args[i] == "u"){ u <- args[[i+1]]
    }else if(args[i] == "B"){ B <- args[[i+1]]
    }
  }
  
  xsmooth <- zeros(ss, TT)
  Vsmooth <- zeros(ss, ss, TT)
  VVsmooth <- zeros(ss, ss, TT)
  
  # Forward pass
  resul <- kalman_filter_diag(y, A, C, Q, R, init_x, init_V, list("model", model, "u", u, "B", B))
  xfilt <- resul$x
  Vfilt <- resul$V
  VVfilt <- resul$VV
  loglik <- resul$loglik
  
  # Backward pass
  xsmooth[,TT] <- xfilt[,TT]
  Vsmooth[,,TT] <- Vfilt[,,TT]
  
  for(t in (TT - 1):1){
    m <- model[t+1]
    if(is.null(B)){
    
      resul <- smooth_update(xsmooth[,t+1], Vsmooth[,,t+1], xfilt[,t], Vfilt[,,t], 
                             Vfilt[,,t+1], VVfilt[,,t+1], A[,,m], Q[,,m], NULL, NULL)
      
      xsmooth[,t] <- resul$xsmooth
      Vsmooth[,,t] <- resul$Vsmooth
      VVsmooth[,,t+1] <- resul$VVsmooth
    
    }else{
      
      resul <- smooth_update(xsmooth[,t+1], Vsmooth[,,t+1], xfilt[,t], Vfilt[,,t], 
                             Vfilt[,,t+1], VVfilt[,,t+1], A[,,m], Q[,,m],  B[,,m], u[,t+1])
      
      xsmooth[,t] <- resul$xsmooth
      Vsmooth[,,t] <- resul$Vsmooth
      VVsmooth[,,t+1] <- resul$VVsmooth
      
    }
  }
  
  VVsmooth[,,1] <- zeros(ss,ss)
  
  list(xsmooth = xsmooth, Vsmooth = Vsmooth, VVsmooth = VVsmooth, loglik = loglik)
}