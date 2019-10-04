#' get_video
#'
#' @param accountid
#' @param region
#' @param token
#' @param output_dir
#' @param host
#' @importFrom stringr str_trim
#' @export
#'
get_videos_link<- function(accountid,region,token=get_blink_api_token(),output_dir="export",host="prde.immedia-semi.com",max_pages=1000){
  accountID <- accountid

  for (pageNum in seq_len(max_pages)){
    message(paste("pageNum",pageNum))
    uri <-  glue::glue('https://rest-{region}.immedia-semi.com/api/v1/accounts/{accountID}/media/changed?since=2015-04-19T23:11:20+0000&page={pageNum}')

    GET(url = uri,
        add_headers(
          "Host" = host ,
          "TOKEN_AUTH"= token
        )
        # ,verbose()
        ,encode = "json"
    ) %>% content() -> response

    out <- list()

    if (length(response$media)==0){break}
    for (video in response$media){

      address <- video$media
      timestamp <- video$created_at
      network <- video$network_name
      camera <- video$device_name
      camera_id <- video$camera_id
      deleted <- video$deleted
      videoTime <- timestamp

      videoURL <- glue::glue('https://rest-{region}.immedia-semi.com{address}')
      path <- file.path(output_dir,network,camera) %>% str_replace_all(" ","")
      dir.create(path,recursive = TRUE,showWarnings = FALSE)
      videoPath <-  file.path(path,glue::glue("{str_trim(camera)}_{make.names(videoTime)}.mp4"))
      # browser()

out[videoPath] <- videoURL


      # if (!file.exists(videoPath)){
      #   GET(url = videoURL,
      #       add_headers(
      #         "Host" = host ,
      #         "TOKEN_AUTH"= token
      #       )
      #       # ,verbose()
      #       ,encode = "json"
      #   ) ->k8
      #   message(videoPath)
      #   conn <- file(videoPath,"wb")
      #   writeBin(k8$content, conn)
      #   close(conn)
      # }
    }
  }
  message("done")
  out
}

