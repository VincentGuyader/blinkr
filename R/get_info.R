#' getinfo
#'
#' @param email email
#' @param password password
#'
#' @export
#' @import httr
#' @importFrom magrittr %>%
#' @importFrom jsonlite fromJSON
get_info <- function(email,password,
                     host="prod.immedia-semi.com",
                     user_agent ="iPhone 9.2 | 2.2 | 222"){
 POST(url = "http://rest.prod.immedia-semi.com/login",
       add_headers(
         "Host" = host ,
         "Content-Type"= "application/json" ,
         "Content-Disposition" = "form-data"
       ),
       body = list(
         "password" = password,
         "client_specifier" = user_agent,
         "email" = email
       )
       # ,verbose()
       ,encode = "json")-> out

  info <-  out %>%
    content()
  # %>%
  #  # rawToChar() %>%
  #  fromJSON()
 region <- names(info$region)
 token <- info$authtoken$authtoken
 accountid <- info$account$id
 list(token=token, region = region, accountid = accountid)
}
