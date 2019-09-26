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
get_videos<- function(accountid,region,token=get_blink_api_token(),output_dir="export",host="prde.immedia-semi.com"){

  accountID <- accountid
  pageNum<-1

  for (pageNum in 1:1000){

    uri <-  glue::glue('https://rest-{region}.immedia-semi.com/api/v1/accounts/{accountID}/media/changed?since=2015-04-19T23:11:20+0000&page={pageNum}')

    GET(url = uri,
        add_headers(
          "Host" = host ,
          "TOKEN_AUTH"= token
        )
        # ,verbose()
        ,encode = "json"
    ) %>% content() -> response


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


     if (!file.exists(videoPath)){
      GET(url = videoURL,
          add_headers(
            "Host" = host ,
            "TOKEN_AUTH"= token
          )
          # ,verbose()
          ,encode = "json"
      ) ->k8
      message(videoPath)
      conn <- file(videoPath,"wb")
      writeBin(k8$content, conn)
      close(conn)
    }
    }
  }
  }

