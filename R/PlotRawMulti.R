#' Plot Multiple Samples from the Cleaned Raw Data
#'
#' @description The function visualizes the fluorescence over time for selected samples.
#' 
#' @param raw Cleaned raw data. Output from `GetCleanRaw`.
#' @param samples The names of the samples to plot.
#' @param legend_position Position of legend. Default is "topleft".
#' Choose from "bottomright", "bottom", "bottomleft", "left", "topleft", "top", "topright", "right" and "center".
#' @param ylim Numeric vector giving the y coordinate range (relative fluorescence units). If NULL (default), limits are computed from the data.
#' @param xlim Numeric vector giving the x coordinate range (hours). If NULL (default), limits are computed from the data.
#' @param custom_colors An optional vector of colors to be used for plotting. 
#'        If NULL (default), the function will use the original color scheme.
#' @param xlab Label for x-axis.
#' @param ylab Label for y-axis.
#' @param linetype The type parameter in plotting functions accepts various values to control the appearance of the plot: "p" draws only points, 
#' "l" creates lines, "b" combines both points and lines, "c" displays empty points joined by lines, "o" overplots points and lines, "s" and "S" create stair steps,
#'  "h" produces histogram-like vertical lines, and "n" sets up the plot without drawing any points or lines. For more detailed information on these options, 
#'  refer to the documentation of the plot function.
#' @importFrom graphics plot legend lines
#' @references 
#' Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole.
#' @examples
#' if (interactive()) {
#' PlotRawMulti(raw = raw, samples = samples)
#' }
#' @export
PlotRawMulti = function (raw, samples, legend_position = "topleft", 
                         xlim = NULL, ylim = NULL, custom_colors = NULL,
                         xlab = "Time (h)", ylab = "Fluorescence",
                         linetype = "l") {
  
  time = as.numeric(rownames(raw))
  original_colnames <- colnames(raw)
  data_copy <- raw
  for (i in seq_len(ncol(raw))) {
    if (is.character(raw[[i]])) {
      data_copy[[i]] <- as.numeric(raw[[i]])
    }
  }
  colnames(data_copy) <- original_colnames
  if (is.null(ylim)) {
    ymax = c()
    for (j in 1:length(samples)) {
      sel = grep(paste0("^", samples[j]), colnames(data_copy))
      if (length(sel) > 0) {
        ymax[j] = max(data_copy[, sel], na.rm = TRUE)
      }
    }
    ymax = if (length(ymax) > 0) 
      max(ymax)
    else 0
    ylim = c(0, ymax/0.8)
  }
  if (is.null(xlim)) {
    xlim = range(time, na.rm = TRUE)
  }
  sel = grep(paste0("^", samples[1]), colnames(data_copy))
  if (length(sel) > 0) {
    not_na_indices <- !is.na(data_copy[, sel[1]])
    plot(x = time[not_na_indices], y = data_copy[not_na_indices, 
                                                 sel[1]], type = linetype, col = if(is.null(custom_colors)) 1 else custom_colors[1], 
         ylim = ylim, xlim = xlim, 
         xlab = xlab, ylab = ylab)
    for (i in 2:length(sel)) {
      not_na_indices <- !is.na(data_copy[, sel[i]])
      lines(x = time[not_na_indices], y = data_copy[not_na_indices, 
                                                    sel[i]], type = linetype, col = if(is.null(custom_colors)) 1 else custom_colors[1])
    }
  }
  for (j in 2:length(samples)) {
    sel = grep(paste0("^", samples[j]), colnames(data_copy))
    if (length(sel) > 0) {
      for (i in 1:length(sel)) {
        not_na_indices <- !is.na(data_copy[, sel[i]])
        lines(x = time[not_na_indices], y = data_copy[not_na_indices, 
                                                      sel[i]], type = linetype, col = if(is.null(custom_colors)) j else custom_colors[j])
      }
    }
  }
  legend(legend_position, legend = samples, 
         col = if(is.null(custom_colors)) seq_len(length(samples)) else custom_colors[1:length(samples)], 
         lty = 1, cex = 0.8)
}