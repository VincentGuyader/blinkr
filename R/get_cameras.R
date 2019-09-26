#' @export
#' @importFrom glue glue
get_cameras <- function(region,token=get_blink_api_token(),host="prde.immedia-semi.com"){

  uri <- glue::glue("https://rest-{region}.immedia-semi.com/api/v1/camera/usage")

  GET(url = uri,
      add_headers(
        "Host" = host ,
        "TOKEN_AUTH"= token
      ),verbose()
      ,encode = "json"
  ) %>% content()

}
