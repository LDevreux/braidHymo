#' Calculate morphological indexes multiple rivers or reaches
#' @param rivers a table containing river-related details.
#' @return a table of morphological indexes
#' @export
#' @examples
#' rivers=readr::read_csv2("data-raw/rivers.csv") %>%
#'    mutate(filepath=paste0("data-raw/",filepath))
#' braidHymo(rivers)
braidHymo=function(rivers,rel_path=""){
  result=rivers %>%
    dplyr::mutate(filepath=paste0(rel_path,filepath)) %>%
    dplyr::mutate(data=purrr::map(.x=filepath,
                                  .f=braidHymo_read)) %>%
    dplyr::mutate(data=purrr::pmap(list(rivdata=data,
                                        area=area,
                                        points_space=points_space),
                            .f=braidHymo_one)) %>%
    tidyr::unnest(cols=data)
  return(result)
}
