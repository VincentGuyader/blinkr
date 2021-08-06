#' Title
#'
#' @param pin
#' @param accountid
#' @param clientid
#' @param region
#' @param token
#'
#' @return
#' @export
#'
pin_verify <- function(pin,
                       accountid,clientid,region,
                       token=get_blink_api_token()

                       ){


  tt <- POST(url = glue::glue("https://rest-{region}.immedia-semi.com/api/v4/account/{accountid}/client/{clientid}/pin/verify"),
             add_headers(
               "TOKEN_AUTH" = token,
               "Content-Type"= "application/json"# ,
             ),


             body = list(
               "pin" = pin
             )
             ,verbose()
             ,

             encode = "json")
  tt
  tt %>% content()

}

