### HEADER -----------------------------------------------------------------
#
# Author:        Daniel Leiria
# Copyright      Copyright 2024 - Daniel Leiria
# Email:         daniel.h.leiria@gmail.com
#
# Date:          2024-08-15
#
# Script Name:   example.1_desks_tables_production.R
#
# Description:   ***
#
#
#
### ------------------------------------------------------------------------

### ------------------------------------------------------------------------
# SETUP
### ------------------------------------------------------------------------

# Clears the console.
cat("\014")

# Remove all variables of the work space.
rm(list = ls())


### ------------------------------------------------------------------------
# LIBRARY
### ------------------------------------------------------------------------

# Data visualization (plots)
library(ggplot2)
# Data manipulation
library(dplyr)
# Linear programming
library(lpSolve)


### ------------------------------------------------------------------------
# WORKING DIRECTORY
### ------------------------------------------------------------------------

# Define the main directory where the analysis data and scripts are stored.
setwd(dirname("C:/Users/FV06XU/OneDrive - Aalborg Universitet/Pessoal/Leiria Workshop/Operations Research Courses/OR1 - Models and Applications/W2 - Linear Programming/Examples/example.1_desks_tables_production.R"))

# Ensure that the system language is set to English.
Sys.setenv(LANG = "en")

# Set all locale settings to English.
Sys.setlocale("LC_ALL", "English")


### ------------------------------------------------------------------------
# DECISION VARIABLES COEFFICIENTS
### ------------------------------------------------------------------------

## Set the coefficients of the decision variables
C <- c(700, 900)


### ------------------------------------------------------------------------
# CONSTRAINTS
### ------------------------------------------------------------------------

# Create constraint matrix A
A <- matrix(c(3, 5,
              1, 2,
              50, 20),
            nrow = 3,
            byrow = TRUE)

# Right hand side for the constraints
B <- c(3600, 1600, 48000)

# Direction of the constraints
constraints_direction  <- c("<=", "<=", "<=")


### ------------------------------------------------------------------------
# SOLVER
### ------------------------------------------------------------------------

# Find the optimal solution
optimum <-  lp(direction="max",
               objective.in = C,
               const.mat = A,
               const.dir = constraints_direction,
               const.rhs = B,
               all.int = FALSE)  # Linear solution with real numbers

# Print status: 0 = success, 2 = no feasible solution
print(optimum$status)

# Display the optimum values for x_1 and x_2
best_sol <- optimum$solution
names(best_sol) <- c("x_1", "x_2") 
print(best_sol)

# Check the value of objective function at optimal point
print(paste("Total cost: ", round(optimum$objval, digits = 2), sep=""))

# Check if all constraints are fulfilled
print(round(A %*% best_sol, digits = 2))







