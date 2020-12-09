undef("select_region1")
function select_region1(region:string)
;;
;; Arguments
;;    region: a string specifying the region to be selected.
;;
;; Return value
;;    An array with the region boundary as (latmin, latmax, lonmin, lonmax)
;;    with the name of the region as a string attribute @name.
;;
;; Description
;;    Translates a region specification into lat/lon boundaries and a region
;;    name as an attribute.
;;
;; Modification history
;;    20141205-A_gott_kl: adjusted names to Righi et al. (2015).
;;    20140410-A_fran_fr: extended to midlat, equatorial and polar regions.
;;    20140129-A_fran_fr: written.
;;
local funcname, scriptname, verbosity, region
begin

    funcname = "select_region1"
    scriptname = "diag_scripts/lib/ncl/latlon.ncl"
    verbosity = stringtointeger(getenv("ESMValTool_verbosity"))
   ; enter_msg(scriptname, funcname, 10)

    if (region.eq."Global") then
        region_array = (/-90., 90., 0., 360./)
        region_array@name = "Glob"
        ;;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

    if (region.eq."Tropics") then
        region_array = (/-20., 20., 0., 360./)
        region_array@name = "Trop"
        ;;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

    if (region.eq."NH extratropics") then
        region_array = (/20., 90., 0., 360./)
        region_array@name = "NHext"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

    if (region.eq."SH extratropics") then
        region_array = (/-90., -20., 0., 360./)
        region_array@name = "SHext"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

    if (region.eq."NH equatorial") then
        region_array = (/0., 30., 0., 360./)
        region_array@name = "NHtrop"
        ;;;;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

    if (region.eq."SH equatorial") then
        region_array = (/-30., 0., 0., 360./)
        region_array@name = "SHtrop"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

    if (region.eq."Northern Hemisphere") then
        region_array = (/20., 90., 0., 360./)
        region_array@name = "NH"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

    if (region.eq."Southern Hemisphere") then
        region_array = (/-90., -20., 0., 360./)
        region_array@name = "SH"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

    if (region.eq."NH midlatitudes") then
        region_array = (/35., 60., 0., 360./)
        region_array@name = "NHmidlat"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

    if (region.eq."SH midlatitudes") then
        region_array = (/-60., -35., 0., 360./)
        region_array@name = "SHmidlat"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

    if (region.eq."Arctic") then
        region_array = (/60., 90., 0., 360./)
        region_array@name = "NHpolar"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

    if (region.eq."Antarctic") then
        region_array = (/-90., -60., 0., 360./)
        region_array@name = "SHpolar"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

    if (region.eq."Equatorial") then
        region_array = (/-10., 10., 0., 360./)
        region_array@name = "EQ"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

; Region latitudes and longitudes following Figure 9.38 Chapter 9 AR5
; (as Comunication from Chou Sin Chan)
;1- ENA Eastern North America
; Lon = 250 to 350
;Lat = 30 to 67

    if (region.eq."ENA") then
        region_array = (/30., 67., 250., 350./)
        region_array@name = "ENA"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if
;2- WNA Western North America
;Lon = 190 to 250
;Lat = 30 to 67

    if (region.eq."WNA") then
        region_array = (/30., 67., 190., 250./)
        region_array@name = "WNA"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

;3- CAM Central America
;Lon = 240 to 300
;Lat = 10 to 30
    if (region.eq."CAM") then
        region_array = (/10., 30., 240., 300./)
        region_array@name = "CAM"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if
;4- AMZ Amazon
;Lon = 277 to 329
;Lat = -20 to 10
    if (region.eq."TSA") then
        region_array = (/-20., 10., 277., 329./)
        region_array@name = "TSA"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if

;5- SSA Southern South America
;Lon = 277 to 329
;Lat = -56 to -20
    if (region.eq."SSA") then
        region_array = (/-56., -20., 277., 329./)
        region_array@name = "SSA"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if
;6- EUM Europe and Mediterranean
;Lon = 350 to 40
;Lat = 30 to 67
    if (region.eq."EUM") then
        region_array = (/30., 67., 350., 40./)
        region_array@name = "ENA"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if
;7- NAF Northern Africa
;Lon = 342 to 65
;Lat = 16 to 30
    if (region.eq."NAF") then
        region_array = (/16., 30., 342., 65./)
        region_array@name = "NAF"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if
;8- SAF South Africa
;Lon = 10 to 51
;Lat = -35 to -10
    if (region.eq."SAF") then
        region_array = (/-35., -10., 10., 51./)
        region_array@name = "SAF"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if
;9- CAF central Africa
;Lon = 342 to 60
;Lat = -10 to 16
    if (region.eq."CAF") then
        region_array = (/-10., 16., 342., 60./)
        region_array@name = "CAF"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if
;10- NAS Nothern Asia
;Lon = 40 to 167
;Lat = 48 to 67
    if (region.eq."NAS") then
        region_array = (/48., 67., 40., 167./)
        region_array@name = "NAS"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if
;11- EAS Eastern Asia
;Lon = 100 to 167
;Lat = 20 to 48
    if (region.eq."EAS") then
        region_array = (/20., 48., 100., 167./)
        region_array@name = "EAS"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if
;12- CAS Central Asia
;Lon = 40 to 100
;Lat = 30 to 48
    if (region.eq."CAS") then
        region_array = (/30., 48., 40., 100./)
        region_array@name = "CAS"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if
;13- SEA Southeast Asia
;Lon = 95 to 151
;Lat = -11 to 20
    if (region.eq."SEA") then
        region_array = (/-11.,20.,95., 151./)
        region_array@name = "SEA"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if
;14- SAS South Asia
;Lon = 65 to 95
;Lat = 5 to 30
    if (region.eq."SAS") then
        region_array = (/5., 30., 65., 95./)
        region_array@name = "SAS"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if
;15- AUS Oceania
;Lon = 112 to 180
;Lat = -48 to -11
     if (region.eq."AUS") then
        region_array = (/-48., -11., 112., 180./)
        region_array@name = "AUS"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
    end if
     if (region.eq."Arctic") then
        region_array = (/67.5,90.,0., 360./)
        region_array@name = "Arctic"
        ;leave _msg(scriptname, funcname, 10)
        return(region_array)
     end if


end
;***************************
; ----------------------------------------------------------
; Adam Phillips
;
undef("box_plot_cr")
function box_plot_cr (wks:graphic,x[*]:numeric,y[*][*]:numeric,boxOpts:logical,plotres:logical,lineres:logical)
;
;    This function creates a blank linLog plot object, on which box plots are created by extensive
;    use of gsn_add_polyline. The user can draw as many or as few box plots as they wish.
;    The plot is not drawn, and the frame is not advanced. May be used with gsn_panel. Missing data
; may be present in the input Y array, but not the input X array.
;    The function options are as follows:
;
;    wks     ----- The workstation
;    x[*]    ----- A one-dimensional array containing the X-axis values of where the box plot(s)
;                  will be drawn.
;    y[*][*] ----- A two-dimensional array, where the rightmost dimension contains the box plot
;               reference pt. data. y(n,0)=bottom_value, y(n,1)=bottom_value_of_box,
;               y(n,2)=mid-value_of_box,y(n,3)=top_value_of_box,y(n,4)=top_value
;    boxOpts ----- 2 options attached as attributes may be attached here.
;               boxWidth ---- Scalar or array that contains the widths of the boxes.
;               boxColors ---- Scalar or array that contains the colors that the boxes will be drawn in.
;                           Ex. boxOpts@boxColors =  (/"green","blue"/)
;                        If the number of colors specified does not equal the number of
;                        boxes drawn, only the first color specified will be used.
;    plotres ----- An optional xy-plot resource list. Will override defaults where applicable.
;    lineres ----- An optional resource list pertaining to the lines used to draw the boxes/lines.
;
;    Example call: plot3 = boxplot(wks,ntime,newyval,opti,res,False)
;               draw(plot3)
;               frame(wks)
;
begin
     dimquery = dimsizes(y)
     numbox = dimquery(0)
     boxWidths = new((/numbox/),float)
     if (numbox.ne.dimsizes(x)) then
        print("boxplot: Fatal: X must be one-dimensional and both X and Y must have the same rightmost dimension")
        exit
     end if
     if (any(ismissing(x))) then
        print("boxplot: Fatal: X array cannot contain missing data, exiting")
        exit
     end if

;    Developing x-axis
     xAxis = new(numbox+2,typeof(x))
     xAxis(1:numbox) = x
     if (numbox.ne.1) then
        dx = x(1)-x(0)
        xAxis(0) = x(0)-dx
        xAxis(numbox+1) = x(numbox-1)+dx
     else
        dx = 1
        xAxis(0) = x-dx
        xAxis(2) = x+dx
     end if

     if (boxOpts) then
        if (isatt(boxOpts,"boxWidth")) then
           if (dimsizes(boxOpts@boxWidth).ne.1.and.dimsizes(boxOpts@boxWidth).ne.numbox) then
              print("boxplot: Number of input box widths must either equal 1 or the number of boxes ("+numbox+"). Using first specified box width only.")
              boxWidths(:) = boxOpts@boxWidth(0)
           else
              boxWidths = boxOpts@boxWidth
           end if
        else
           boxWidths(:) = dx*.4
        end if
     else
        boxWidths(:) = dx*.4
     end if


     labarr = new(numbox+2,"string")         ;Prepare actual X-axis labels...
     labarr(0) = ""
     labarr(numbox+1) = ""
     labarr(1:numbox) = xAxis(1:numbox)

; Whether to maximize plot in frame.
     maximize = get_res_value(plotres,"gsnMaximize",False)

     if (plotres) then
;       print("Plot resources detected, accepting")
        fsatts = getvaratts(plotres)
        do ty = 0,dimsizes(fsatts)-1
           if (fsatts(ty).eq."tmXBLabels") then        ;Special section to test for XBLabels
              if (dimsizes(plotres@tmXBLabels).ne.numbox) then
                     print("boxplot: Fatal:Number of XB Labels does not match number of boxes, exiting")
                     exit
                  else
                     labarr(1:numbox) = plotres@$fsatts(ty)$
                  end if
                  xblab = plotres@tmXBLabels
                  delete(plotres@tmXBLabels)      ;Delete so tmXBLabels is not used when all
           end if                       ;atts are assigned below...
        end do
        delete(fsatts)
     end if
     ind_blue=plotres@ind_blue
     ind_red=plotres@ind_red
     ind_blue=ind_blue+1
     ind_red=ind_red+1
     plot = create "plot" logLinPlotClass wks
        "trYMinF" : min(y)-2
        "trYMaxF" : max(y)+2
        "trXMinF" : min(xAxis)
        "trXMaxF" : max(xAxis)
        "pmTickMarkDisplayMode" : "Always"
        "tmXBMode"   : "Explicit"
        "tmXBValues" : xAxis(ind_blue)
        "tmXBLabels" : labarr(ind_blue)
        "tmXBLabelFontHeightF" : 0.014
        "tmXBLabelAngleF"      : 90.
        "tmXBLabelJust"        : "TopRight"
        "tmXBLabelFontColor" : "blue"
        "tmYROn"  : False
        "tmXTOn"  : False
        "tmYRBorderOn" : True
        "tmXTBorderOn" : True
        "pmTitleDisplayMode": "Always"                   ; allow titles
        "tiMainOn"     : True
        "tiMainString"   : ""
     end create
     if (.not.all(ismissing(plotres@ind_red))) then
     plot1 = create "plot" logLinPlotClass wks
        "trYMinF" : min(y)-2
        "trYMaxF" : max(y)+2
        "trXMinF" : min(xAxis)
        "trXMaxF" : max(xAxis)
        "pmTickMarkDisplayMode" : "Always"
        "tmXBMode"   : "Explicit"
        "tmXBValues" : xAxis(ind_red)
        "tmXBLabels" : labarr(ind_red)
        "tmXBLabelFontHeightF" : 0.0105
        "tmXBLabelAngleF"      : 90.
        "tmXBLabelFontColor" : "red"
        "tmXBLabelJust"        : "TopRight"
        "tmYROn"  : False
        "tmXTOn"  : False
        "tmYRBorderOn" : True
        "tmXTBorderOn" : True
        "pmTitleDisplayMode": "Always"                   ; allow titles
        "tiMainOn"     : True
        "tiMainString"   : ""
     end create
     overlay(plot,plot1)
     end if

     if (plotres) then
        attsetvalues(plot,plotres)
     end if

     polyres = True                          ;Set up defaults
     polyres@gsLineColor       = "black"                     ; color of lines
     polyres@gsLineThicknessF  = 1.5                          ; thickness of lines
     polyres@gsLineDashPattern = 0
     if (lineres) then
        fsatts = getvaratts(lineres)
        do ty = 0,dimsizes(fsatts)-1
           polyres@$fsatts(ty)$ = lineres@$fsatts(ty)$
        end do
     end if

     if (boxOpts) then
        if (isatt(boxOpts,"boxColors")) then
           boxcolor = boxOpts@boxColors
           if (dimsizes(boxcolor).eq.1.or.dimsizes(boxcolor).ne.numbox) then
              if (dimsizes(boxcolor).ne.numbox) then
                 print("boxplot: warning: Number of input colors must either equal 1 or the number of boxes ("+numbox+"). Using first specified color only.")
              end if
              polyres@gsLineColor = boxcolor(0)
              cflag = 1
           else
              cflag = 2
           end if
        else
           cflag =1
        end if
     else
        cflag = 1
     end if

     dum = new((/numbox,9/),graphic)
     do gg = 0,numbox-1
        ff = xAxis(gg+1)
        if (cflag.eq.2) then
            polyres@gsLineColor = boxcolor(gg)
        end if
        yy = (/y(gg,4),y(gg,4)/)
        xx = (/(ff-(boxWidths(gg)/8.)),(ff+(boxWidths(gg)/8.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,0) = gsn_add_polyline(wks,plot,xx,yy,polyres)
    end if

        yy = (/y(gg,3),y(gg,4)/)
        xx = (/ff,ff/)
        polyres@gsLineDashPattern =0 
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,1) = gsn_add_polyline(wks,plot,xx,yy,polyres)
        end if
    polyres@gsLineDashPattern = 0

        yy = (/y(gg,3),y(gg,3)/)
        xx = (/(ff-(boxWidths(gg)/2.)),(ff+(boxWidths(gg)/2.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,2) = gsn_add_polyline(wks,plot,xx,yy,polyres)
    end if

        yy = (/y(gg,1),y(gg,3)/)
        xx = (/(ff-(boxWidths(gg)/2.)),(ff-(boxWidths(gg)/2.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,3) = gsn_add_polyline(wks,plot,xx,yy,polyres)
    end if

        yy = (/y(gg,2),y(gg,2)/)
        xx = (/(ff-(boxWidths(gg)/2.)),(ff+(boxWidths(gg)/2.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,4) = gsn_add_polyline(wks,plot,xx,yy,polyres)
    end if

        yy = (/y(gg,1),y(gg,3)/)
        xx = (/(ff+(boxWidths(gg)/2.)),(ff+(boxWidths(gg)/2.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,5) = gsn_add_polyline(wks,plot,xx,yy,polyres)
    end if

        yy = (/y(gg,1),y(gg,1)/)
        xx = (/(ff-(boxWidths(gg)/2.)),(ff+(boxWidths(gg)/2.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,6) = gsn_add_polyline(wks,plot,xx,yy,polyres)
    end if

        yy = (/y(gg,0),y(gg,1)/)
        xx = (/ff,ff/)
        polyres@gsLineDashPattern =0 
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,7) = gsn_add_polyline(wks,plot,xx,yy,polyres)
        end if
    polyres@gsLineDashPattern = 0

        yy = (/y(gg,0),y(gg,0)/)
        xx = (/(ff-(boxWidths(gg)/8.)),(ff+(boxWidths(gg)/8.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,8) = gsn_add_polyline(wks,plot,xx,yy,polyres)
        end if
 end do

     dumname = unique_string("dum")
     plot@$dumname$ = dum
     if (isvar("xblab").eq."True") then
        ;plotres@tmXBLabels =  
        plotres@tmXBLabels = xblab      ;reassign XBLabels for possible future plots
     end if
 if (maximize) then
    mres = True
    mres@gsnDraw  = False
    mres@gsnFrame = False
    maximize_output(wks,mres)
 end if
     return(plot)
end
; ------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------

; Adam Phillips
;
undef("box_plot_lg")
function box_plot_lg (wks:graphic,x[*]:numeric,y[*][*]:numeric,boxOpts:logical,plotres:logical,lineres:logical)
;
;    This function creates a blank linLog plot object, on which box plots are created by extensive
;    use of gsn_add_polyline. The user can draw as many or as few box plots as they wish.
;    The plot is not drawn, and the frame is not advanced. May be used with gsn_panel. Missing data
; may be present in the input Y array, but not the input X array.
;    The function options are as follows:
;
;    wks     ----- The workstation
;    x[*]    ----- A one-dimensional array containing the X-axis values of where the box plot(s)
;                  will be drawn.
;    y[*][*] ----- A two-dimensional array, where the rightmost dimension contains the box plot
;               reference pt. data. y(n,0)=bottom_value, y(n,1)=bottom_value_of_box,
;               y(n,2)=mid-value_of_box,y(n,3)=top_value_of_box,y(n,4)=top_value
;    boxOpts ----- 2 options attached as attributes may be attached here.
;               boxWidth ---- Scalar or array that contains the widths of the boxes.
;               boxColors ---- Scalar or array that contains the colors that the boxes will be drawn in.
;                           Ex. boxOpts@boxColors =  (/"green","blue"/)
;                        If the number of colors specified does not equal the number of
;                        boxes drawn, only the first color specified will be used.
;    plotres ----- An optional xy-plot resource list. Will override defaults where applicable.
;    lineres ----- An optional resource list pertaining to the lines used to draw the boxes/lines.
;
;    Example call: plot3 = boxplot(wks,ntime,newyval,opti,res,False)
;               draw(plot3)
;               frame(wks)
;
begin
     dimquery = dimsizes(y)
     numbox = dimquery(0)
     boxWidths = new((/numbox/),float)
     if (numbox.ne.dimsizes(x)) then
        print("boxplot: Fatal: X must be one-dimensional and both X and Y must have the same rightmost dimension")
        exit
     end if
     if (any(ismissing(x))) then
        print("boxplot: Fatal: X array cannot contain missing data, exiting")
        exit
     end if

;    Developing x-axis
     xAxis = new(numbox+2,typeof(x))
     xAxis(1:numbox) = x
     if (numbox.ne.1) then
        dx = x(1)-x(0)
        xAxis(0) = x(0)-dx
        xAxis(numbox+1) = x(numbox-1)+dx
     else
        dx = 1
        xAxis(0) = x-dx
        xAxis(2) = x+dx
     end if

     if (boxOpts) then
        if (isatt(boxOpts,"boxWidth")) then
           if (dimsizes(boxOpts@boxWidth).ne.1.and.dimsizes(boxOpts@boxWidth).ne.numbox) then
              print("boxplot: Number of input box widths must either equal 1 or the number of boxes ("+numbox+"). Using first specified box width only.")
              boxWidths(:) = boxOpts@boxWidth(0)
           else
              boxWidths = boxOpts@boxWidth
           end if
        else
           boxWidths(:) = dx*.4
        end if
     else
        boxWidths(:) = dx*.4
     end if


     labarr = new(numbox+2,"string")         ;Prepare actual X-axis labels...
     labarr(0) = ""
     labarr(numbox+1) = ""
     labarr(1:numbox) = xAxis(1:numbox)

; Whether to maximize plot in frame.
     maximize = get_res_value(plotres,"gsnMaximize",False)

     if (plotres) then
       print("Plot resources detected, accepting")
       print(plotres)
         fsatts = getvaratts(plotres)
        do ty = 0,dimsizes(fsatts)-1
           if (fsatts(ty).eq."tmXTLabels") then        ;Special section to test for XBLabels
                  print(plotres@tmXTLabels)
                  print(numbox) 
                  if (dimsizes(plotres@tmXTLabels).ne.numbox) then
                     ;print("boxplot: Fatal:Number of XB Labels does not match number of boxes, exiting")
                     delete(labarr)                      
                     labarr = new(dimsizes(plotres@tmXTLabels)+2,"string")         ;Prepare actual X-axis labels...
                     labarr(0) = ""
                     labarr(dimsizes(plotres@tmXTLabels)+1) = ""
                     labarr(1:dimsizes(plotres@tmXTLabels)) =plotres@$fsatts(ty)$ 
                    
 
                  else
                     labarr(1:numbox) = plotres@$fsatts(ty)$
                  end if
                  xblab = plotres@tmXTLabels
                  delete(plotres@tmXTLabels)      ;Delete so tmXBLabels is not used when all
           end if                       ;atts are assigned below...
        end do
        delete(fsatts)
     end if
     plot = create "plot" logLinPlotClass wks
        "trYMinF" :  -25 
        "trYMaxF" : 125
        "trXMinF" : 0.5
        "trXMaxF" : dimsizes(labarr)+0.5
        "pmTickMarkDisplayMode" : "Always"
        "tmXTMode"   : "Explicit"
        "tmXTValues" : ispan(0,dimsizes(labarr)-2,1) 
        "tmXTLabels" : labarr(1:)
        "tmYLMode"   : "Explicit"
        "tmYLValues" : (/5,25,50,75,95/)
        "tmYLLabels" : (/"5%","25%","50%","75%","95%"/) 
        "tmXTLabelFontColor" : "black"
        "tmYLOn"  : True
        "tmXBOn"  : False
        "tmXTOn"  : True
        "tmXBLabelsOn": False
        "tmXTLabelsOn": True
        "tmXTMinorOn" :False
        "tmXBMinorOn" :False
        "tmYLMinorOn" :False
        "tmXUseBottom": False
        "tmYRBorderOn" : False
        "tmXTBorderOn" : False
        "tmYLBorderOn" : False
        "tmXBBorderOn" : False
        "tmXTMajorLineColor"  : "Transparent"
        "tmYLMajorLineColor"  : "Transparent"
        "tmYLLabelFontHeightF" : 0.02
        "tmXTLabelFontHeightF" : 0.02   
        "pmTitleDisplayMode": "Always"                   ; allow titles
        "tiMainOn"     : True
        "tiMainString"   : ""
     end create

     if (plotres) then
        attsetvalues(plot,plotres)
     end if

     polyres = True                          ;Set up defaults
     polyres@gsLineColor       = "black"                     ; color of lines
     polyres@gsLineThicknessF  = 3.                          ; thickness of lines
     polyres@gsLineDashPattern = 0
     if (lineres) then
        fsatts = getvaratts(lineres)
        do ty = 0,dimsizes(fsatts)-1
           polyres@$fsatts(ty)$ = lineres@$fsatts(ty)$
        end do
     end if

     if (boxOpts) then
        if (isatt(boxOpts,"boxColors")) then
           boxcolor = boxOpts@boxColors
           if (dimsizes(boxcolor).eq.1.or.dimsizes(boxcolor).ne.numbox) then
              if (dimsizes(boxcolor).ne.numbox) then
                 print("boxplot: warning: Number of input colors must either equal 1 or the number of boxes ("+numbox+"). Using first specified color only.")
              end if
              polyres@gsLineColor = boxcolor(0)
              cflag = 1
           else
              cflag = 2
           end if
        else
           cflag =1
        end if
     else
        cflag = 1
     end if

     dum = new((/numbox,9/),graphic)
     do gg = 0,numbox-1
        ff = xAxis(gg+1)
        if (cflag.eq.2) then
            polyres@gsLineColor = boxcolor(gg)
        end if
        yy = (/y(gg,4),y(gg,4)/)
        xx = (/(ff-(boxWidths(gg)/8.)),(ff+(boxWidths(gg)/8.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,0) = gsn_add_polyline(wks,plot,xx,yy,polyres)
    end if

        yy = (/y(gg,3),y(gg,4)/)
        xx = (/ff,ff/)
        polyres@gsLineDashPattern =0
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,1) = gsn_add_polyline(wks,plot,xx,yy,polyres)
        end if
    polyres@gsLineDashPattern = 0

        yy = (/y(gg,3),y(gg,3)/)
        xx = (/(ff-(boxWidths(gg)/2.)),(ff+(boxWidths(gg)/2.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,2) = gsn_add_polyline(wks,plot,xx,yy,polyres)
    end if

        yy = (/y(gg,1),y(gg,3)/)
        xx = (/(ff-(boxWidths(gg)/2.)),(ff-(boxWidths(gg)/2.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,3) = gsn_add_polyline(wks,plot,xx,yy,polyres)
    end if

        yy = (/y(gg,2),y(gg,2)/)
        xx = (/(ff-(boxWidths(gg)/2.)),(ff+(boxWidths(gg)/2.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,4) = gsn_add_polyline(wks,plot,xx,yy,polyres)
    end if

        yy = (/y(gg,1),y(gg,3)/)
        xx = (/(ff+(boxWidths(gg)/2.)),(ff+(boxWidths(gg)/2.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,5) = gsn_add_polyline(wks,plot,xx,yy,polyres)
    end if

        yy = (/y(gg,1),y(gg,1)/)
        xx = (/(ff-(boxWidths(gg)/2.)),(ff+(boxWidths(gg)/2.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,6) = gsn_add_polyline(wks,plot,xx,yy,polyres)
    end if

        yy = (/y(gg,0),y(gg,1)/)
        xx = (/ff,ff/)
        polyres@gsLineDashPattern =0
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,7) = gsn_add_polyline(wks,plot,xx,yy,polyres)
        end if
    polyres@gsLineDashPattern = 0

        yy = (/y(gg,0),y(gg,0)/)
        xx = (/(ff-(boxWidths(gg)/8.)),(ff+(boxWidths(gg)/8.))/)
    if (.not.(any(ismissing(xx).or.ismissing(yy)))) then
           dum(gg,8) = gsn_add_polyline(wks,plot,xx,yy,polyres)
        end if
 end do

     dumname = unique_string("dum")
     plot@$dumname$ = dum
     if (isvar("xblab").eq."True") then
        ;plotres@tmXBLabels =
        plotres@tmXBLabels = xblab      ;reassign XBLabels for possible future plots
     end if
 if (maximize) then
    mres = True
    mres@gsnDraw  = False
    mres@gsnFrame = False
    maximize_output(wks,mres)
 end if
     return(plot)
end
; -----------------------------
;;#############################################################################
undef("select_region_939")
function select_region_939(region:string,lsdata:numeric)
;;
;; Arguments
;;    region: a string specifying the region to be selected.
;;
;; Return value
;;    An array with the region boundary as (lon1,lat1,lon2,lat2,lon3,lat3,lon4,lat4 ect)
;;    with the name of the region as a string attribute @name.
;;
;; Description
;;    Translates a region specification into lat/lon boundaries and a region
;;    name as an attribute.
;;
;; Modification history
begin

    funcname = "select_region_939"
    scriptname = "diag_scripts/lib/ncl/latlon.ncl"
    verbosity = stringtointeger(getenv("ESMValTool_verbosity"))
   ; enter_msg(scriptname, funcname, 10)

    if (region.eq."ALA") then
        region_array =(/(/255.000,   60.000/),\
                        (/191.978,   60.000/),\
                        (/191.978,   72.554/),\
                        (/255.000,   72.554/)/)
    end if
   if (region.eq."AMZ") then
          region_array =(/(/293.623,  -20.000/),\
                          (/280.271,  -1.239/),\
                          (/291.2,    11.439/),\
                          (/310.00,   11.439/),\
                          (/310.00,   -20.00/)/)
       end if
       if (region.eq."CAM") then
           region_array =(/(/291.2,  11.439/),\
                         (/280.271,    -1.239/),\
                         (/241.677,    28.566/),\
                         (/269.685,    28.566/)/)
       end if
       if (region.eq."CAS") then
           region_array =(/(/60.000,   30.000/),\
                           (/60.000,   50.000/),\
                           (/75.000,   50.000/),\
                           (/75.000,   30.000/)/)
       end if
       if (region.eq."CEU") then
           region_array =(/(/-10.000,    45.000/),\
                           (/-10.000,    48.000/),\
                           (/ 40.000,    61.320/),\
                           (/ 40.000,    45.000/)/)
       end if
       if (region.eq."CGI") then
          region_array =(/(/350.000,  50.000/),\
                          (/255.000,  50.000/),\
                          (/255.000,  85.000/),\
                          (/350.000,  85.000/)/)
       end if
       if (region.eq."CNA") then
          region_array =(/(/275.000,  50.000/),\
                          (/275.000,  28.566/),\
                          (/255.000,  28.566/),\
                          (/255.000,  50.000/)/)
       end if
       if (region.eq."EAF") then
          region_array =(/(/25.000,   -11.365/),\
                          (/25.000,   15.000/),\
                          (/51.990,   15.000/),\
                          (/51.990,   -11.365/)/)
       end if
       if (region.eq."EAS") then
          region_array =(/(/100.000,   20.000/),\
                          (/100.000,   50.000/),\
                          (/145.000,   50.000/),\
                          (/145.000,   20.000/)/)
       end if
       if (region.eq."ENA") then
          region_array =(/(/300.000,  25.000/),\
                          (/275.000,  25.000/),\
                          (/275.000,  50.000/),\
                          (/300.000,  50.000/)/)
       end if
       if (region.eq."MED") then
          region_array =(/(/350.000,  30.000/),\
                          (/350.000,  45.000/),\
                          (/40.000,  45.000/),\
                          (/40.000,  30.000/)/)
       end if
        if (region.eq."NAS") then
          region_array =(/(/40.000,    50.000/),\
                          (/40.000,    70.000/),\
                          (/180.000,   70.000/),\
                          (/180.000,   50.000/)/)
       end if
       if (region.eq."NAU") then
          region_array =(/(/110.000,   -30.000/),\
                          (/110.000,   -10.000/),\
                          (/155.000,   -10.000/),\
                          (/155.000,   -30.000/)/)
       end if
       if (region.eq."NEB") then
          region_array =(/(/326.000,   -20.000/),\
                          (/310.000,   -20.000/),\
                          (/310.000,    0.000/),\
                          (/326.000,    0.000/)/)
       end if
       if (region.eq."NEU") then
          region_array =(/(/350.000,   48.000/),\
                          (/350.000,   75.000/),\
                          (/40.000,   75.000/),\
                          (/40.000,   61.320/)/)
       end if
       if (region.eq."SAF") then
          region_array =(/(/350.000,   -35.000/),\
                          (/350.000,   -11.365/),\
                          (/308.01,    -11.365/),\
                          (/308.01,    -35.000/)/)
       end if
       if (region.eq."SAH") then
          region_array =(/(/340.000,  15.000/),\
                          (/340.000,  30.000/),\
                          (/ 40.000,  30.000/),\
                          (/ 40.000,  15.000/)/)
       end if
       if (region.eq."SAS") then
          region_array =(/(/60.000,   5.000/),\
                          (/60.000,   30.000/),\
                          (/100.000,  30.000/),\
                          (/100.000,  20.000/),\
                          (/95.000,   20.000/),\
                          (/95.000,   5.000/)/)
       end if
 if (region.eq."SAU") then
          region_array =(/(/110.000,   -50.000/),\
                          (/110.000,   -30.000/),\
                          (/180.000,   -30.000/),\
                          (/180.000,   -50.000/)/)
       end if
       if (region.eq."SSA") then
          region_array =(/(/320.624,   -20.000/),\
                          (/320.624,   -56.704/),\
                          (/292.652,   -56.704/),\
                          (/287.859,   -50.000/),\
                          (/293.623,   -20.000/)/)
       end if
       if (region.eq."SEA") then
          region_array =(/(/95.000,    -10.000/),\
                          (/95.000,    20.000/),\
                          (/155.000,   20.000/),\
                          (/155.000,   -10.000/)/)
       end if
       if (region.eq."TIB") then
          region_array =(/(/75.000,  30.000/),\
                          (/75.000,  50.000/),\
                          (/100.000,  50.000/),\
                          (/100.000,  30.000/)/)
       end if
       if (region.eq."WAF") then
          region_array =(/(/340.000,  -11.365/),\
                          (/340.000,  15.000/),\
                          (/25.000,   15.000/),\
                          (/25.000,   -11.365/)/)
       end if
       if (region.eq."WAS") then
          region_array =(/(/40.000,  15.000/),\
                          (/40.000,  50.000/),\
                          (/60.000,  50.000/),\
                          (/60.000,  15.000/)/)
       end if
       if (region.eq."WSA") then
                region_array =(/(/280.271,  -1.239/),\
                                (/293.623,  -20.000/),\
                                (/287.859,  -50.000/),\
                                (/292.652,  -56.704/),\
                                (/277.978,  -56.704/),\
                                (/277.978,  0.530/)/)
       end if

      if (region.eq."WNA") then
          region_array =(/(/255.000,  28.566/),\
                          (/230.000,  28.566/),\
                          (/230.000,  60.000/),\
                          (/255.000,  60.000/)/)
       end if      
        ;leave_msg(scriptname, funcname, 10)
        lat=lsdata&lat
        lon=lsdata&lon
        inout=new((/dimsizes(lsdata)/),"float")
        in=0
        inn=0      
        do ilat=0,dimsizes(lat)-1
           do ilon=0,dimsizes(lon)-1
              inou=gc_inout(lat(ilat), lon(ilon), region_array(:,1),region_array(:,0))
              if(inou.eq."True")
                inout(ilat,ilon)=1.
                in=in+1
              end if
               inn=inn+1
           end do
        end do 
   
       delete(inou)
       return(inout)

end
;;*************************************************************
undef("select_region_940")
function select_region_940(region:string,lsdata:numeric)
;;
;; Arguments
;;    region: a string specifying the region to be selected.
;;
;; Return value
;;    An array with the region boundary as (lon1,lat1,lon2,lat2,lon3,lat3,lon4,lat4 ect)
;;    with the name of the region as a string attribute @name.
;;
;; Description
;;    Translates a region specification into lat/lon boundaries and a region
;;    name as an attribute.
;;
;; Modification history
begin

    funcname = "select_region_940"
    scriptname = "diag_scripts/lib/ncl/latlon.ncl"
    verbosity = stringtointeger(getenv("ESMValTool_verbosity"))
    ;enter_msg(scriptname, funcname, 10)

    if (region.eq."Arctic") then
        region_array =(/(/0.000,   67.500/),\
                        (/360.000,  90.000/)/)
   
    end if
    if (region.eq."Antarctic") then
          region_array =(/(/0.000,  -90.000/),\
                          (/360.000,  -50.000/)/)
    end if
    if (region.eq."Caribbean") then
        region_array =(/(/291.200,   11.400/),\
                        (/274.200,   25.000/),\
                        (/300.000,   25.000/),\
                        (/300.000,   11.400/)/)
    
    end if
    if (region.eq."WesternIndianOcean") then
          region_array =(/(/52.000,  -25.000/),\
                          (/75.000,  5.000/)/)
    end if
    if (region.eq."NorthernIndianOcean") then
          region_array =(/(/60.000,  5.000/),\
                          (/95.000,  30.000/)/)
    end if
    if (region.eq."NorthernTropicalPacific") then
          region_array =(/(/155.000,  5.000/),\
                          (/210.000,  25.000/)/)
    end if
    if (region.eq."EquatorialTropicalPacific") then
          region_array =(/(/155.000,  -5.000/),\
                          (/230.000,  5.000/)/)
    end if
    if (region.eq."SouthernTropicalPacific") then
          region_array =(/(/155.000,  -25.000/),\
                          (/230.000,  -5.000/)/)
    end if
    if (region.eq."World") then
          region_array =(/(/0.000,  -90.000/),\
                          (/360.000,  90.000/)/)
    end if   

    ;leave_msg(scriptname, funcname, 10)
    lat=lsdata&lat
    lon=lsdata&lon
    inout=new((/dimsizes(lsdata)/),"float")
    in=0
    inn=0
    do ilat=0,dimsizes(lat)-1
    	do ilon=0,dimsizes(lon)-1
                  
        	if (dimsizes(region_array(:,0)).le.2) then 
             		if ((lat(ilat).ge.region_array(0,1)).and.(lat(ilat).lt.region_array(1,1)).and.(lon(ilon).ge.region_array(0,0)).and.(lon(ilon).lt.region_array(1,0))) then
                		inou="True"
                		if(inou.eq."True") then
                   			inout(ilat,ilon)=1.
                   			in=in+1
                		end if
                		delete(inou) 
                		inn=inn+1
             		end if
           	else  
            		inou=gc_inout(lat(ilat), lon(ilon), region_array(:,1),region_array(:,0))

                        if(inou.eq."True") then 
               			inout(ilat,ilon)=1.
               			in=in+1
               			delete(inou) 
            		end if
            		inn=inn+1
                end if
       	end do
    end do

    return(inout)
end
