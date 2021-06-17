library(MASS)

makeCacheMatrix <- function(x = matrix()){
                   inv <- NULL
                   set <- function(y){
                          x <<- y
                          inv <<- NULL
                   }
                   get <- function()x          # function to get the x matrix    
                   setInverse <- function(inverse) inv <<-inverse
                   getInverse <- function() {
                                            inver <- ginv(x)
                                            inver%*%x          # function to obtain the inverse of the matrix
                                            }
                   list(set = set, get = get, 
                        serInverse = setInverse, 
                        getInverse = getInverse)
}

## Get the cache data

cacheSolve <- function(x, ...) {
              inv <- x$getInverse()
              if(!is.null(inv)){
                  message("getting cached data")
                  return(inv)
              }
              mat <- x$get()
              inv <- solve(mat, ...)
              x$setInverse(inv)
              inv
}

## f <- makeCacheMatrix(matrix(1:8, 2,4))
## f#get()
## f#getInverse()
##cacheSolve(f)



