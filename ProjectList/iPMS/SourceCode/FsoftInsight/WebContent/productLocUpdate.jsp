<%@page
	import="java.util.*, java.text.*, com.fms1.infoclass.*,com.fms1.common.*, com.fms1.web.*, com.fms1.tools.*"
	errorPage="error.jsp"
	contentType="text/html;charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Cache-Control" content="no-cache">
<SCRIPT language="javascript" src="jscript/javaFns.js"></SCRIPT>
<SCRIPT language="javascript" src="jscript/languages.js"></SCRIPT>
<SCRIPT language="javascript">
	<%@ include file="javaFns.jsp"%>
</SCRIPT>
<META http-equiv="Content-Style-Type" content="text/css">
<LINK href="stylesheet/fms.css" rel="stylesheet" type="text/css">
<TITLE>productLocUpdate.jsp</TITLE>
</HEAD><%
	LanguageChoose languageChoose = (LanguageChoose) session.getAttribute("LanguageChoose");
	int right = Security.securiPage("Size", request, response);
	//store possition of moduleID in the moduleList
	// this only use when use click UpdateNew LOC button from ModuleView.jsp page
	// and use it when user click Back button after this action we must go back ModuleView.jsp
    String vtID = request.getParameter("vtID");

	ProductLocDetailInfo locDetail = (ProductLocDetailInfo) request.getAttribute("locDetail");
	WPSizeInfo moduleInfo = locDetail.getProductDetail();
	Vector planLocList = locDetail.getPlanLocs();
	Vector actualLocList = locDetail.getActualLocs();
	int row = 0;
	int addition = 0;
	int planLocsDisplayed = 0;
	int actualLocsDisplayed = 0;
	String rowStyle;
	Boolean isSaved = (Boolean) request.getAttribute("isSaved");
%>

<BODY onload="loadPrjMenu()" class="BD"><P></P>
<P class="TITLE"> <%=languageChoose.getMessage("fi.jsp.productLocUpdate.UpdateProductLOC")%> </P><%
//
if (isSaved != null && !isSaved.booleanValue()) {%>
	<P class="Error"> <%=languageChoose.getMessage("fi.jsp.productLocUpdate.UpdateProductLOCFailed")%> </P>
<%
}
%>
<FORM name="frm" action="Fms1Servlet" method="POST">

<TABLE width="95%" cellspacing="1" class="table">
	<CAPTION class="TableCaption"> <%=languageChoose.getMessage("fi.jsp.productLocPages.PlannedProductLOC")%> </CAPTION>
	<THEAD>
		<TR class="ColumnLabel">
			<TD> # </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.Language")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocUpdate.LOCForProductivitity")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.LOCForQuality")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.MotherBody")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.Added")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.Modified")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.TotalLOC")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.ReusedLOC")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.GeneratedLOC")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.Note")%> </TD>
		</TR>
	</THEAD>
	<TBODY><%
	// Display current list (last updated data)
	for (; (row < planLocList.size() && row < ProductLocDetailInfo.LINES_MAX); row++) {
		rowStyle = (row % 2 == 0) ? "CellBGRnews" : "CellBGR3";
		ProductLocInfo loc = (ProductLocInfo) planLocList.get(row);
		%>
		<TR id="plan_row<%=row + 1%>" class="<%=rowStyle%>" valign="top">
			<TD> <%=row + 1%> <INPUT type="hidden" name="plan_product_loc_id" value="<%=loc.getProductLocId()%>"> </TD>
            <TD>
            <SELECT class="COMBO" name="plan_language" style="width=160">
                <OPTION value="-1"></OPTION>
	            <OPTION value="<%=loc.getLanguageId()%>" selected><%=loc.getLanguageName()%></OPTION>
            </SELECT>
            <A href="javascript:selectAll(document.forms[0].plan_language[<%=row%>])"> <%=languageChoose.getMessage("fi.jsp.productLocPages.More")%> </A>
            </TD>
			<TD> <%=CommonTools.formatDouble(loc.getLocProductivity())%> </TD>
			<TD> <%=CommonTools.formatDouble(loc.getLocQuality())%> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_motherBody" id="plan_motherBody<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value="<%=CommonTools.updateDouble(loc.getMotherBody())%>"> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_added" id="plan_added<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value="<%=CommonTools.updateDouble(loc.getAdded())%>"> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_modified" id="plan_modified<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value="<%=CommonTools.updateDouble(loc.getModified())%>"> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_actualLOC" id="plan_actualLOC<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value="<%=CommonTools.updateDouble(loc.getTotal())%>"> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_reused" id="plan_reused<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value="<%=CommonTools.updateDouble(loc.getReused())%>"> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_generatedLOC" id="plan_generatedLOC<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value="<%=CommonTools.updateDouble(loc.getGenerated())%>"> </TD>
			<TD> <INPUT size="15" type="text" maxlength="100" name="plan_note" id="plan_note<%=row%>" value="<%=ConvertString.toHtml(loc.getNote())%>"> </TD>
		</TR>
		<%
	}
	// If numbers of lines does not reach the minimum displaying lines => display more
	for (; (row < ProductLocDetailInfo.LINES_MIN_DISPLAY &&
			row < ProductLocDetailInfo.LINES_MAX); row++, addition++)
	{
		rowStyle = (row % 2 == 0) ? "CellBGRnews" : "CellBGR3";
	%>
		<TR id="plan_row<%=row + 1%>" class="<%=rowStyle%>" valign="top">
			<TD> <%=row + 1%> <INPUT type="hidden" name="plan_product_loc_id" value="0"> </TD>
            <TD>
            <SELECT class="COMBO" name="plan_language" style="width=160">
                <OPTION value="-1"></OPTION>
            </SELECT>
            <A href="javascript:selectAll(document.forms[0].plan_language[<%=row%>], 1)"> <%=languageChoose.getMessage("fi.jsp.productLocPages.More")%> </A>
            </TD>
			<TD>  </TD>
			<TD>  </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_motherBody" id="plan_motherBody<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_added" id="plan_added<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_modified" id="plan_modified<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_actualLOC" id="plan_actualLOC<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_reused" id="plan_reused<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_generatedLOC" id="plan_generatedLOC<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="15" type="text" maxlength="100" name="plan_note" id="plan_note<%=row%>" value=""> </TD>
		</TR><%
	}
	// If numbers of addtional lines does not reach predefined numbers of additional lines => insert more lines
	for (; (row < ProductLocDetailInfo.LINES_MAX && addition < ProductLocDetailInfo.LINES_PLUS); row++, addition++)
	{
		rowStyle = (row % 2 == 0) ? "CellBGRnews" : "CellBGR3";
		%>
		<TR id="plan_row<%=row + 1%>" class="<%=rowStyle%>" valign="top">
			<TD> <%=row + 1%> <INPUT type="hidden" name="plan_product_loc_id" value="0"> </TD>
            <TD>
            <SELECT class="COMBO" name="plan_language" style="width=160">
                <OPTION value="-1"></OPTION>
            </SELECT>
            <A href="javascript:selectAll(document.forms[0].plan_language[<%=row%>], 1)"> <%=languageChoose.getMessage("fi.jsp.productLocPages.More")%> </A>
            </TD>
			<TD>  </TD>
			<TD>  </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_motherBody" id="plan_motherBody<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_added" id="plan_added<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_modified" id="plan_modified<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_actualLOC" id="plan_actualLOC<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_reused" id="plan_reused<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_generatedLOC" id="plan_generatedLOC<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="15" type="text" maxlength="100" name="plan_note" id="plan_note<%=row%>" value=""> </TD>
		</TR><%
	}
	planLocsDisplayed = row;	// Indicate numbers of lines displayed
	// Display the rest lines
	for (; row < ProductLocDetailInfo.LINES_MAX; row++)
	{
		rowStyle = (row % 2 == 0) ? "CellBGRnews" : "CellBGR3";
		%>
		<TR id="plan_row<%=row + 1%>" class="<%=rowStyle%>" style="display:none" valign="top">
			<TD> <%=row + 1%> <INPUT type="hidden" name="plan_product_loc_id" value="0"> </TD>
            <TD>
            <SELECT class="COMBO" name="plan_language" style="width=160">
                <OPTION value="-1"></OPTION>
            </SELECT>
            <A href="javascript:selectAll(document.forms[0].plan_language[<%=row%>], 1)"> <%=languageChoose.getMessage("fi.jsp.productLocPages.More")%> </A>
            </TD>
			<TD>  </TD>
			<TD>  </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_motherBody" id="plan_motherBody<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_added" id="plan_added<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_modified" id="plan_modified<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_actualLOC" id="plan_actualLOC<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_reused" id="plan_reused<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="plan_generatedLOC" id="plan_generatedLOC<%=row%>" onchange="onChangeValue(<%=row%>, 'plan_')" value=""> </TD>
			<TD> <INPUT size="15" type="text" maxlength="100" name="plan_note" id="plan_note<%=row%>" value=""> </TD>
		</TR><%
	}
	%>
	</TBODY>
</TABLE>
<p id="plan_addMoreLink"><a href="javascript:addLanguage('plan_')"> <%=languageChoose.getMessage("fi.jsp.productLocPages.AddMoreLanguages")%> </a></p>
<BR>

<TABLE width="95%" cellspacing="1" class="table">
	<CAPTION class="TableCaption"> <%=languageChoose.getMessage("fi.jsp.productLocPages.ActualProductLOC")%> </CAPTION>
	<THEAD>
		<TR class="ColumnLabel">
			<TD> # </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.Language")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocUpdate.LOCForProductivitity")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.LOCForQuality")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.MotherBody")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.Added")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.Modified")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.TotalLOC")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.ReusedLOC")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.GeneratedLOC")%> </TD>
			<TD> <%=languageChoose.getMessage("fi.jsp.productLocPages.Note")%> </TD>
		</TR>
	</THEAD>
	<TBODY><%
	// Reset for actual LOCs
	row = 0;
	addition = 0;
	// Display current list (last updated data)
	for (; (row < actualLocList.size() && row < ProductLocDetailInfo.LINES_MAX); row++) {
		rowStyle = (row % 2 == 0) ? "CellBGRnews" : "CellBGR3";
		ProductLocInfo loc = (ProductLocInfo) actualLocList.get(row);
		%>
		<TR id="row<%=row + 1%>" class="<%=rowStyle%>" valign="top">
			<TD> <%=row + 1%> <INPUT type="hidden" name="product_loc_id" value="<%=loc.getProductLocId()%>"> </TD>
            <TD>
            <SELECT class="COMBO" name="language" style="width=160">
                <OPTION value="-1"></OPTION>
	            <OPTION value="<%=loc.getLanguageId()%>" selected><%=loc.getLanguageName()%></OPTION>
            </SELECT>
            <A href="javascript:selectAll(document.forms[0].language[<%=row%>])"> <%=languageChoose.getMessage("fi.jsp.productLocPages.More")%> </A>
            </TD>
			<TD> <%=CommonTools.formatDouble(loc.getLocProductivity())%> </TD>
			<TD> <%=CommonTools.formatDouble(loc.getLocQuality())%> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="motherBody" id="motherBody<%=row%>" onchange="onChangeValue(<%=row%>, '')" value="<%=CommonTools.updateDouble(loc.getMotherBody())%>"> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="added" id="added<%=row%>" onchange="onChangeValue(<%=row%>, '')" value="<%=CommonTools.updateDouble(loc.getAdded())%>"> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="modified" id="modified<%=row%>" onchange="onChangeValue(<%=row%>, '')" value="<%=CommonTools.updateDouble(loc.getModified())%>"> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="actualLOC" id="actualLOC<%=row%>" onchange="onChangeValue(<%=row%>, '')" value="<%=CommonTools.updateDouble(loc.getTotal())%>"> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="reused" id="reused<%=row%>" onchange="onChangeValue(<%=row%>, '')" value="<%=CommonTools.updateDouble(loc.getReused())%>"> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="generatedLOC" id="generatedLOC<%=row%>" onchange="onChangeValue(<%=row%>, '')" value="<%=CommonTools.updateDouble(loc.getGenerated())%>"> </TD>
			<TD> <INPUT size="15" type="text" maxlength="100" name="note" id="note<%=row%>" onchange="onChangeValue(<%=row%>, '')" value="<%=ConvertString.toHtml(loc.getNote())%>"> </TD>
		</TR>
		<%
	}
	// If numbers of lines does not reach the minimum displaying lines => display more
	for (; (row < ProductLocDetailInfo.LINES_MIN_DISPLAY &&
			row < ProductLocDetailInfo.LINES_MAX); row++, addition++)
	{
		rowStyle = (row % 2 == 0) ? "CellBGRnews" : "CellBGR3";
	%>
		<TR id="row<%=row + 1%>" class="<%=rowStyle%>" valign="top">
			<TD> <%=row + 1%> <INPUT type="hidden" name="product_loc_id" value="0"> </TD>
            <TD>
            <SELECT class="COMBO" name="language" style="width=160">
                <OPTION value="-1"></OPTION>
            </SELECT>
            <A href="javascript:selectAll(document.forms[0].language[<%=row%>], 1)"> <%=languageChoose.getMessage("fi.jsp.productLocPages.More")%> </A>
            </TD>
			<TD>  </TD>
			<TD>  </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="motherBody" id="motherBody<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="added" id="added<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="modified" id="modified<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="actualLOC" id="actualLOC<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="reused" id="reused<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="generatedLOC" id="generatedLOC<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="15" type="text" maxlength="100" name="note" id="note<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
		</TR><%
	}
	// If numbers of addtional lines does not reach predefined numbers of additional lines => insert more lines
	for (; (row < ProductLocDetailInfo.LINES_MAX && addition < ProductLocDetailInfo.LINES_PLUS); row++, addition++)
	{
		rowStyle = (row % 2 == 0) ? "CellBGRnews" : "CellBGR3";
		%>
		<TR id="row<%=row + 1%>" class="<%=rowStyle%>" valign="top">
			<TD> <%=row + 1%> <INPUT type="hidden" name="product_loc_id" value="0"> </TD>
            <TD>
            <SELECT class="COMBO" name="language" style="width=160">
                <OPTION value="-1"></OPTION>
            </SELECT>
            <A href="javascript:selectAll(document.forms[0].language[<%=row%>], 1)"> <%=languageChoose.getMessage("fi.jsp.productLocPages.More")%> </A>
            </TD>
			<TD>  </TD>
			<TD>  </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="motherBody" id="motherBody<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="added" id="added<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="modified" id="modified<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="actualLOC" id="actualLOC<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="reused" id="reused<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="generatedLOC" id="generatedLOC<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="15" type="text" maxlength="100" name="note" id="note<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
		</TR><%
	}
	actualLocsDisplayed = row;	// Indicate numbers of lines displayed
	// Display the rest lines
	for (; row < ProductLocDetailInfo.LINES_MAX; row++)
	{
		rowStyle = (row % 2 == 0) ? "CellBGRnews" : "CellBGR3";
		%>
		<TR id="row<%=row + 1%>" class="<%=rowStyle%>" style="display:none" valign="top">
			<TD> <%=row + 1%> <INPUT type="hidden" name="product_loc_id" value="0"> </TD>
            <TD>
            <SELECT class="COMBO" name="language" style="width=160">
                <OPTION value="-1"></OPTION>
            </SELECT>
            <A href="javascript:selectAll(document.forms[0].language[<%=row%>], 1)"> <%=languageChoose.getMessage("fi.jsp.productLocPages.More")%> </A>
            </TD>
			<TD>  </TD>
			<TD>  </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="motherBody" id="motherBody<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="added" id="added<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="modified" id="modified<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="actualLOC" id="actualLOC<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="reused" id="reused<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="7" type="text" maxlength="10" name="generatedLOC" id="generatedLOC<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
			<TD> <INPUT size="15" type="text" maxlength="100" name="note" id="note<%=row%>" onchange="onChangeValue(<%=row%>, '')" value=""> </TD>
		</TR><%
	}
	%>
	</TBODY>
</TABLE>
<p id="addMoreLink"><a href="javascript:addLanguage()"> <%=languageChoose.getMessage("fi.jsp.productLocPages.AddMoreLanguages")%> </a></p>
<BR>

<P>
<%
if (right == 3) {
%>
<INPUT type="button" class="BUTTON" onclick="onUpdate()" name="Update" value=" <%=languageChoose.getMessage("fi.jsp.button.OK")%> "><%
}
%>
<INPUT type="button" class="BUTTON" name="back" value=" <%=languageChoose.getMessage("fi.jsp.button.Cancel")%> " onclick="doBack()">
</P>
<INPUT type="hidden" name="reqType">
<INPUT type="hidden" name="product" value="<%=moduleInfo.moduleID%>">
</FORM>
<BR>
<SCRIPT language="javascript">
var form = document.forms[0];

function onUpdate() {
    if (isValidForm()) {
    	enableAllElements();
		document.frm.reqType.value = "<%=Constants.PRODUCT_LOC_UPDATE_SAVE%>";
		document.frm.submit();
    }
}

var nextHiddenIndex = <%=actualLocsDisplayed + 1%>;
var plan_nextHiddenIndex = <%=planLocsDisplayed + 1%>;
function addLanguage(prefix) {
    if (prefix == null || prefix == '') {
        getFormElement("row" + nextHiddenIndex).style.display = document.all ? "block" : "table-row";
	    nextHiddenIndex++;
	    if(nextHiddenIndex > <%=ProductLocDetailInfo.LINES_MAX%>)
	        getFormElement("addMoreLink").style.display = "none";
    }
    else {
        getFormElement("plan_row" + plan_nextHiddenIndex).style.display = document.all ? "block" : "table-row";
	    plan_nextHiddenIndex++;
	    if(plan_nextHiddenIndex > <%=ProductLocDetailInfo.LINES_MAX%>)
	        getFormElement("plan_addMoreLink").style.display = "none";
	}
}

function fillCommonLanguages() {
    for (var i=0;i<document.forms[0].language.length;i++) {
        // Fill common languages
        resetAndFillLanguages(document.forms[0].plan_language[i], false, document.forms[0].plan_language[i].value, 2);
        resetAndFillLanguages(document.forms[0].language[i], false, document.forms[0].language[i].value, 2);
    }
}

// Reset and fill all languages taken from all_lang array
function selectAll(combo, startIndex) {
    if (startIndex) {
    	resetAndFillLanguages(combo, true, null, startIndex);
    }
    // Keep last value so remove from 3rd option
    else {
	    resetAndFillLanguages(combo, true, null, 2);
    }
}

function doBack(){
	<%if (vtID == null){%>
		// in this case: User go to this page from productLocList.jsp
			 frm.reqType.value = <%=Constants.PRODUCT_LOC_LIST%>;
	<%}else{%>
		// in this case: User go to this page from moduleView.jsp
		frm.action = "Fms1Servlet?reqType=<%=Constants.MODULE_DETAIL%>&vtID=<%=vtID%>";
	<%}%>
		frm.submit();
}

// Check data constraints between numbers (after checked they input positive integer numbers)
function isValidConstraint(motherBody, added, modified, actualLOC, reused, generatedLOC) {
	var result = true;
	// If filled Total LOC and Reused LOC then Reused LOC must be <= Total LOC
	if (actualLOC.value.length > 0 && reused.value.length > 0 &&
		(parseInt(actualLOC.value) < parseInt(reused.value)))
	{
		alert(getParamText(new Array(
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.CannotGreaterThan")%>",
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.ReusedLOC")%>",
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.TotalLOC")%>")));
		reused.focus();
		result = false;
	}
	// If filled reused LOC then total LOC should be filled also
	else if (reused.value.length > 0 && actualLOC.value.length <= 0) {
		alert(getParamText(new Array(
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.CannotGreaterThan")%>",
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.ReusedLOC")%>",
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.TotalLOC")%>")));
		actualLOC.focus();
		result = false;
	}
	// If above condition failed
	if (!result) {
		return result;
	}
	
	// If filled added and Generated LOC then Generated LOC must be <= added
	if (added.value.length > 0 && generatedLOC.value.length > 0 &&
		(parseInt(added.value) < parseInt(generatedLOC.value)))
	{
		alert(getParamText(new Array(
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.CannotGreaterThan")%>",
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.GeneratedLOC")%>",
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.Added")%>")));
		generatedLOC.focus();
		result = false;
	}
	// If filled Total LOC and Generated LOC then Generated LOC must be <= Total LOC
	else if (actualLOC.value.length > 0 && generatedLOC.value.length > 0 &&
		(parseInt(actualLOC.value) < parseInt(generatedLOC.value)))
	{
		alert(getParamText(new Array(
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.CannotGreaterThan")%>",
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.GeneratedLOC")%>",
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.TotalLOC")%>")));
		generatedLOC.focus();
		result = false;
	}
	// If filled generated LOC then added should be filled also
	else if (generatedLOC.value.length > 0 && added.value.length <= 0 && actualLOC.value.length <= 0) {
		alert(getParamText(new Array(
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.CannotGreaterThan")%>",
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.GeneratedLOC")%>",
				"<%=languageChoose.getMessage("fi.jsp.productLocPages.Added")%>")));
		added.focus();
		result = false;
	}
	return result;
}
// Validate a selected line. If selected a language then at least one value should be filled
function isValidData(motherBody, added, modified, actualLOC, reused, generatedLOC) {
	var result = true;
	// If selected a language then should fill other data
	if (motherBody.value.length == 0 &&
		added.value.length == 0 &&
		modified.value.length == 0 &&
		actualLOC.value.length == 0 &&
		reused.value.length == 0 &&
		generatedLOC.value.length == 0)
	{
		alert("<%=languageChoose.getMessage("fi.jsp.productLocPages.PleaseFillUpData")%>");
		motherBody.focus();
		result = false;
	}
	// Check all numbers are positive integer numbers
	else if (
		!positiveInt(motherBody,"<%=languageChoose.getMessage("fi.jsp.productLocPages.MotherBody")%>") ||
		!positiveInt(added,"<%=languageChoose.getMessage("fi.jsp.productLocPages.Added")%>") ||
		!positiveInt(modified,"<%=languageChoose.getMessage("fi.jsp.productLocPages.Modified")%>") ||
		!positiveInt(actualLOC,"<%=languageChoose.getMessage("fi.jsp.productLocPages.TotalLOC")%>") ||
		!positiveInt(reused,"<%=languageChoose.getMessage("fi.jsp.productLocPages.ReusedLOC")%>") ||
		!positiveInt(generatedLOC,"<%=languageChoose.getMessage("fi.jsp.productLocPages.GeneratedLOC")%>"))
	{
		result = false;
	}
	// Check data relation
	else if (!isValidConstraint(motherBody, added, modified, actualLOC, reused, generatedLOC)) {
		result = false;
	}
	return result;
}

function isBlank(
	motherBody, added, modified, actualLOC, reused, generatedLOC, note)
{
	return (trim(motherBody.value).length <= 0 &&
			trim(added.value).length <= 0 &&
			trim(modified.value).length <= 0 &&
			trim(actualLOC.value).length <= 0 &&
			trim(reused.value).length <= 0 &&
			trim(generatedLOC.value).length <= 0 &&
			trim(note.value).length <= 0);
}
// Form validation, check when user selected a language. Each selected language
// should contain either {mother body, added, modified} or {total, reused}
function isValidForm() {
    var result = true;
	var motherBody, added, modified, actualLOC, reused, generatedLOC, note;
	var plan_deleteIndex = -1;
	var plan_deleteItems = "";	// Deleting lines
	var deleteIndex = -1;
	var deleteItems = "";	// Deleting lines
	var plan_notSelectedIndex = -1;
	var plan_notSelectedItems = "";	// Filled information but not selected languages
	var notSelectedIndex = -1;
	var notSelectedItems = "";	// Filled information but not selected languages
    for (i = 0; i < (plan_nextHiddenIndex - 1); i++) {
		motherBody = document.frm.plan_motherBody[i];
		added = document.frm.plan_added[i];
		modified = document.frm.plan_modified[i];
		actualLOC = document.frm.plan_actualLOC[i];
		reused = document.frm.plan_reused[i];
		generatedLOC = document.frm.plan_generatedLOC[i];
		note = document.frm.plan_note[i];
    	// Selected a language
    	if (document.frm.plan_language[i].value > 0) {
			if (!isValidData(
				motherBody, added, modified, actualLOC, reused, generatedLOC))
			{
    			result = false;
    			break;
			}
    	}
    	// Not selected a language but filled other data
    	else if (document.frm.plan_product_loc_id[i].value <= 0 &&
    		!isBlank(motherBody, added, modified, actualLOC, reused, generatedLOC, note))
    	{
    		plan_notSelectedItems = plan_notSelectedItems + (i + 1) + "  ";
    		if (plan_notSelectedIndex == -1) {
    			plan_notSelectedIndex = i;
    		}
    	}
		// Trying to delete a language LOC, mark this line for confirm later
		else if (document.frm.plan_product_loc_id[i].value > 0) {
			plan_deleteItems = plan_deleteItems + (i + 1) + "  ";
			if (plan_deleteIndex == -1) {
				plan_deleteIndex = i;
			}
		}
    }
    // If above checks is invalid => return result(false)
    if (!result) {
    	return result;
    }

    for (i = 0; i < (nextHiddenIndex - 1); i++) {
		motherBody = document.frm.motherBody[i];
		added = document.frm.added[i];
		modified = document.frm.modified[i];
		actualLOC = document.frm.actualLOC[i];
		reused = document.frm.reused[i];
		generatedLOC = document.frm.generatedLOC[i];
		note = document.frm.note[i];
    	// Selected a language
    	if (document.frm.language[i].value > 0) {
			if (!isValidData(
				motherBody, added, modified, actualLOC, reused, generatedLOC))
			{
    			result = false;
    			break;
			}
    	}
    	// Not selected a language but filled other data
    	else if (document.frm.product_loc_id[i].value <= 0 &&
    		!isBlank(motherBody, added, modified, actualLOC, reused, generatedLOC, note))
    	{
    		notSelectedItems = notSelectedItems + (i + 1) + "  ";
    		if (notSelectedIndex == -1) {
    			notSelectedIndex = i;
    		}
    	}
		// Trying to delete a language LOC, mark this line to confirm later
		else if (document.frm.product_loc_id[i].value > 0) {
			deleteItems = deleteItems + (i + 1) + "  ";
			if (deleteIndex == -1) {
				deleteIndex = i;
			}
		}
    }
    // If above checks is invalid => return result(false)
    if (!result) {
    	return result;
    }
    
	// Not selected a language but filled other data
    if (plan_notSelectedIndex >= 0 || notSelectedIndex >= 0) {
    	var msg = "<%=languageChoose.getMessage("fi.jsp.productLocPages.NotSelectedALanguage")%>\n";
    	if (plan_notSelectedIndex >= 0) {
    		msg += "<%=languageChoose.getMessage("fi.jsp.productLocPages.PlanProductLocAtLine")%> " + plan_notSelectedItems + "\n";
    	}
    	if (notSelectedIndex >= 0) {
    		msg += "<%=languageChoose.getMessage("fi.jsp.productLocPages.ActualProductLocAtLine")%> " + notSelectedItems + "\n";
    	}
    	msg += "<%=languageChoose.getMessage("fi.jsp.productLocPages.TheyWillNotBeSaved")%>";
    	result = window.confirm(msg);
    	if (!result) {
    		if (plan_notSelectedIndex >= 0) {
    			document.frm.plan_language[plan_notSelectedIndex].focus();
    		}
    		else if (notSelectedIndex >= 0) {
    			document.frm.language[notSelectedIndex].focus();
    		}
    	}
    }
    // If above checks is invalid => return result(false)
    if (!result) {
    	return result;
    }

    // Trying to remove some lines
    if (plan_deleteIndex >= 0 || deleteIndex >= 0) {
    	var msg = "<%=languageChoose.getMessage("fi.jsp.productLocPages.AreYouSureToDelete")%>\n";
    	if (plan_deleteIndex >= 0) {
    		msg += "<%=languageChoose.getMessage("fi.jsp.productLocPages.PlanProductLocAtLine")%> " + plan_deleteItems + "\n";
    	}
    	if (deleteIndex >= 0) {
    		msg += "<%=languageChoose.getMessage("fi.jsp.productLocPages.ActualProductLocAtLine")%> " + deleteItems;
    	}
    	result = window.confirm(msg);
    	if (!result) {
    		if (plan_deleteIndex >= 0) {
    			document.frm.plan_language[plan_deleteIndex].focus();
    		}
    		else if (deleteIndex >= 0) {
    			document.frm.language[deleteIndex].focus();
    		}
    	}
    }
    return result;
}

/* Allow user to enter EITHER mother body, added, modified OR Total LOC, Reused LOC*/
var disableColor = "#D3D3D3";
function onChangeValue(i, type) {
	if (type =='plan_') {
		motherBody = document.frm.plan_motherBody[i];
		added = document.frm.plan_added[i];
		modified = document.frm.plan_modified[i];
		actualLOC = document.frm.plan_actualLOC[i];
		reused = document.frm.plan_reused[i];
		generatedLOC = document.frm.plan_generatedLOC[i];
	}
	else {
		motherBody = document.frm.motherBody[i];
		added = document.frm.added[i];
		modified = document.frm.modified[i];
		actualLOC = document.frm.actualLOC[i];
		reused = document.frm.reused[i];
		generatedLOC = document.frm.generatedLOC[i];
	}
	
	actualLOC.disabled = false;
	reused.disabled = false;
	motherBody.disabled = false;
	added.disabled = false;
	modified.disabled = false;
	getFormElement(type + "actualLOC" + i).style.backgroundColor = "";
	getFormElement(type + "reused" + i).style.backgroundColor = "";
	getFormElement(type + "motherBody" + i).style.backgroundColor = "";
	getFormElement(type + "added" + i).style.backgroundColor = "";
	getFormElement(type + "modified" + i).style.backgroundColor = "";
	
	if (trim(motherBody.value).length > 0 || trim(added.value).length > 0 ||
		trim(modified.value).length > 0)
	{
		actualLOC.disabled = true;
		reused.disabled = true;
		getFormElement(type + "actualLOC" + i).style.backgroundColor = disableColor;
		getFormElement(type + "reused" + i).style.backgroundColor = disableColor;
	}
	else if (trim(actualLOC.value).length > 0 || trim(reused.value).length > 0) {
		motherBody.disabled = true;
		added.disabled = true;
		modified.disabled = true;
		getFormElement(type + "motherBody" + i).style.backgroundColor = disableColor;
		getFormElement(type + "added" + i).style.backgroundColor = disableColor;
		getFormElement(type + "modified" + i).style.backgroundColor = disableColor;
	}
}

/* Enable all text boxes after disabled them for correct the elements' indexes */
function enableAllElements() {
    for (i = 0; i < (plan_nextHiddenIndex - 1); i++) {
		document.frm.plan_motherBody[i].disabled = false;
		document.frm.plan_added[i].disabled = false;
		document.frm.plan_modified[i].disabled = false;
		document.frm.plan_actualLOC[i].disabled = false;
		document.frm.plan_reused[i].disabled = false;
	}
    for (i = 0; i < (nextHiddenIndex - 1); i++) {
		document.frm.motherBody[i].disabled = false;
		document.frm.added[i].disabled = false;
		document.frm.modified[i].disabled = false;
		document.frm.actualLOC[i].disabled = false;
		document.frm.reused[i].disabled = false;
	}
}

function setDefaultDisableElements() {
    for (i = 0; i < (plan_nextHiddenIndex - 1); i++) {
    	onChangeValue(i, 'plan_');
	}
    for (i = 0; i < (nextHiddenIndex - 1); i++) {
    	onChangeValue(i, '');
	}
}

var objToHide = new Array();	// Elements to be hidden when popup menu
function init() {
	// Fill combo boxes
	fillCommonLanguages();
    if(nextHiddenIndex > <%=ProductLocDetailInfo.LINES_MAX%>) {
        getFormElement("addMoreLink").style.display = "none";
    }
    if(plan_nextHiddenIndex > <%=ProductLocDetailInfo.LINES_MAX%>) {
        getFormElement("plan_addMoreLink").style.display = "none";
    }

	var hideIndex = 0;
	for (i = 0; i < <%=ProductLocDetailInfo.LINES_MAX%>; i++) {
		objToHide[hideIndex++] = form.language[i];
	}
	for (i = 0; i < <%=ProductLocDetailInfo.LINES_MAX%>; i++) {
		objToHide[hideIndex++] = form.plan_language[i];
	}

	setDefaultDisableElements();
}

// Init form appearance
init();

</SCRIPT>
</BODY>
</HTML>