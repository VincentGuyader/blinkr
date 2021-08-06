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
                     # host="prod.immedia-semi.com",
                     user_agent ="iPhone 9.2 | 2.2 | 222",unique_id = "00000000-0000-0000-0000-000000000000"){
 POST(url = "https://rest-prod.immedia-semi.com/api/v5/account/login",
       add_headers(
         # "Host" = host ,
         "Content-Type"= "application/json"# ,
         # "Content-Disposition" = "form-data"
       ),
       body = list(
         "unique_id" = unique_id,
         "password" = password,
         "client_specifier" = user_agent,
         "email" = email
       )
       # ,verbose()
       ,encode = "json")-> out

  info <-  out %>%
    content()
  print(info)
  # %>%
  #  # rawToChar() %>%
  #  fromJSON()
 region <- info$account$tier
 token <- info$auth$token
 accountid <- info$account$account_id
 clientid <- info$account$client_id
 list(token=token, region = region, accountid = accountid, clientid = clientid)
}
