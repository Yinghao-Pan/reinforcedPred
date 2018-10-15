### create the example training data (high dimensional Z) ###

set.seed(1)

n <- 100                                    # number of subjects
nTotal <- 61                                # number of total time grid
ptsAll <- seq(0, 1, length = nTotal)        # time grid

## the scores ##
K <- 4                                      # number of eigen functions
lambda <- 0.75^(c(0,1,2,3))                 # score variances
ldings <- matrix(rnorm(n * K), nrow = n) %*% sqrt(diag(lambda))

## the basis functions ##
basis <- matrix(NA, nrow = nTotal, ncol = K)
basis[,1] <- 1
basis[,2] <- sqrt(3) * (2 * ptsAll - 1)
basis[,3] <- sqrt(5) * (6 * ptsAll^2 - 6 * ptsAll + 1)
basis[,4] <- sqrt(7) * (20 * ptsAll^3 - 30 * ptsAll^2 + 12 * ptsAll - 1)

sigmasquare <- 0.01                         # variance of the error term

## the X matrix ##
X <- matrix(NA, nrow = n, ncol = nTotal)
tildeX <- matrix(NA, nrow = n, ncol = nTotal)
for (i in 1:n) {
  X[i, ] <- basis %*% ldings[i,]
  tildeX[i, ] <- X[i, ] + rnorm(nTotal, mean = 0, sd = sqrt(sigmasquare))
}

## construct the label ##
# Z = (Z1, Z2, ..., Z50), Z1, ..., Z25 are bernoulli, Z26, ..., Z50 are normal distribution #
## assuming that P(Y = 1|X(t), t\in [0,1], Z) = \Phi(a_0 + a_1 * X(1) + a_2 * Z1) ##


Z1 <- rbinom(n, size = 1, prob = 0.6)
Z2 <- matrix(rbinom(n * 24, size = 1, prob = 0.6), nrow = n)
Z3 <- matrix(rnorm(n * 25), nrow = n)

Z <- cbind(Z1, Z2, Z3)

a0 = 0
a1 = -0.5
a2 = 0.5
Y <- as.numeric(runif(n) <= pnorm(a0 + a1 * X[ ,nTotal] + a2 * Z1))

## the X matrix with missing measurements: what we actually observed ##
tildeX.missing <- matrix(NA, nrow = n, ncol = nTotal)
for (i in 1:n) {
  ind <- c(1, sample(2:25, size = 9, replace = F), sample(26:nTotal, size = 10, replace = F))
  tildeX.missing[i, ind] <- tildeX[i, ind]
}

train_data_mulZ <- data.frame(Y = Y, tildeX.missing = tildeX.missing, Z = Z)


### create the example test data (high dimensional Z) ###

set.seed(1)

testn <- 2000                              # number of subjects

ldings <- matrix(rnorm(testn * K), nrow = testn) %*% sqrt(diag(lambda))

## the X matrix ##
test.X <- matrix(NA, nrow = testn, ncol = nTotal)
test.tildeX <- matrix(NA, nrow = testn, ncol = nTotal)
for (i in 1:testn) {
  test.X[i, ] <- basis %*% ldings[i,]
  test.tildeX[i, ] <- test.X[i, ] + rnorm(nTotal, mean = 0, sd = sqrt(sigmasquare))
}

## construct the label ##
## assuming that P(Y = 1|X(t), t\in [0,1], Z) = \Phi(a_0 + a_1 * X(1) + a_2 * Z1) ##

test.Z1 <- rbinom(testn, size = 1, prob = 0.6)
test.Z2 <- matrix(rbinom(testn * 24, size = 1, prob = 0.6), nrow = testn)
test.Z3 <- matrix(rnorm(testn * 25), nrow = testn)

test.Z <- cbind(test.Z1, test.Z2, test.Z3)

testY <- as.numeric(runif(testn) <= pnorm(a0 + a1 * test.X[ ,nTotal] + a2 * test.Z1))

## the X matrix with missing measurements: what we actually observed ##
test.tildeX.missing <- matrix(NA, nrow = testn, ncol = nTotal)
for (i in 1:testn) {
  ind <- c(1, sample(2:25, size = 9, replace = F), sample(26:nTotal, size = 10, replace = F))
  test.tildeX.missing[i, ind] <- test.tildeX[i, ind]
}

test_data_mulZ <- data.frame(testY = testY, test.tildeX.missing = test.tildeX.missing, test.Z = test.Z)

