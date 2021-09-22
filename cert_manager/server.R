#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dotenv)
library(magick)
library(tidyverse)
source("functions.R")


dotenv::load_dot_env("../.env")



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    observeEvent(input$generate, {
        
        db_return <- verify_db(input$emailInput)
        
        if(db_return) {
            output$status <- "Inscriçao Encontrada."
            output$certificado <- build_certificate()    
        } else {
            output$status <- "A combinaçao nome+email nao foi encontrada no Banco de Dados."
        }
        
    })
    
})
