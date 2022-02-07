#' Plot index (either W`*` or BRI`*`)
#' @param tib_morpho_index the table with morphological indexes values, resulting from a call to braidHymo().
#' @param index the index used (can be either "W*" or "BRI*". Defaults to "BRI*").
#' @param position the variable according to which estimates should be placed on graphic.
#' @param color the variable according to which estimates should be colored.
#' @param threshold the threshold for a section to be considered as braiding (defaults to "default", i.e. 0.004 if the index considered is BRI or 10 if the index considered is W*).
#' @return plot of index
#' @export
#' @examples
#' rivers=readr::read_csv("data-raw/rivers.csv") %>%
#'    dplyr::mutate(filepath=paste0("data-raw/",filepath)) %>%
#'    dplyr::mutate(year=as.factor(year))
#' result=braidHymo(rivers)
#' braidHymo_plot(result,index="BRI*", position=year, color=river)
#' braidHymo_plot(result,index="W*", position=year, color=river)
braidHymo_plot=function(tib_morpho_index,index="BRI*",position,color, threshold="default"){
  tib_plot=tib_morpho_index %>%
    dplyr::filter(type==index) %>%
    dplyr::select(-variable) %>%
    tidyr::pivot_wider(names_from="stat",
                       values_from="value") %>%
    dplyr::mutate(IC_min=mean-SD,
                  IC_max=mean+SD)
  # Set graphical parameters
  color=rlang::enquo(color)
  position=rlang::enquo(position)
  # Set threshold for braiding
  if(threshold=="default" & index=="BRI*"){threshold=0.004;type="<"}
  if(threshold=="default" & index=="W*"){threshold=10;type=">"}
  tib_threshold=tibble::tibble(threshold=threshold,
                               braiding=paste0("braiding: ",index,type,threshold))
  # Build plot
  p<- ggplot2::ggplot(data = tib_plot,
             ggplot2::aes(x = !!position, y =mean )) +
    ggplot2::geom_point(size = 3,
                        ggplot2::aes(col = !!color)) +
    ggplot2::geom_errorbar(ggplot2::aes(ymin = IC_min, ymax = IC_max, col=!!color),
                           width = 0.1, size = 0.5) +
    ggplot2::scale_linetype_manual(name = NULL, values = 4) +
    ggplot2::scale_y_continuous(index,
                                limits = c(min(tib_plot$IC_min),
                                           max(tib_plot$IC_max)))+
    ggplot2::geom_hline(data=tib_threshold,
                        ggplot2::aes(yintercept = threshold,
                                     linetype = braiding),
                        colour = 'black')

  return(p)
}

