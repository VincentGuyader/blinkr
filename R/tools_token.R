#' @title get_blink_api_token
#' @description  return the blinke api token
#' @param ask booleen do we have to ask if missing
#' @importFrom magrittr %>%
#' @importFrom  keyring key_set_with_value
#' @import keyring
#' @export
get_blink_api_token <- function(ask=TRUE){
  token <-NULL

  try(token<-key_get(service = "blink_api_token"),silent=TRUE)

  if ( is.null(token) & ask){
    delete_blink_api_token()
    token <- ask_blink_api_token()
    token %>% key_set_with_value(service = "blink_api_token",password = .)
  }
  token
}


#' @title set_blink_api_token
#' @description  set the blink api token
#' @param token blink api token
#' @importFrom magrittr %>%
#' @import assertthat
#' @export
set_blink_api_token <- function(token){

  if ( missing(token) ){
    token <- ask_blink_api_token()
  }
  if (is.null(token)){return(invisible(NULL))}

  delete_blink_api_token()
  assert_that(is.character(token))
  token %>% key_set_with_value(service = "blink_api_token",password = .)

  token
}

#' @title update_blink_api_token
#' @description  update the blinke api token
#' @importFrom magrittr %>%
#' @export
update_blink_api_token <- function(){
  delete_blink_api_token()
  ask_blink_api_token() %>%
    key_set_with_value(service = "blink_api_token",password = .)
}

#' @title delete_blink_api_token
#' @description  delete the blinke api token
#' @export
delete_blink_api_token <- function(){
  try(key_delete("blink_api_token"),silent=TRUE)
}


#' @title ask_blink_api_token
#' @param msg the message
#' @description  ask for the blinke api token
#' @import getPass
#' @export
ask_blink_api_token <- function (msg="blink api token")
{
  passwd <- tryCatch({
    newpass <- getPass::getPass(msg)
  }, interrupt = NULL)
  if (!length(passwd) || !nchar(passwd)) {
    return(NULL)
  }
  else {
    return(as.character(passwd))
  }
}

