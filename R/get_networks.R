#' get_networks
#'
#' @param token
#' @param url
#' @param host
#'
#' @export
#' @import purrr
get_networks <- function(token=get_blink_api_token(),url="https://rest.prde.immedia-semi.com/networks",host ="prde.immedia-semi.com"){

  GET(url = url,
      add_headers(
        "Host" = host ,
        "TOKEN_AUTH"= token
      ),verbose()
      ,encode = "json"
  ) -> k4

  info2 <- content(k4)$networks %>% map(unlist) %>% map(data.frame) %>% map(t) %>%
    Reduce(rbind,.)

}
