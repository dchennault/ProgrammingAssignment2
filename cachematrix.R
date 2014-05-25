## makeCacheMatrix() sets and gets global variables for a matrix and its inverse
## cacheSolve() returns the inverse of the matrix stored in a makeCacheMatrix() instance
## testSolve() is a function to test makeCacheMatrix() and cacheSolve() and to
## provide a simple example of their use

## makeCacheMatrix(x = matrix()) contains 4 member functions to globally set and get
## a matrix "x" and its inverse

makeCacheMatrix <- function(x = matrix()) {
# initialize local storage for the inverse matrix
  invm <- NULL

# matrix set function to global storage x
  set <- function(y) {
    x <<- y
    invm <<- NULL
  }

# matrix get function returning global storage x
  get <- function() x
  
# inverse matrix set to global storage invm
  setsolve <- function(inv) invm <<- inv
  
# inverse matrix get function returning global storage invm
  getsolve <- function() invm

# list of member functions
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)
}


## cacheSolve(x) will return the inverse matrix contained in x$get()
## if the inverse has previously been calculated it will return the previous
## result from x$getsolve()
## if the inv matrix result does not exist it will calculate the inverse,
## and store the result using x$setsolve() before returning the result

cacheSolve <- function(x, ...) {
## Return a matrix that is the inverse of matrix in x$get()
  im <- x$getsolve()

## result available, return result
  if(!is.null(im)) {
    message("getting cached inverse of x ...")
    return(im)
  }
  
## inv matrix result needs to be calculated, stored and returned
  mdata <- x$get()
  im <- solve(mdata, ...)
  x$setsolve(im)
  im
}

## testSolve() is a function to test makeCacheMatrix() and cacheSolve() and to
## provide a simple example of their use

testSolve <- function() {
#initialize a 3X3 test matrix  
  tm <- matrix(c(1,2,3, 0,1,4, 5,6,6 ), nrow = 3, ncol = 3, byrow = TRUE)

# initialize an instance of makeCacheMatix
  mcm <- makeCacheMatrix()

# pass the test matrix to the instance of makeCacheMatix using set
  mcm$set(tm)

# display the test matrix using get
  print(mcm$get())

# Solve for the inverse
  print(cacheSolve(mcm))

# Solve for the inverse
  print(cacheSolve(mcm)) # should return cached version

}