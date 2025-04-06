library(ellmer)
# functions.R
if (!requireNamespace("chat", quietly = TRUE)) {
  stop("Package 'chat' not found. Install it first using devtools::install()")
}

# Function to get package functions from "chat"
get_functions_safe <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    return(NULL)  # Return NULL if package isn't installed
  }
  return(chat::get_package_functions(pkg))
}
