#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

verify_db <- function(email) {
    
}

build_certificate <- function(email, name){
    #dir <- glue::glue("{fs::file_temp()}.png")
    
    #iniciais <- gsub('(?<=[A-Z])[^A-Z]+', '', nome, perl = TRUE)
    
    magick::image_read(local) %>%
        magick::image_annotate(text = nome,
                               size = 50,
                               location = "+700+800",
                               color = "black") %>% # Location might need some adjustments!!!
        magick::image_annotate(text = "1a Edicao - DEZ/2021", #Fill
                               size = 50, #Fill
                               location = "++", #Fill
                               color = "black") %>%
        magick::image_annotate(text = "", #Fill
                               size = 50, #Fill
                               location = "++", #Fill
                               color = "black")
        #magick::image_write(dir)
}

send_to_s3 <- function(cert) {}




# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    observeEvent(input$generate, {
        
        db_return <- verify_db()
        
        output$certificado <- build_certificate()
    })
    
    # output$distPlot <- renderPlot({
    # 
    #     # generate bins based on input$bins from ui.R
    #     x    <- faithful[, 2]
    #     bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # 
    #     # draw the histogram with the specified number of bins
    #     hist(x, breaks = bins, col = 'darkgray', border = 'white')
    # 
    # })

})
