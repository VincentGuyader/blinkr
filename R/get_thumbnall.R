#' @importFrom jpeg writeJPEG
#' @importFrom stringr str_split str_replace_all
get_thumbnails <-function(camera,token=get_blink_api_token(),output_dir = "export",
           host = "prde.immedia-semi.com") {
    for (network in camera$networks) {
      network_id <-   network$network_id
      networkName <- network$name

      for (cc in network$cameras) {
        cameraName <- cc$name
        cameraId <- cc$id
        uri = glue::glue(
          "https://rest-{region}.immedia-semi.com/network/{network_id}/camera/{cameraId}"
        )

        cam <- GET(
          url = uri,
          add_headers("Host" = host ,
                      "TOKEN_AUTH" = token)
          # ,verbose()
          ,
          encode = "json"
        ) %>% content()


        cameraThumbnail = cam$camera_status$thumbnail

        # Create Blink Directory to store videos if it doesn't exist
        path <-
          file.path(output_dir, networkName, cameraName) %>% str_replace_all(" ", "")
        dir.create(path , recursive = TRUE, showWarnings = FALSE)

        thumbURL <- glue::glue("https://rest-{region}.immedia-semi.com{cameraThumbnail}.jpg")
        thumbPath <-
          file.path(
            path,
            glue::glue(
              "thumbnail_{cameraThumbnail %>% str_split('/') %>% unlist() %>% rev() %>% .[1]}.jpg"
            )
          )
        if (!file.exists(thumbPath)) {
          message(
            glue::glue(
              "Downloading thumbnail for {cameraName} camera in {networkName}."
            )
          )
          GET(
            url = thumbURL,
            add_headers("Host" = host ,
                        "TOKEN_AUTH" = token)
            # ,verbose()
            ,
            encode = "json"
          ) %>%
            content() %>%
            writeJPEG(target = thumbPath)
        }
      }
    }
  }
