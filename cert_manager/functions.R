
verify_db <- function(email, name) {
  
  DBI::dbConnect(
    RPostgres::Postgres(),
    user = Sys.getenv("db-username"),
    password = Sys.getenv("db-password"),
    host = Sys.getenv("db-host"),
    port = Sys.getenv("db-port"),
    dbname = Sys.getenv("db-dbname"),
    bigint = "integer") %>% 
    DBI::dbGetQuery(
      statement = glue::glue(
        "SELECT * 
        FROM inscritos
        WHERE email = {email}
        AND nome = {name}")) %>%
    tibble::as_tibble() -> query
  
  if(nrow(query) >= 1) {
    return(TRUE)
  } else {
    return(FALSE)
  }
  
}


send_to_s3 <- function(cert_path) {
  aws.s3::put_object(
    cert_path, 
    object = iniciais, 
    bucket = Sys.getenv("BUCKET_ARN"))
}


build_certificate <- function(email, name){
  dir <- glue::glue("{fs::file_temp()}.png")
  
  iniciais <- gsub('(?<=[A-Z])[^A-Z]+', '', nome, perl = TRUE)
  
  local <- "./img/cert_base.png"
  
  cert <- magick::image_read(local) %>%
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
  
  cert %>% 
    magick::image_write(dir)
  send_to_s3(dir, bucket = Sys.getenv("BUCKET_ARN"))
  
  
  cert
}