#' Read rivdata file
#' @param filepath path to rivdata file
#' @param ID_XS column corresponding to ID of cross-section in the file (defaults to ID_XS)
#' @param Z column corresponding the altitude in the file (defaults to Z)
#' @param NA.value value of missing values in the file (defaults to -9999)
#' @return
#' @export
#' @examples
#' braidHymo_read("data-raw/Drac_Chabottes_2018.txt")
#' braidHymo_read("data-raw/Durance_Brillanne_2017.txt")
braidHymo_read=function(file, ID_XS=ID, Z=RASTERVALU, NA.value=-9999, sep=";", row.names=1){
  ID=rlang::enquo(ID_XS)
  Z=rlang::enquo(Z)
  rivdata=read.csv(file, row.names=row.names,sep=sep) %>%
    dplyr::rename(ID_XS=!!ID,
                  Z=!!Z) %>%
    dplyr::filter(Z!=NA.value) %>%
    tibble::as_tibble() %>%
    dplyr::select(ID_XS,Z)
    return(rivdata)
}
