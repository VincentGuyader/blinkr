#' Title
#'
#' @param videoPath
#' @param videoURL
#' @param token
#' @param host
#'
#' @export
#'
get_video<- function(videoURL,videoPath,
                     token=get_blink_api_token(),
                     host="prde.immedia-semi.com"){


  dir.create(dirname(videoPath),
             recursive = TRUE,showWarnings = FALSE)



if (!file.exists(videoPath)){
  GET(url = videoURL,
      add_headers(
        "Host" = host ,
        "TOKEN_AUTH"= token
      )
      # ,verbose()
      ,encode = "json"
  ) ->out
  message(videoPath)
  conn <- file(videoPath,"wb")
  writeBin(out$content, conn)
  close(conn)

  out <- list(response = out,
              path=videoPath,
              status_code=out$status_code)

}else{

  out <- list(
    response = "",
    path = videoPath,
    status_code = 999)
}
  out
}
