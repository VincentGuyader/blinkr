#' Title
#'
#' @param accountid
#' @param region
#' @param pid_file
#' @param token
#'
#' @return
#' @export
#'
#' @examples
trigger <- function(accountid,
                    region,
                    pid_file="blink.pid",
                    token=get_blink_api_token()){

  if (!file.exists(pid_file)){
    write("",file = pid_file)
    }

  ancien <- read_lines(file = pid_file)

  if (ancien != "") {
    avant <- ancien
  } else{
    avant <- 0
  }

  uri <-  glue::glue('https://rest-{region}.immedia-semi.com/api/v1/accounts/{accountid}/media/changed?since=2015-04-19T23:11:20+0000&page=1')


  GET(url = uri,
      add_headers(
        # "Host" = host ,
        "TOKEN_AUTH"= token
      )
      # ,verbose()
      ,encode = "json"
  ) %>% content() -> response
 maintenant <-  as.numeric(lubridate::ymd_hms(response$media[[1]]$created_at))
 write(maintenant,file = pid_file)

 resultat <- maintenant > avant

 message("avant ", avant)
 message("maintenant ", maintenant)
 message("resultat ", resultat)


 return(resultat)
}


# trigger(accountid = info$accountid,region = info$region)
