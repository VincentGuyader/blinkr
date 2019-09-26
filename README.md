
<!-- README.md is generated from README.Rmd. Please edit that file -->

# blinkr

<!-- badges: start -->

<!-- badges: end -->

The goal of blinkr is to download all video from the amazon blink home
security system.

## Installation

You can install the released version of blinkr from github with:

``` r
remotes::install_github("vincentguyader/blinkr")
```

## Example

``` r
library(blinkr)
info <- get_info(email = "your@email.com",password = "password")
set_blink_api_token(token = info$token)
region <- info$region
accountid <-info$accountid

# info2 <- get_networks(token=token)

camera <- get_cameras(region = region)
get_thumbnails(camera = camera)
get_videos(accountid = accountid,region = region)
```
