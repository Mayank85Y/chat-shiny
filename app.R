library(shiny)
library(ellmer)
# Ensure the custom package "chat" is loaded
if (!requireNamespace("chat", quietly = TRUE)) {
  stop("Package 'chat' is not installed. Install it first.")
} else {
  library(chat)  # Load the package
}

# UI layout
ui <- fluidPage(
  titlePanel("R Package Function Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("package_name", "Enter Package Name:", value = "dplyr"),
      actionButton("fetch_btn", "Get Functions")
    ),
    
    mainPanel(
      h3("Available Functions"),
      verbatimTextOutput("function_output"),  # Correctly displays output
      textOutput("error_message")  # Handles errors gracefully
    )
  )
)

# Server
server <- function(input, output, session) {
  
  functions_list <- eventReactive(input$fetch_btn, {
    req(input$package_name)  
    
    package_name <- input$package_name
    
    # Try to get functions, handle errors
    result <- tryCatch({
      chat::get_package_functions(package_name)  # Call function
    }, error = function(e) {
      return(NULL)  # Return NULL if error occurs
    })
    
    if (is.null(result) || length(result) == 0) {
      return("Error: Package not found or no functions available.")
    }
    
    return(paste(result, collapse = "\n"))  # Format as a string with line breaks
  })
  
  output$function_output <- renderText({
    functions_list()
  })
}

# Run the Shiny App
shinyApp(ui = ui, server = server)
